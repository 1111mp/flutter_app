import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404'),
      ),
      body: Center(
        child: Text('404'),
      ),
    );
  }
}
