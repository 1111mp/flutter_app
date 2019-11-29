import 'package:fluro/fluro.dart';
import 'package:fluroapp/pages/demo_params_pag.dart';
import 'package:fluroapp/pages/home.dart';
import 'package:fluroapp/pages/return_params_page.dart';
import 'package:fluroapp/pages/splashPag.dart';
import 'package:fluroapp/pages/transition_demo_page.dart';
import 'package:fluroapp/utils/fluro_convert_util.dart';
import 'package:flutter/cupertino.dart';

/// 跳转到首页Splash
Handler splashHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new SplashPag();
  },
);

Handler homeHandle = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HomePage();
  },
);

/// 参数传递 int ，double，bool，自定义类型
Handler demoParamHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    /// params["name"]?.first 相当于 params["name"][0] ，打个debug 你就知道为什么了是个list
    String name = params["name"]?.first;
    String age = params["age"]?.first;
    String sex = params["sex"]?.first;
    String score = params["score"]?.first;
    String personjson = params['personjson']?.first;

    /// 下面转换为真实想要的类型
    return DemoParamsPage(
      name: name,
      age: FluroConvertUtils.string2int(age),
      score: FluroConvertUtils.string2double(score),
      sex: FluroConvertUtils.string2bool(sex),
      personJson: personjson,
    );
  },
);

/// 关闭页面，返回参数
Handler returnParamHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    return ReturnParamsPage();
  },
);

/// 转场动画 页面
Handler transitionDemoHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
    String title = params["title"]?.first;
    return TransitionDemoPage(title);
  },
);