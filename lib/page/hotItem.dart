import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/models/publicMovieItem.dart';
import 'package:flutter_movie/page/moreMovie.dart';
import 'package:flutter_movie/page/movieDetail.dart';

class HotItem extends StatelessWidget {
  final PublicMovieItem? item;
  final String title;
  final int type;

  HotItem({Key? key, required this.title, this.item, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    print("子组件中: ${item!.toJson()}");
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          child: Row(
            children: [
              Text(title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
              ),
              Expanded(child: SizedBox()),
              GestureDetector(
                child: Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.black87,),
                onTap: () {
                  Navigator.pushNamed(context, MoreMovie.routeName, arguments: type);
                },
              )
            ],
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 5,
                crossAxisSpacing: 2,
                childAspectRatio: 0.6
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: item!.movies.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                child: GestureDetector(
                  onTap: () {
                    print("当前点击的电影是第 $index个");
                    Navigator.pushNamed(context, MovieDetail.routeName, arguments: item!.movies[index].id);
                    // Navigator.pushNamed(context, '/test/video', arguments: item!.movies[index].id);
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Image.network(item!.movies[index].poster, fit: BoxFit.fill,),
//                            FadeInImage.assetNetwork(
//                              placeholder: 'images/img-loading.png',
//                              image: item!.movies[index].poster,
//                              fit: BoxFit.fitHeight,
//                              height: 120,
//                            ),
                            Positioned(
                              right: 5,
                              bottom: 3,
                              child: Text(item!.movies[index].rate,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.orange[500]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          item!.movies[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }

}