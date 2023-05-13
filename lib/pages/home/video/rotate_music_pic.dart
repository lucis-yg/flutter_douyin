import 'package:flutter/material.dart';

class CircleAvatarAnimation extends StatefulWidget {
  final bool isPlaying;
  final String avatar;
  const CircleAvatarAnimation(
      {super.key, required this.isPlaying, required this.avatar});

  @override
  State<CircleAvatarAnimation> createState() => _CircleAvatarAnimationState();
}

class _CircleAvatarAnimationState extends State<CircleAvatarAnimation>
    with SingleTickerProviderStateMixin {
  //定义一个AnimationController
  late AnimationController _controller;
  //定义一个Animation对象

  @override
  void initState() {
    super.initState();
    //初始化AnimationController
    _controller = AnimationController(
      vsync: this, //垂直同步，这里使用了SingleTickerProviderStateMixin
      duration: const Duration(seconds: 10), //动画周期为2秒
    )..repeat(); //重复执行动画
    //初始化Animation对象
    // _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void didUpdateWidget(CircleAvatarAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(begin: 0.0, end: 1.0).animate(_controller),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(widget.avatar),
      ),
    );
  }

  @override
  void dispose() {
    //释放AnimationController
    _controller.dispose();
    super.dispose();
  }
}
