import 'package:fluro/fluro.dart';
import 'package:fluroapp/pages/notFound.dart';
import 'package:fluroapp/router/route_handlers.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String demoParams = "/deme_params";
  static String returnParams = "/return_params";
  static String transitionDemo = "/transitionDemo";
  static String transitionCustomDemo = "/transitionCustomDemo";
  static String transitionCupertinoDemo = "/transitionCupertinoDemo";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("ROUTE WAS NOT FOUND !!!");
        return NotFound();
      },
    );
    router.define(root, handler: splashHandler);
    router.define(home, handler: homeHandle);
    router.define(demoParams, handler: demoParamHandler);
    router.define(returnParams, handler: returnParamHandler);
    router.define(transitionDemo, handler: transitionDemoHandler);
    router.define(transitionCustomDemo, handler: transitionDemoHandler);
    router.define(transitionCupertinoDemo, handler: transitionDemoHandler);
  }
}
