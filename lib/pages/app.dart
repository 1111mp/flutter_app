import 'package:flutter/material.dart';
import 'package:flutter_app/router/route_handlers.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  PageController _pageController;
  int _tabIndex = 0;
  final List<Widget> _pageList = getPageList();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: this._tabIndex,
      keepPage: true,
    );
  }

  /// IndexedStack在初始化的时候会初始化所有的子元素，pageA和pageB的initState会同时调用
  /// https://blog.bombox.org/2019-02-23/flutter-tab-keep-alive/
  /// 使用PageView可以正常切换，但是每次切换Tab的时候还是会重复调用initState，我们还需要在子页面实现AutomaticKeepAliveClientMixin
  /// 通过设置physics为NeverScrollableScrollPhysics()来禁止左右滑动切换
  @override
  Widget build(BuildContext content) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pageList,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            title: Text('More'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            title: Text('Find'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('My'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        iconSize: 24.0,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
