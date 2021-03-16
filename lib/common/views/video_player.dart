import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/common/views/video_player/video_player_UI.dart';
// import 'package:video_player/video_player.dart';

class VideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: VideoPlayerUI.network(
            url:
                'http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4',
            title: '示例视频',
            key: UniqueKey(),
          ),
        ),
      ),
    );
  }
}
