import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/Person.dart';
import 'package:flutter_app/router/NavigatorUtil.dart';

class ReturnParamsPage extends StatefulWidget {
  @override
  _ReturnParamsPageState createState() => _ReturnParamsPageState();
}

class _ReturnParamsPageState extends State<ReturnParamsPage> {
  @override
  Widget build(BuildContext context) {
    Person person = new Person(name: "returnName", age: 23, sex: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              child: Text('返回，并且返回string'),
              onPressed: () {
                NavigatorUtil.goBackWithParams(context, "我是返回值哦");
              },
            ),
          ),
          ElevatedButton(
            child: Text('返回，并且返回int'),
            onPressed: () {
              NavigatorUtil.goBackWithParams(context, 12);
            },
          ),
          ElevatedButton(
            child: Text('返回，并且返回double'),
            onPressed: () {
              NavigatorUtil.goBackWithParams(context, 3.1415926);
            },
          ),
          ElevatedButton(
            child: Text('返回，并且返回bool'),
            onPressed: () {
              NavigatorUtil.goBackWithParams(context, true);
            },
          ),
          ElevatedButton(
            child: Text('返回，并且返回自定义类型'),
            onPressed: () {
              NavigatorUtil.goBackWithParams(context, person);
            },
          )
        ],
      ),
    );
  }
}
