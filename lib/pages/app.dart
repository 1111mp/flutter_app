import 'package:flutter/material.dart';

import '../routes.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AppState();
  }
}

class _AppState extends State<App> {
  int _tabIndex = 0;
  final List<Widget> _pageList = AppRoutes.getPageList();

  // final TextStyle _textStyle =
  //     new TextStyle(fontSize: 14.0, color: const Color(0xff515151));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text('Home'),
        //   centerTitle: true,
        // ),
        body: IndexedStack(
          // Flutter - BottomNavigationBar底部导航栏切换后，防止状态丢失
          index: _tabIndex,
          children: _pageList,
        ),
        bottomNavigationBar: new BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.home), title: new Text('Home')),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.more), title: new Text('More')),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.find_in_page), title: new Text('Find')),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.person), title: new Text('My')),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _tabIndex,
            iconSize: 24.0,
            onTap: (index) {
              setState(() {
                _tabIndex = index;
              });
            },
            selectedFontSize: 14.0,
            unselectedFontSize: 14.0,
            selectedItemColor: Colors.blue));
  }
}
