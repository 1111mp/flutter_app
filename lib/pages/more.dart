import 'package:flutter/material.dart';
import 'package:flutter_app/common/provider/index.dart';
import 'package:provider/provider.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('init MorePage');
  }

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
                '我是更多 ${counter.value} ${counter.name}',
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
