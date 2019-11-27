import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/http/index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:myapp/provider/index.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  // 初始化
  void initState() {
    super.initState();
    print('home iniState');
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      print('.........');
      // DioInstance.getInstance().get('/test').then((res) {
      //   print(res);
      //   Provider.of<CounterModel>(context).initName(res['name']);
      // });
      var res = await DioInstance.getInstance().get('/test',
          options: Options(contentType: Headers.jsonContentType),
          cancelToken: CancelToken());
      print(res);
      Provider.of<CounterModel>(context).initName(res['name']);
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onReceiveProgress(int count, int total) {
    if (total != -1) {
      print("${(count / total * 100).floor()}%");
    }
  }

  void _downloadFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);
    DioInstance.getInstance().downloadFile(
      'https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/book.jpg',
      '$dir/book.jpg',
      onReceiveProgress: _onReceiveProgress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
        ),
        body: Consumer<CounterModel>(
          builder: (context, CounterModel counter, child) => ListView(
            children: <Widget>[
              Text('我是Home  $_counter'),
              Text('name  ${counter.name}')
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _downloadFile,
          child: const Icon(Icons.file_download),
        ));
  }
}
