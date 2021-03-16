import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with TickerProviderStateMixin {
  late double extraPicHeight;
  late double extraBtmHeight;
  late ScrollPhysics _physics;
  late double prevDy;

  late bool callNow;

  late AnimationController animationController;
  late Animation<double> animate;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    extraPicHeight = 0.0;
    extraBtmHeight = 0.0;
    prevDy = 0.0;
    callNow = true;
    _physics = AlwaysScrollableScrollPhysics();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    animate = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  void updatePicHeight(changed) {
    extraPicHeight = changed / 3;

    setState(() {
      extraPicHeight = extraPicHeight;
    });
  }

  void runAnimate() {
    setState(() {
      animate =
          Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
            ..addListener(() {
              setState(() {
                extraPicHeight = animate.value;
              });
            });
      // prevDy = 0.0;
      extraPicHeight = 0.0;
    });
  }

  // 节流
  void debounce(Function fn) {
    if (callNow) {
      fn();
      callNow = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerMove: (event) {
          var position = event.position.dy;
          var detal = position - prevDy;

          if (detal > 0) {
            // print("================向下移动================");
            debounce(() {
              setState(() {
                _physics = ClampingScrollPhysics();
              });
            });
            var result = _scrollController.offset;
            if (result <= 0) {
              updatePicHeight(detal);
            }
          } else {
            // print("================向上移动================");
          }
        },
        onPointerUp: (_) {
          runAnimate();
          animationController.forward(from: 0.0);

          if (_scrollController.offset <= 0) {
            callNow = true;
            setState(() {
              _physics = BouncingScrollPhysics();
            });
          }
        },
        onPointerDown: (event) {
          prevDy = event.position.dy;
          callNow = true;
          setState(() {
            _physics = BouncingScrollPhysics();
          });
        },
        child: PrimaryScrollController(
          controller: _scrollController,
          child: CupertinoScrollbar(
            controller: _scrollController,
            child: CustomScrollView(
              physics: _physics,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverCustomHeaderDelegate(
                      title: '账号',
                      collapsedHeight: 40,
                      expandedHeight: 300 + extraPicHeight,
                      paddingTop: MediaQuery.of(context).padding.top,
                      coverImgUrl:
                          'https://p1.music.126.net/fqdzslent-Jx2MmhWAh0ow==/109951163009168472.jpg'),
                ),
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      //创建列表项
                      return new Container(
                        alignment: Alignment.center,
                        color: Colors.lightBlue[100 * (index % 9)],
                        child: new Text('list item $index'),
                      );
                    },
                    childCount: 20, //50个列表项
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.paddingTop,
    required this.coverImgUrl,
    required this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    if (shrinkOffset > 5) {
      return Colors.white;
    } else {
      return Colors.transparent;
    }
  }

  Color makeStickyHeaderTextColor(shrinkOffset) {
    if (shrinkOffset > 5) {
      return Color(0xFF000001);
    } else {
      return Colors.transparent;
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                // height: 200.0,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          CupertinoIcons.slider_horizontal_3,
                          color: Color(0xFF000001),
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        this.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: makeStickyHeaderTextColor(
                            shrinkOffset,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          CupertinoIcons.gear_alt,
                          color: Color(0xFF000001),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
