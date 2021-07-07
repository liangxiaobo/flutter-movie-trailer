import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/common/category.dart';
import 'package:flutter_movie/common/rankTabContent.dart';
import 'package:flutter_movie/page/tabHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";

  Home({Key? key}):super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void getCacheData() async{
    final prefs = await SharedPreferences.getInstance();
    print("打印缓存中的email: ${prefs.getString('email')}");
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['首页', '分类', '榜单', '搜索'];

    /// TODO 测试缓存
    getCacheData();

    return DefaultTabController(length: 4,
        child:Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 30),
                child: Image.asset('images/logo.png',
                  fit: BoxFit.contain,
                  width: 80,
                ),
              ),
              Expanded(
                child: TabBar(
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  /// 设置 文本label的内填充边框
                  labelPadding: EdgeInsets.zero,
                  /// 设置是否滚动
                  isScrollable: false,
                  /// 指示器大小计算式，以label文本边框计算
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    for (final tab in tabs) Tab(text: tab,)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Login.routeName);
                  },
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    body: TabBarView(
      children: [
        TabHome(),
        Category(status: 1, rate: [0,10],),
        RankTabContent(),
        Center(child: Text('搜索'),),
      ],
      ),
    ),
    );
  }

}

//class _HomeState extends State<Home> with SingleTickerProviderStateMixin, RestorationMixin {
//  late TabController _tabController;
//
//  final RestorableInt tabIndex = RestorableInt(0);
//
//  @override
//  String? get restorationId => 'tab_non_scrollable_movie';
//
//  @override
//  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//    registerForRestoration(tabIndex, 'tab_index');
//    _tabController.index = tabIndex.value;
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
//    _tabController.addListener(() {
//      setState(() {
//        tabIndex.value = _tabController.index;
//      });
//    });
//  }
//
//  @override
//  void dispose() {
//    _tabController.dispose();
//    tabIndex.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final tabs = ['首页', '分类', '榜单', '搜索'];
//    return Scaffold(
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        bottom: PreferredSize(
//          preferredSize: const Size.fromHeight(20),
//          child: Row(
//            children: [
//              Padding(
//                padding: EdgeInsets.only(left: 10, right: 30),
//                child: Image.asset('images/logo.png',
//                  fit: BoxFit.contain,
//                  width: 80,
//                ),
//              ),
//              Expanded(child: TabBar(
//                controller: _tabController,
//                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                labelPadding: EdgeInsets.zero,
//                isScrollable: false,
//                tabs: [
//                  for (final tab in tabs) Tab(text: tab,)
//                ],
//              ),),
//              Padding(
//                padding: EdgeInsets.only(right: 10, left: 30),
//                child: Icon(
//                    Icons.person,
//                    size: 30,
//                    color: Colors.white70,
//                ),
//              ),
//            ],
//          ),
//        )
//      ),
//    body: TabBarView(
//      controller: _tabController,
//      children: [
//        TabHome(),
//        Center(child: Text('分类'),),
//        Center(child: Text('榜单'),),
//        Center(child: Text('搜索'),),
//      ],
//      ),
//    );
//  }
//}




