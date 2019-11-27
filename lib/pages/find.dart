import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Find extends StatelessWidget {
  final int num = 48;
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('发现'),
          centerTitle: true,
        ),
        body: MultiProvider(
          providers: [
            Provider(
              builder: (context) => num,
            )
          ],
          child: ListView(
            children: <Widget>[new Text('我是发现')],
          ),
        ));
  }
}

// 进行数据初始化
// void initState() {
//   super.initState();
//   WidgetsBinding.instance.addPostFrameCallback((callback) {
//     Provider.of<CounterModel>(context).increment();
//   });
// }
