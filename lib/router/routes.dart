import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/pages/notFound.dart';
import 'package:flutter_app/router/route_handlers.dart';

class Routes {
  static String root = "/";
  static String app = "/app";
  static String browser = "/browser";
  static String webview = "/webview";
  static String video = "/video";
  static String share = "/share";
  static String imagePicker = "/image_picker";
  static String home = "/home";
  static String demoParams = "/deme_params";
  static String returnParams = "/return_params";
  static String transitionDemo = "/transitionDemo";
  static String transitionCustomDemo = "/transitionCustomDemo";
  static String transitionCupertinoDemo = "/transitionCupertinoDemo";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        print("ROUTE WAS NOT FOUND !!!");
        return NotFound();
      },
    );
    router.define(root, handler: splashHandler);
    router.define(app, handler: appHandle);
    router.define(browser, handler: browserHandle);
    router.define(webview, handler: webviewHandle);
    router.define(share, handler: shareHandle);
    router.define(imagePicker, handler: imagePickerHandle);
    router.define(video, handler: videoHandle);
    router.define(home, handler: homeHandle);
    router.define(demoParams, handler: demoParamHandler);
    router.define(returnParams, handler: returnParamHandler);
    router.define(transitionDemo, handler: transitionDemoHandler);
    router.define(transitionCustomDemo, handler: transitionDemoHandler);
    router.define(transitionCupertinoDemo, handler: transitionDemoHandler);
  }
}
