import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

final String title = 'AndroidViewTest';
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  GlobalKey bottomNavigationKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
        home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

TabController _mTabController;
int selectIndex;
List<TabTitle> _tabList;
class TabTitle {
  String title;
  int id;
  TabTitle(this.title, this.id);
}
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int currentPage = 0;
  PageController mPageController = PageController(initialPage: 0);
  GlobalKey bottomNavigationKey = GlobalKey();

  Widget tab1Widget;
  Widget tab2Widget;
  Widget tab3Widget;


  initTabData() {
    _tabList = [
      new TabTitle('tab1', 0),
      new TabTitle('tab2', 1),
      new TabTitle('tab3', 2),
    ];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
    _mTabController = TabController(
      length: _tabList.length,
      vsync: this,
    );
    _mTabController.addListener(() {
      //TabBar的监听
      if (_mTabController.indexIsChanging) {
          onPageChange(_mTabController.index, p: mPageController);
      }
    });

    tab1Widget = getAndroidView("AndroidViewTest1");
    tab2Widget = getAndroidView("AndroidViewTest2");
    tab3Widget = getAndroidView("AndroidViewTest3");
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return tab1Widget;
        break;
      case 1:
        return tab2Widget;
        break;
      case 2:
        return tab3Widget;
        break;
    }
  }
  Widget getAndroidView(String key){
    return new AndroidView(viewType: key);
//    return Text(key);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("Native—Flutter"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment(1, 1),
            color: new Color(0xffffffff),
            height: 49.0,
            width: double.infinity,
            child: TabBar(
              //indicator: new ShapeDecoration(shape: new Border.all(color: Colors.redAccent, width: 100.0)),
              isScrollable: false,  //无限模式
              controller: _mTabController,
              labelColor: Color(0xff3068E8),
              unselectedLabelColor: Color(0xff1A1A1A),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(fontSize: 14.0),
              indicatorColor: Color(0xff3068E8),
              //labelPadding: EdgeInsets.only(left: 00),
              indicatorWeight: 3.0,
              //indicatorPadding: EdgeInsets.only(top: 0.0),
              tabs: <Widget>[
                new Tab(
                  text: "tab1",
                ),
                new Tab(
                  text: "tab2",
                ),
                new Tab(
                  text: "tab3",
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: _tabList.length,
              onPageChanged: (index) {
                onPageChange(index,t: _mTabController);
              },
              controller: mPageController,
              itemBuilder: (BuildContext context, int index) {
                return _getPage(index);
                //return Text(tabList[index].title);
              },
            ),
          )
        ],
      ),
    );;
  }





  void dispose() {
    ///页面销毁时，销毁控制器
    _mTabController.dispose();
    mPageController.dispose();
    super.dispose();
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    print("onPageChange:"+index.toString());
    if (p != null) {
      //判断是哪一个切换
      await p.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn); //等待pageview切换完毕,再释放pageivew监听

    } else {
      t.animateTo(index); //切换Tabbar
    }
  }
}


