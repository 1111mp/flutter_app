import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'controller_widget.dart';

class VideoPlayerSlider extends StatefulWidget {
  final Function startPlayControlTimer;
  final Timer? timer;

  VideoPlayerSlider({required this.startPlayControlTimer, required this.timer});

  @override
  _VideoPlayerSliderState createState() => _VideoPlayerSliderState();
}

class _VideoPlayerSliderState extends State<VideoPlayerSlider> {
  VideoPlayerController get controller =>
      ControllerWidget.of(context)!.controller;

  bool get videoInit => ControllerWidget.of(context)!.videoInit;
  // double progressValue; //进度
  late String labelProgress; //tip内容
  bool handle = false; //判断是否在滑动的标识
  bool _controllerWasPlaying = false;

  @override
  void initState() {
    super.initState();
    // progressValue = 0.0;
    labelProgress = '00:00';
  }

  // @override
  // void didUpdateWidget(VideoPlayerSlider oldWidget) {
  //   print('didUpdateWidget');
  //   super.didUpdateWidget(oldWidget);
  //   if (!handle && videoInit) {
  //     int position = controller.value.position.inMilliseconds;
  //     int duration = controller.value.duration.inMilliseconds;
  //     if(position>=duration){
  //       position=duration;
  //     }
  //     setState(() {
  //       progressValue = position / duration * 100;
  //       labelProgress = DateUtil.formatDateMs(
  //         progressValue.toInt(),
  //         format: 'mm:ss',
  //       );
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final int duration = controller.value.duration.inMilliseconds;
    final int position = controller.value.position.inMilliseconds;
    return SliderTheme(
      //自定义风格
      data: SliderTheme.of(context).copyWith(
        //进度条滑块左边颜色
        inactiveTrackColor: Colors.white,
        overlayShape: RoundSliderOverlayShape(
          //可继承SliderComponentShape自定义形状
          overlayRadius: 10, //滑块外圈大小
        ),
        thumbShape: RoundSliderThumbShape(
          //可继承SliderComponentShape自定义形状
          disabledThumbRadius: 7, //禁用是滑块大小
          enabledThumbRadius: 7, //滑块大小
        ),
      ),
      child: Slider(
        value: position / duration * 100,
        label: labelProgress,
        divisions: 100,
        onChangeStart: _onChangeStart,
        onChangeEnd: _onChangeEnd,
        onChanged: _onChanged,
        min: 0,
        max: 100,
      ),
    );
  }

  void _onChangeEnd(_) {
    // 关闭手动操作标识
    handle = false;

    if (!videoInit) {
      return;
    }

    if (_controllerWasPlaying) {
      controller.play();
      widget.startPlayControlTimer();
    }
    // 跳转到滑动时间
    // int duration = controller.value.duration.inMilliseconds;
    // controller.seekTo(
    //   Duration(milliseconds: (progressValue / 100 * duration).toInt()),
    // );
//    if (!controller.value.isPlaying) {
//      controller.play();
//    }
  }

  void _onChangeStart(_) {
    // 开始手动操作标识
    handle = true;

    if (!videoInit) {
      return;
    }

    if (widget.timer != null) {
      widget.timer!.cancel();
    }

    _controllerWasPlaying = controller.value.isPlaying;
    if (_controllerWasPlaying) {
      controller.pause();
    }
  }

  void _onChanged(double value) {
    if (!videoInit) {
      return;
    }
    if (widget.timer != null) {
      widget.timer!.cancel();
    }

    final double relative = value / 100;
    final Duration position = controller.value.duration * relative;
    controller.seekTo(position);

    setState(() {
      final int duration = controller.value.duration.inMilliseconds;
      // progressValue = value;
      labelProgress = DateUtil.formatDateMs(
        (value / 100 * duration).toInt(),
        format: 'mm:ss',
      );
    });
  }
}
