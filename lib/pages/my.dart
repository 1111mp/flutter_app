import 'package:flutter/material.dart';

class My extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('个人中心'),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[new Text('我是个人中心')],
      ),
    );
  }
}
