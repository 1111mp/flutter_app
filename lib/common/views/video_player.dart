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
              'https://gss3.baidu.com/6LZ0ej3k1Qd3ote6lo7D0j9wehsv/tieba-smallvideo-transcode-crf/60609889_0b5d29ee8e09fad4cc4f40f314d737ca_0.mp4',
          title: '示例视频',
        ),
      ),
    );
  }
}
