import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils/index.dart' show white;
import 'package:flutter_app/router/application.dart';
import 'package:flutter_app/router/routes.dart';
import 'package:provider/provider.dart';

import 'common/provider/index.dart';

void main() {
  final textSize = 48;
  // 注册fluro routes
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;

  runApp(MultiProvider(
    providers: [
      Provider(
        create: (context) => textSize,
      ),
      ChangeNotifierProvider(
        create: (context) => CounterModel(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //去掉右上角debug的标签
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: white,
        brightness: Brightness.light,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // highlightColor: Colors.transparent,
        // splashColor: Colors.transparent,
      ),
      // 生成路由
      onGenerateRoute: Application.router!.generator,
    );
  }
}
