import 'package:flutter/cupertino.dart'
    show BuildContext, WidgetBuilder, Widget;

import 'pages/app.dart' show App;
import 'pages/home.dart' show Home;
import 'pages/my.dart' show My;
import 'pages/find.dart' show Find;
import 'pages/more.dart' show More;

final List<Map> routeConfig = [
  {'name': 'App', 'path': '/', 'builder': (BuildContext context) => new App()},
  {
    'name': 'Home',
    'path': '/home',
    'builder': (BuildContext context) => new Home()
  },
  {
    'name': 'More',
    'path': '/more',
    'builder': (BuildContext context) => new More()
  },
  {
    'name': 'Find',
    'path': '/find',
    'builder': (BuildContext context) => new Find()
  },
  {'name': 'My', 'path': '/my', 'builder': (BuildContext context) => new My()},
];

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> map = {};

    routeConfig.forEach((route) {
      map[route['path']] = route['builder'];
    });
    return map;
  }

  static List<Widget> getPageList() {
    return [
      new Home(),
      new More(),
      new Find(),
      new My(),
    ];
  }
}
