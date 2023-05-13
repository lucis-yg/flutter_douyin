// import 'dart:async';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeGestureWidget extends StatefulWidget {
  final Function onAddFavorite;
  final Widget child;
  final Function onSingleTap;
  const LikeGestureWidget(
      {super.key,
      required this.child,
      required this.onAddFavorite,
      required this.onSingleTap});
  @override
  State<StatefulWidget> createState() => _LikeGestureWidget();
}

class _LikeGestureWidget extends State<LikeGestureWidget> {
  final GlobalKey _globalKey = GlobalKey();
  List<Offset> icons = []; //存储点击位置
  int lastMilliSeconds = -1; //记录上次手指抬起的时间毫秒值
  Timer? _timer;
  bool tapUpFlag = false;
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _globalKey,
      onTapDown: (detail) {
        setState(() {
          //获取当前时间的毫秒值
          int currentMilliSeconds = DateTime.now().millisecondsSinceEpoch;
          //计算当前时间毫秒值与上次抬起时间的差值
          int diff = currentMilliSeconds - lastMilliSeconds;
          if (diff < 500) {
            _timer?.cancel();
            _timer = null;
            if (!icons.contains(_convertPosition(detail.globalPosition))) {
              icons.add(_convertPosition(detail.globalPosition));
              widget.onAddFavorite();
            }
          } else {
            tapUpFlag = false;
            _timer?.cancel();
            _timer = null;
            _timer = Timer(const Duration(milliseconds: 200), () {
              if (!tapUpFlag) return;
              widget.onSingleTap();
            });
          }
        });
      },
      onTapUp: (TapUpDetails tapUpDetails) {
        tapUpFlag = true;
        lastMilliSeconds = DateTime.now().millisecondsSinceEpoch;
      },
      child: Stack(
        children: <Widget>[
          //外部的部件，至于动画的下面
          widget.child,
          //小红心动画效果
          _getIconStack(),
        ],
      ),
    );
  }

  Offset _convertPosition(Offset p) {
    RenderBox getBox =
        _globalKey.currentContext!.findRenderObject() as RenderBox;
    return getBox.globalToLocal(p);
  }

  _getIconStack() {
    return Stack(
      children: icons
          .map<Widget>(
            (position) => FavoriteAnimationIcon(
              // key: Key(position.toString()),
              key: Key(position.toString()),
              position: position,
              onAnimationStart: () {
                icons.remove(position);
              },
            ),
          )
          .toList(),
    );
  }
}

class FavoriteAnimationIcon extends StatefulWidget {
  final Offset position; //位置
  final double size = 0.4.sw; //图标大小
  final Function? onAnimationStart; //动画开始的回调
  FavoriteAnimationIcon({
    super.key,
    required this.onAnimationStart,
    required this.position,
  });

  @override
  State<StatefulWidget> createState() => _FavoriteAnimationIcon();
}

class _FavoriteAnimationIcon extends State<FavoriteAnimationIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  //图标的旋转角度，随机
  double rotate = pi / 10.0 * (2 * Random().nextDouble() - 1);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0,
        upperBound: 1,
        duration: const Duration(milliseconds: 1000));

    _animationController.addListener(() {
      setState(() {});
    });
    startAnimation();
    super.initState();
  }

  void startAnimation() async {
    await _animationController.forward();
    widget.onAnimationStart?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: widget.position.dx - widget.size / 2,
        top: widget.position.dy - widget.size,
        child: _getBody());
  }

  _getBody() {
    return Transform.rotate(
      angle: rotate,
      child: Opacity(
        opacity: opacity,
        child: Transform.scale(
          alignment: Alignment.bottomCenter,
          scale: scale,
          child: _getContent(),
        ),
      ),
    );
  }

  //获取动画的值
  double get value => _animationController.value;

  //获取动画的不透明度
  double get opacity {
    if (value < 0.1) {
      return 0.9 / 0.1 * value;
    }
    if (value < 0.8) {
      return 0.9;
    }
    var res = 0.9 - (value - 0.8) / (1 - 0.8);
    return res < 0 ? 0 : res;
  }

  //获取动画的缩放比例
  double get scale {
    if (value <= 0.5) {
      return 0.6 + value / 0.5 * 0.5;
    } else if (value <= 0.8) {
      return 1.1 * (1 / 1.1 + (1.1 - 1) / 1.1 * (value - 0.8) / 0.25);
    } else {
      return 1 + (value - 0.8) / 0.2 * 0.5;
    }
  }

  _getContent() {
    return ShaderMask(
      child: _getChild(),
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) => RadialGradient(
        center: Alignment.topLeft.add(const Alignment(0.5, 0.5)),
        colors: const [
          Color(0xffEF6F6F),
          Color(0xffF03E3E),
        ],
      ).createShader(bounds),
    );
  }

  //图标
  _getChild() {
    return Icon(
      Icons.favorite_rounded,
      size: widget.size,
    );
  }
}
