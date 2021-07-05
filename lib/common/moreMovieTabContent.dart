import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/common/publicMovieListItem.dart';
import 'package:flutter_movie/http/http.dart';
import 'package:flutter_movie/http/url.dart';
import 'package:flutter_movie/models/movieModel.dart';

class MoreMovieTabContent extends StatefulWidget {
  final int status;
  MoreMovieTabContent({Key? key, required this.status}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoreMovieTabContentState();
  }

}

class _MoreMovieTabContentState extends State<MoreMovieTabContent> with AutomaticKeepAliveClientMixin {
  late int count;
  List<MovieModel> list = <MovieModel>[];
  late int page = 0;
  late int pageSize = 10;
  late bool isLoad = true;

  late Future<Response> futureResponse;
  ScrollController _scrollController = ScrollController();

  Future<Response> getData(page) async {
    setState(() {
      isLoad = true;
    });
    final Response response = await dio.get(
        apiUrl['moreMovie'] as String,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          'status': widget.status
        });

    count = response.data['data']['total'];
    list.addAll((response.data['data']['list'] as List<dynamic>).map((e) => MovieModel.fromJson(e)).toList());

    setState(() {
      isLoad = false;
    });
    print("开始请求数据:");

    return response;
  }

  @override
  void initState() {
    futureResponse = getData(0);
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('滑动到底了');
        /// 当list的长度相等于数据总时，不再请求接口
        if (count > list.length) {
          setState(() {
            getData(++page);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: futureResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: list.length+1,
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (context, i) {

//                print("加载元素第$i行");
                /// 当最后一位是总数的最后一位，显示没有数据了
                if (i == count) {

                  return Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Center(
                      child: Text('没有数据了',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  );

                }

                /// 当正在请求数据时，显示加载的提示图标
                if (i == list.length) {
                  return Center(
                    child: Opacity(
                      opacity: isLoad ? 1.0 : 0.0,
                      child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(),),
                    ),
                  );
                }

                return PublicMovieListItem(movie: list[i]);
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

 

  @override
  bool get wantKeepAlive => true;

}