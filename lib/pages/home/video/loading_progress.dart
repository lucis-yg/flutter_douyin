import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatefulWidget {
  final double width;
  final double height;
  final double value;
  final Color color;

  const CustomLinearProgressIndicator({
    Key? key,
    required this.width,
    required this.height,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  State<CustomLinearProgressIndicator> createState() =>
      _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation =
        Tween<double>(begin: 0, end: widget.value).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat();
  }

  @override
  void didUpdateWidget(covariant CustomLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animationController.duration = const Duration(milliseconds: 500);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: _LinearProgressPainter(
              value: _animation.value,
              width: widget.width,
              height: widget.height,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

class _LinearProgressPainter extends CustomPainter {
  final double value;
  final double width;
  final double height;
  final Color color;

  _LinearProgressPainter({
    required this.value,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = height
      ..strokeCap = StrokeCap.round
      ..color = color;

    double startX = (size.width - value * width) / 2;
    double endX = size.width - startX;

    canvas.drawLine(
      Offset(startX, height / 2),
      Offset(
          value <= 0.5
              ? startX + value * width
              : endX - (value - 0.5) * width * 2,
          height / 2),
      paint,
    );

    if (value > 0.5) {
      canvas.drawLine(
        Offset(endX, height / 2),
        Offset(endX - (value - 0.5) * width * 2, height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_LinearProgressPainter oldDelegate) =>
      oldDelegate.value != value;
}
