import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/http/http.dart';
import 'package:flutter_movie/http/url.dart';
import 'package:flutter_movie/models/hotModel.dart';

import 'hotItem.dart';

class TabHome extends StatefulWidget {
  TabHome({Key? key}) : super(key: key);

  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
      future: dio.get(apiUrl['hot'] as String),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print('请求出问题: ${snapshot.hasError}');
          }

          if (snapshot.hasData) {
            Response response = snapshot.data as Response;
            Map<String, dynamic> data = response.data;
            HotModel hotModel = HotModel.fromJson(data['data']);

            return Container(
              padding: EdgeInsets.only(bottom: 20),
              child: ListView(
                shrinkWrap: true,
                children: [
                  HotItem(title: "即将上映(${hotModel.comming.count})", item: hotModel.comming, type: 0,),
                  HotItem(title: '正在热映(${hotModel.playing.count})', item: hotModel.playing, type: 1,),
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
    );
  }
 @protected
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}