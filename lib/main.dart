import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie/page/home.dart';
import 'package:flutter_movie/page/moreMovie.dart';
import 'package:flutter_movie/page/movieDetail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Color(0xff1c2635))
    );

    return MaterialApp(
//      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.Color(int.parse('0xff1c2635'))
//        primarySwatch: Colors.blue,
        primaryColor: Color(0xff1c2635),
      ),
//      home: Home(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        MovieDetail.routeName: (context) => MovieDetail(),
        MoreMovie.routeName: (context) => MoreMovie(),
      },
    );
  }
}
