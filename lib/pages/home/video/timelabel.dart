import 'package:flutter/material.dart';

class TimeLabel extends StatefulWidget {
  final String changeTime;
  final Duration duration;
  const TimeLabel(
      {super.key, required this.changeTime, required this.duration});

  @override
  State<TimeLabel> createState() => _TimeLabel();
}

class _TimeLabel extends State<TimeLabel> {
  String duration = "00:00";
  @override
  void initState() {
    super.initState();
    var temp = widget.duration.toString().split(":");
    var minutes = double.parse(temp[0]) * 60 + double.parse(temp[1]);
    var seconds = double.parse(temp[2]);
    String minutesStr = minutes < 10
        ? '0${minutes.ceil().toString()}'
        : minutes.ceil().toString();
    String secondsStr = seconds < 9
        ? '0${seconds.ceil().toString()}'
        : seconds.ceil().toString();
    setState(() {
      duration = '$minutesStr: $secondsStr';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${widget.changeTime} / ",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18)),
            Text(duration,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 18))
          ],
        ),
      ),
    );
  }
}
