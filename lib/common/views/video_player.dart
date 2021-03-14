import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/views/video_player/video_player_UI.dart';
// import 'package:video_player/video_player.dart';

class VideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: VideoPlayerUI.network(
          url:
              'https://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4',
          title: '示例视频',
          key: UniqueKey(),
        ),
      ),
    );
  }
}
