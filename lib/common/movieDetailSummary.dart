import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/models/movieModel.dart';

class MovieDetailSummary extends StatelessWidget {
  final MovieModel movie;
  final changeSummary;
  MovieDetailSummary(this.movie, this.changeSummary);

  @override
  Widget build(BuildContext context) {
    String actor = movie.casts.map((e) => e.name).toList().join('/');

    return Container(
      child: Column(
        children: [
         Padding(padding: EdgeInsets.all(10),
         child:  Row(
           children: [
             Expanded(
               child: Text(
                 movie.title,
                 style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.w600,
                     color: Colors.black87
                 ),
               ),
             ),

             GestureDetector(
               onTap: (){
                 changeSummary(false);
               },
               child: Icon(Icons.keyboard_arrow_down, size: 24, color: Colors.black87,),
             ),
           ],
         ),
         ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                /*评分*/
                Row(
                  children: [
                    Text('评分: ', style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),),
                    Padding(padding: EdgeInsets.only(left: 5), child: Text(movie.rate, style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),),)
                  ],
                ),
                /*导演*/
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Text('导演: ', style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),),
                      Padding(padding: EdgeInsets.only(left: 5), child: Text(movie.author, style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),),)
                    ],
                  ),),

                /*影人*/
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('影人: ', style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),),
                      Expanded(
                        child: Padding(padding: EdgeInsets.only(left: 5), child: Text(actor, style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),)),
                      ),
                    ],
                  ),),

                /*类型*/
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('类型: ', style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),),
                      Expanded(
                        child: Padding(padding: EdgeInsets.only(left: 5), child: Text(movie.movieTypes.map((e) => e.name).toList().join('·'), style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),)),
                      ),
                    ],
                  ),),

                /*演员列表*/
                Padding(padding: EdgeInsets.only(top: 10), child: Divider(color: Colors.black45,),),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final item in movie.casts) Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Container(
                          width: 80,
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(item.avatar, fit: BoxFit.fill, height: 100),
                              Text(item.name, style: TextStyle(fontSize: 15, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10, top: 10), child: Divider(color: Colors.black45,),),

                /*简介*/
                Padding(padding: EdgeInsets.only(bottom: 10), child: Text('简介', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),),),
                Text(movie.summary, style: TextStyle(fontSize: 14, color: Colors.black87),),
              ],
            ),
          )
        ],
      ),
    );
  }

}