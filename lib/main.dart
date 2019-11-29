import 'package:fluro/fluro.dart';
import 'package:fluroapp/router/application.dart';
import 'package:fluroapp/router/routes.dart';
// import 'package:fluroapp/utils/fluro/src/router.dart';
import 'package:flutter/material.dart';

void main() {
  // 注册fluro routes
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 生成路由
      onGenerateRoute: Application.router.generator,
    );
  }
}
