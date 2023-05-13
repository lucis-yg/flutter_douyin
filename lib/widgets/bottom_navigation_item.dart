import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationItem extends StatefulWidget {
  final int currentIndex;
  final int index;
  final String label;
  final Function changeNavigationPage;
  final Color? labelColor;
  const BottomNavigationItem(
      {super.key,
      required this.currentIndex,
      required this.index,
      required this.label,
      required this.changeNavigationPage,
      required this.labelColor});

  @override
  State<BottomNavigationItem> createState() => _BottomNavigationItem();
}

class _BottomNavigationItem extends State<BottomNavigationItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          setState(() {
            widget.changeNavigationPage(widget.index);
          });
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 5,
          child: AnimatedDefaultTextStyle(
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 0.045.sw,
                  color: (widget.currentIndex == widget.index)
                      ? widget.labelColor
                      : Colors.grey),
              duration: const Duration(milliseconds: 80),
              child: Text(widget.label)),
        ));
  }
}
