import 'package:flutter/material.dart';
import 'package:myapp/provider/index.dart';
import 'package:provider/provider.dart';

import 'utils/index.dart' show white;

import 'routes.dart';

void main() {
  print('start');
  // final counter = CounterModel();
  final textSize = 48;

  runApp(MultiProvider(
    providers: [
      Provider(
        builder: (context) => textSize,
        dispose: (context, value) => value.dispose(),
      ), //Provider 只能提供恒定的数据，不能通知依赖它的子部件刷新
      ChangeNotifierProvider(
        builder: (context) => CounterModel(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        // debugShowCheckedModeBanner: false, //去掉右上角debug的标签
        theme: ThemeData(
          primarySwatch: white,
        ),
        initialRoute: '/',
        routes: AppRoutes.getRoutes());
  }
}
