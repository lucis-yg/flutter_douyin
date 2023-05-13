import 'package:flutter/material.dart';

class RefreshLoadingListen extends StatefulWidget {
  final Widget child;
  const RefreshLoadingListen({super.key, required this.child});

  @override
  State<RefreshLoadingListen> createState() => _RefreshLoadingListen();
}

class _RefreshLoadingListen extends State<RefreshLoadingListen> {
  double pointerDownDy = 0;
  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (event) {
          pointerDownDy = event.position.dy;
        },
        onPointerMove: (event) {
          if ((MediaQuery.of(context).size.height - event.position.dy) < 150) {
            return;
          }
          double dy = event.position.dy - pointerDownDy;
          if (dy < 0) {
            UpdateNotification(0.0).dispatch(context);
            return;
          }
          if (dy > 15) return;
          UpdateNotification(dy).dispatch(context);
        },
        onPointerUp: (event) {
          UpdateNotification(0.0).dispatch(context);
        },
        child: widget.child);
  }
}
