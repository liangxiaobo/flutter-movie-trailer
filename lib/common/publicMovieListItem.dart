import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/models/movieModel.dart';
import 'package:flutter_movie/page/movieDetail.dart';

class PublicMovieListItem extends StatelessWidget {
  final MovieModel movie;
  final int? index;
  PublicMovieListItem({Key? key, required this.movie, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MovieDetail.routeName, arguments: movie.id);
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            /// TODO: 当变量$index 不为空时，显示排名序号
//            Text("$index", style: TextStyle(fontSize: 12,color: Colors.black87,),),
            /// 需要增加图片占位符，或使用缓存图片 ('CachedNetworkImage' 需要引入包https://pub.flutter-io.cn/packages/cached_network_image)
            /// 使用 FadeInImage 实现淡入效果
            FadeInImage.assetNetwork(
              placeholder: 'images/img-loading.png',
              image: movie.poster,
              fit: BoxFit.fill,
              height: 108,
            ),
            Expanded(
              child:
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Container(
                  height: 108,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(movie.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis,),
                          movie.rate !="" ?
                          Row(
                            children: [
                              Text("观众评: ",
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87
                                ),
                              ),
                              Text(movie.rate,
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.orange[500]
                                ),
                              )
                            ],
                          )
                              :
                          Text("上映时间: ${movie.pubdate}",
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87
                            ),
                          ),
                          Text("主演: ${movie.casts.length > 0 ? movie.casts.map((e) => e.name).toList().join(','): '未知'}",
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text("时长: ${movie.duration != "" ? movie.duration: '未知'}",
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87
                              ),
                            ),
                          ),
                        ],
                      ),
                      /// 显示横线
                      Container(
                        height: 0.6,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }

}