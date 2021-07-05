import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/common/publicMovieListItem.dart';
import 'package:flutter_movie/http/http.dart';
import 'package:flutter_movie/http/url.dart';
import 'package:flutter_movie/models/movieModel.dart';

class RankTabContent extends StatefulWidget {
  static const routeName = '/rank';
  @override
  State<StatefulWidget> createState() => _RankTabContentState();
}

class _RankTabContentState extends State<RankTabContent> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
      future: dio.get(apiUrl['rank'] as String),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print('请求出问题: ${snapshot.hasError}');
          }

          if (snapshot.hasData) {
            Response response = snapshot.data as Response;
            List<MovieModel> list = (response.data['data'] as List<dynamic>).map((e) => MovieModel.fromJson(e)).toList();

            return Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: list.length,
                  itemBuilder: (context, i) {
                    return PublicMovieListItem(movie: list[i], index: i,);
                  },
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
    );
  }

  @override
  bool get wantKeepAlive => true;

}