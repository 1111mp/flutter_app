import 'package:flutter/material.dart';
import 'package:myapp/provider/index.dart';
import 'package:provider/provider.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('更多'),
          centerTitle: true,
        ),
        body: Consumer2<CounterModel, int>(
          builder: (context, CounterModel counter, int textSize, child) =>
              ListView(
            children: <Widget>[
              Text(
                '我是更多 ${counter.value}',
                style: TextStyle(fontSize: textSize.toDouble()),
              )
            ],
          ),
        ),
        floatingActionButton: Consumer<CounterModel>(
          builder: (context, CounterModel counter, child) =>
              FloatingActionButton(
            onPressed: counter.increment,
            child: child,
          ),
          child: Icon(Icons.add),
        ));
  }
}
