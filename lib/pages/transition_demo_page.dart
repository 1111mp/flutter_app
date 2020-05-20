import 'package:flutter/material.dart';
import 'package:flutter_app/common/utils/fluro_convert_util.dart';
import 'package:flutter_app/router/NavigatorUtil.dart';

class TransitionDemoPage extends StatefulWidget {
  final String title;

  TransitionDemoPage(this.title);

  @override
  _TransitionDemoPageState createState() => _TransitionDemoPageState();
}

class _TransitionDemoPageState extends State<TransitionDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(
            /// string 解码
            FluroConvertUtils.fluroCnParamsDecode(widget.title),
            textAlign: TextAlign.center,
          )),
          RaisedButton(
            child: Text('返回'),
            onPressed: () {
              NavigatorUtil.goBack(context);
            },
          )
        ],
      ),
    );
  }
}
