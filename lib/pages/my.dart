import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animation<double> animation;
  AnimationController animationController;
  Animation curve;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    /** 创建 animationController, 用于控制动画
     * 必须提供动画时间
     * 当创建一个AnimationController时，需要传递一个vsync参数，存在vsync时会防止屏幕外动画（译者语：动画的UI不在当前屏幕时）消耗不必要的资源。
     */
    animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    /// Curves动画列表 https://api.flutter.dev/flutter/animation/Curves-class.html
    curve = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
    animation = Tween<double>(
      begin: 100.0,
      end: 100.0 * 2.0,
    ).animate(curve)
      ..addListener(() {
        // 当动画更新时会调用
        setState(() {
          // 需要在这个函数中，调用 setState() 来触发视图刷新
        });
      });
    /** 开始播放动画 */
    animationController.forward();
    print('start animation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: animation.value,
          height: animation.value,
          child: Container(
            color: Colors.lightBlue,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    /** 动画使用完成后必需要销毁 */
    animationController.dispose();
  }
}
