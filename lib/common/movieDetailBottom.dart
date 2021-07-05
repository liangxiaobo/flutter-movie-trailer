import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/common/slideWidget.dart';
import 'package:flutter_movie/models/movieDetailModel.dart';
import 'package:flutter_movie/page/movieDetail.dart';

import 'movieDetailSummary.dart';

class MovieDetailBottom extends StatefulWidget {
  final MovieDetailModel movieDetail;

  MovieDetailBottom({Key? key, required this.movieDetail}): super(key: key);
  @override
  _MovieDetailBottomState createState() => _MovieDetailBottomState();
}

class _MovieDetailBottomState extends State<MovieDetailBottom> {
  bool showSummary = false;

  @override
  Widget build(BuildContext context) {
    String movieTypes = widget.movieDetail.movie.movieTypes.map((e) => e.name).toList().join('/');
    return Stack(
      children: [
        Container(
          color: Color(0xfff5f5f5),
          child: Column(
            children: [
              Container(
                color: Colors.white70,
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.movieDetail.movie.title,
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black87),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          /* 显示简介 */
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showSummary = true;
                              });
                            },
                            child: Row(
                              children: [
                                Text('简介', style: TextStyle(fontSize: 18, color: Colors.black54),),
                                Icon(Icons.keyboard_arrow_right, size: 25, color: Colors.black54,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child:  Row(
                        children: [
                          Text("${widget.movieDetail.movie.rate}分 · $movieTypes · ${widget.movieDetail.movie.duration}", style: TextStyle(fontSize: 17, color: Colors.black87),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(child: Container(
                color: Colors.white70,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.all(10),
                            child: Text(
                              '相关推荐',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),

                      RelativeMovie(movies: widget.movieDetail.relativeMovies,),
                    ],
                  ),
                ),
              ),
              ),
            ],
          ),
        ),

        // 弹出窗
        Positioned(
          child: SlideWidget(
            show: showSummary,
            child: Container(
              color: Colors.white,
              child: MovieDetailSummary(widget.movieDetail.movie, (show) => _changeShowSummary(show)),
              ),
            ),
          ),
      ],
    );
  }

  /// 为了让子组能够修改当前父组件中的showSummary变量，
  /// 故，在父组件中定义可以修改的方法，传递给子组件，
  /// 方可实现子组件修改父组件的变量
  _changeShowSummary(bool show) {
    setState(() {
      showSummary = show;
    });
  }
}