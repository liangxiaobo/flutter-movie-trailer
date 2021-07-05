import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/common/publicMovieListItem.dart';
import 'package:flutter_movie/http/http.dart';
import 'package:flutter_movie/http/url.dart';
import 'package:flutter_movie/models/categoryModel.dart';
import 'package:flutter_movie/models/movieModel.dart';

class Category extends StatefulWidget {
  late int? status;
  final List<int>? rate;
  Category({Key? key, this.status, this.rate}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with AutomaticKeepAliveClientMixin {
  List<MovieModel> list = <MovieModel>[];
  late bool isLoad = true;
  late Future<Response> futureResponse;
  late String typeLabel = '全部';
  late List<int> cateoryIds = <int>[];

  void _showModalBottomSheet(BuildContext context, int type) {
    showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return BottomSheetContent(
            type: type,
            typeIndex: widget.status,
            cateoryIds: cateoryIds,
            functionChangeTypeIndex: changeTypeIndex,
            functionChangeCateoryIds: changeCateoryIds,
          );
        });
  }

  void changeTypeIndex(typeIndex) {
    setState(() {
      widget.status = typeIndex;
//      list.clear();
      getData();
    });
  }

  void changeCateoryIds(List<int> list) {
    setState(() {
      cateoryIds = list;
      print("分类ids = $list");
      getData();
    });
  }

  Future<Response> getData() async {
//    setState(() {
//      isLoad = true;
//    });
//    list.clear();
    Map<String, dynamic> queryParam = {};

    switch (widget.status) {
      case 0:
        queryParam = {'rate': "${widget.rate}", 'status': ''};
        typeLabel = '全部';
        break;
      case 1:
        queryParam = {'rate': "${widget.rate}", 'status': widget.status};
        typeLabel = '已上映';
        break;
      case 2:
        queryParam = {'status': 0};
        typeLabel = '未上映';
        break;
    }

    if (cateoryIds.length > 0) queryParam['categories'] = "${cateoryIds}";

    final Response response =
        await dio.get(apiUrl['movie'] as String, queryParameters: queryParam);

    print(response.realUri);

    setState(() {
      list = ((response.data['data'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e))
          .toList());
    });

//    setState(() {
//      isLoad = false;
//    });

    return response;
  }

  @override
  void initState() {
    futureResponse = getData();
    widget.status = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _showModalBottomSheet(context, 1);
                },
                child: Row(
                  children: [
                    Text(
                      '分类',
                      style: TextStyle(color: Colors.black87),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.black87),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 15,
                color: Colors.grey,
                child: SizedBox(),
              ),
              /* 全部 已上映 未上映*/
              GestureDetector(
                onTap: () {
                  _showModalBottomSheet(context, 2);
                },
                child: Row(
                  children: [
                    Text(
                      typeLabel,
                      style: TextStyle(color: Colors.black87),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.black87),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 15,
                color: Colors.grey,
                child: SizedBox(),
              ),

              /* 评分 */
              Row(
                children: [
                  Text(
                    '评分',
                    style: TextStyle(color: Colors.black87),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.black87),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
        ),
        Expanded(child: FutureBuilder(
            future: futureResponse,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print("list 的长度 ${list.length}");
                if (list.length == 0) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('没有数据'),
                  );
                }
                return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return PublicMovieListItem(movie: list[i]);
                    },
                  );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BottomSheetContent extends StatefulWidget {
  BottomSheetContent(
      {Key? key,
      required this.type,
      this.typeIndex,
        this.cateoryIds,
      this.functionChangeTypeIndex,
      this.functionChangeCateoryIds})
      : super(key: key);
  final int type;
  final int? typeIndex;
  //分类id
  late List<int>? cateoryIds;
  final functionChangeTypeIndex;
  final functionChangeCateoryIds;

  @override
  State<StatefulWidget> createState() => _BottomSheetContent();
}

class _BottomSheetContent extends State<BottomSheetContent> {
  late Future<List<CategoryModel>> futureCategory;
  late int typeIndex = 0;
  late List<int>? cateoryIds = <int>[];

  // 获取分类数据
  Future<List<CategoryModel>> getCategoryDate() async {
    final Response response = await dio.get(apiUrl['category'] as String);

    return (response.data['data'] as List<dynamic>)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }

  @override
  void initState() {
    futureCategory = getCategoryDate();
    typeIndex = widget.typeIndex!;

    cateoryIds = widget.cateoryIds ?? <int>[];

    super.initState();
  }

  /// 分类查询
  Widget _buildCategory() {
    return FutureBuilder<List<CategoryModel>>(
        future: futureCategory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              constraints: BoxConstraints(minHeight: 200, maxHeight: 350),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          '分类管理',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    alignment: WrapAlignment.start,
                    children: snapshot.data!.map((item) {

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            cateoryIds!.contains(item.id) ? cateoryIds!.remove(item.id) : cateoryIds!.add(item.id as int);
                            widget.functionChangeCateoryIds(cateoryIds);
                          });
                        },
                        child: cateoryIds!.contains(item.id)? Chip(
                          backgroundColor: Colors.orange[500],
                          label: Text("${item.name}", style: TextStyle(color: Colors.white70),),
                        ) : Chip(
                          label: Text("${item.name}",),
                        ),
                      );
                    }).toList()

//                    [
//                      for (final item in snapshot.data!)
//                        Chip(
//                          backgroundColor: Colors.red,
//                          label: Text("${item.name}"),
//                        )
//                    ],
                  ),
                ],
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  /// 全部 已上映 未上映
  Widget _buildRelease() {
    return Container(
      height: 180,
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                typeIndex = 0;
                widget.functionChangeTypeIndex!(typeIndex);
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  typeIndex == 0
                      ? SizedBox(
                          width: 30,
                          child: Icon(Icons.done),
                        )
                      : SizedBox(
                          width: 30,
                        ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '全部',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              setState(() {
                typeIndex = 1;
                widget.functionChangeTypeIndex!(typeIndex);
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  typeIndex == 1
                      ? SizedBox(
                          width: 30,
                          child: Icon(Icons.done),
                        )
                      : SizedBox(
                          width: 30,
                        ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '已上映',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              setState(() {
                typeIndex = 2;
                widget.functionChangeTypeIndex!(typeIndex);
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  typeIndex == 2
                      ? SizedBox(
                          width: 30,
                          child: Icon(Icons.done),
                        )
                      : SizedBox(
                          width: 30,
                        ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '未上映',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 1:
        return _buildCategory();
      case 2:
        return _buildRelease();
      case 3:
        // TODO: 评分的业务逻辑
    }
    return Text('失误');
  }
}
