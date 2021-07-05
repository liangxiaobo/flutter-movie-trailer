import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/common/movieDetailBottom.dart';
import 'package:flutter_movie/common/slideWidget.dart';
import 'package:flutter_movie/common/videoPlayerScreen.dart';
import 'package:flutter_movie/http/http.dart';
import 'package:flutter_movie/http/url.dart';
import 'package:flutter_movie/models/movieDetailModel.dart';
import 'package:flutter_movie/models/movieModel.dart';

class MovieDetail extends StatefulWidget {
  static const routeName = '/movie/detail';
  MovieDetail({Key? key}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail>{

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    print("args: $args");

    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body: FutureBuilder(
        future: dio.get("${apiUrl['movie']}/$args"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print("请求出错");
            }
            print(snapshot.data);
            if (snapshot.hasData) {
              Response response = snapshot.data as Response;
              MovieDetailModel movieDetail = MovieDetailModel.fromJson(response.data['data']);

              return Container(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white70,
                      child: Column(
                        children: [
                          Container(
                            height: 230,
                            color: Colors.black,
                            child: VideoPlayerScreen(videoUrl: movieDetail.movie.video,),
                          ),
                        ],
                      ),
                    ),

                    /*第二部分*/
                    Expanded(
                      child: MovieDetailBottom(movieDetail: movieDetail,)
                    ),
                  ],
                ),
              );
            }
          }

          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

}

class RelativeMovie extends StatelessWidget {
  RelativeMovie({Key? key, required this.movies}) : super(key: key);

  List<MovieModel> movies;

  Widget _buildWidget(BuildContext context , MovieModel movie) {
    const double _textLineHeight = 2;
    const double _fontSize = 16;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, MovieDetail.routeName, arguments: movie.id);
            },
            child: Row(
              children: [
                Image.network(movie.poster, width: 56,),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title,
                        style: TextStyle(
                            fontSize: _fontSize,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600
                        ),
                        strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            height: _textLineHeight
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(movie.rate != ''? "豆瓣评分: ${movie.rate}" : "上映时间: ${movie.pubdate}", style: TextStyle(
                        fontSize: _fontSize,
                        color: Colors.black87,),
                        strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            height: _textLineHeight
                        ),
                      ),
                      Text(movie.movieTypes.map((e) => e.name).toList().join('/'), style: TextStyle(
                        fontSize: _fontSize,
                        color: Colors.black87,),
                        strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            height: _textLineHeight
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, i) {
            return _buildWidget(context, movies[i]);
          }
      ),
    );
  }

}