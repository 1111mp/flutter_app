import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/common/utils/fluro_convert_util.dart';
import 'package:flutter_app/model/Person.dart';
import 'package:flutter_app/router/NavigatorUtil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('init HomePage');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    String name = "来自第一个界面测试一下";
    int age = 14;
    double score = 6.4;
    bool sex = true;
    Person person = new Person(name: 'Zeking', age: 18, sex: true);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text('这是主页')),
            ElevatedButton(
              child: Text('传递参数string ,int，double，bool ，自定义类型'),
              onPressed: () {
                NavigatorUtil.goDemoParamsPage(
                    context, name, age, score, sex, person);
              },
            ),
            ElevatedButton(
              child: Text('传递参数,接受返回值'),
              onPressed: () {
                NavigatorUtil.goReturnParamsPage(context).then((result) {
                  debugPrint('${result.runtimeType}');
                  String message;

                  /// 如果是 自定义的 Person 类
                  if (result.runtimeType == Person) {
                    message = result.toJson().toString();
                    debugPrint('${result.toJson().toString()}');
                  } else {
                    message = '$result';
                    debugPrint('$result');
                  }
                  showResultDialog(context, message);
                });
              },
            ),
            ElevatedButton(
              child: Text('框架 自带 转场动画 演示'),
              onPressed: () {
                NavigatorUtil.gotransitionDemoPage(
                  context,

                  /// 这边进行了 String 编码
                  FluroConvertUtils.fluroCnParamsEncode(
                      "框架 自带 转场动画 演示 \n\n\n   "
                      "这边只展示 inFromLeft ，剩下的自己去尝试下,\n\n\n   "
                      "架自带的有 native，nativeModal，inFromLeft，inFromRight，inFromBottom，fadeIn，custom"),
                );
              },
            ),
            ElevatedButton(
              child: Text('框架 自定义 转场动画 演示'),
              onPressed: () {
                NavigatorUtil.gotransitionCustomDemoPage(
                  context,
                  FluroConvertUtils.fluroCnParamsEncode('框架 自定义 转场动画 演示'),
                );
              },
            ),
            ElevatedButton(
              child: Text('修改源码，添加使用 Flutter 的 cupertino 转场动画'),
              onPressed: () {
                NavigatorUtil.gotransitionCupertinoDemoPage(
                  context,
                  FluroConvertUtils.fluroCnParamsEncode(
                      "修改源码，添加使用 Flutter 的 cupertino 转场动画"),
                );
              },
            ),
            ElevatedButton(
              child: Text('Browser page'),
              onPressed: () {
                NavigatorUtil.goPage(context, '/browser');
              },
            ),
            ElevatedButton(
              child: Text('webview page'),
              onPressed: () {
                NavigatorUtil.goPage(context, '/webview');
              },
            ),
            ElevatedButton(
              child: Text('video player'),
              onPressed: () {
                NavigatorUtil.goPage(context, '/video');
              },
            ),
            ElevatedButton(
              child: Text('share'),
              onPressed: () {
                NavigatorUtil.goPage(context, '/share');
              },
            ),
            ElevatedButton(
              child: Text('image picker'),
              onPressed: () {
                NavigatorUtil.goPage(context, '/image_picker');
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 显示一个Dialgo
  void showResultDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return new AlertDialog(
          title: new Text(
            "Hey Hey!",
            style: new TextStyle(
              color: const Color(0xFF00D6F7),
              fontFamily: "Lazer84",
              fontSize: 22.0,
            ),
          ),
          content: new Text("$message"),
          actions: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(bottom: 8.0, right: 8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: new Text("OK"),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(bottom: 8.0, right: 8.0),
              child: new TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: new Text("取消"),
              ),
            ),
          ],
        );
      },
    );
  }
}
