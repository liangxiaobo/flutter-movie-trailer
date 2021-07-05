import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/common/moreMovieTabContent.dart';

class MoreMovie extends StatefulWidget {
  static const routeName = '/more/movie';
  MoreMovie({Key? key}):super(key: key);

  @override
  State<StatefulWidget> createState() => _MoreMovieState();
}

class _MoreMovieState extends State<MoreMovie> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tabs = ['即将上映', '正在热映'];
    final status = ModalRoute.of(context)!.settings.arguments as int;

    return DefaultTabController(length: 2,
      initialIndex: !status.isNaN ? status : 0,
      child:Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                    ),
                    Container(
                      width: 200,
                      height: 40,
                      margin: EdgeInsets.only(left: (size.width-260)/2),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          /// 容器颜色
                            color: Color(0xff0d121a),
                            /// 圆角
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: TabBar(
                          labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                          /// 设置 文本label的内填充边框
                          labelPadding: EdgeInsets.zero,
                          /// 设置是否滚动
                          isScrollable: false,
                          /// 指示器大小计算式，以label文本边框计算
//                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                            border: Border.all(width: 1, color: Color(0xff0d121a)),
                            color: Color(0xff1c2635),
                            borderRadius: BorderRadius.circular(30),

                          ),
                          tabs: [
                            for (final tab in tabs) Tab(text: tab,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
        body: TabBarView(
          children: [
            MoreMovieTabContent(status: 0),
            MoreMovieTabContent(status: 1),
          ],
        ),
      ),
    );
  }

}





