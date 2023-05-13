import 'package:flutter/material.dart';

class VideoProgress extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final Function setPosition;
  final Function setTimeChange;
  const VideoProgress(
      {super.key,
      required this.position,
      required this.duration,
      required this.setPosition,
      required this.setTimeChange});

  @override
  State<VideoProgress> createState() => _VideoProgress();
}

class _VideoProgress extends State<VideoProgress> {
  double duration = 100;
  bool seekFlag = false;
  double playTime = 0;
  @override
  void initState() {
    super.initState();
    var temp = widget.duration.toString().split(":");
    var totalTime = double.parse(temp[0]) * 60 * 60 +
        double.parse(temp[1]) * 60 +
        double.parse(temp[2]);
    setState(() {
      duration = totalTime;
    });
  }

  double formatTime() {
    var temp = widget.position.toString().split(":");
    var totalTime = double.parse(temp[0]) * 60 * 60 +
        double.parse(temp[1]) * 60 +
        double.parse(temp[2]);
    if (seekFlag) {
      return 0;
    } else {
      var time =
          totalTime / duration * 100 > 100 ? 100 : totalTime / duration * 100;
      setState(() {
        playTime = time.toDouble();
      });
      return time.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      bottom: 55,
      child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: seekFlag
                ? const Color.fromRGBO(255, 255, 255, .8)
                : const Color.fromRGBO(255, 255, 255, .5),
            inactiveTrackColor: const Color.fromRGBO(255, 255, 255, .3),
            thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: seekFlag ? 6 : 2 // 滑块大小
                ),
            trackShape: FullWidthTrackShape(),
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.white,
            ),
            trackHeight: seekFlag ? 6 : 2,
            overlayShape: SliderComponentShape.noOverlay,
            thumbColor: seekFlag
                ? const Color.fromRGBO(255, 255, 255, .9)
                : const Color.fromRGBO(255, 255, 255, .6),
            overlayColor: Colors.transparent,
          ),
          child: Slider(
            value: (formatTime() == 0 ? playTime : formatTime()),
            min: 0.0,
            max: 100.0,
            onChanged: (val) {
              setState(() {
                playTime = val;
              });
              int secondsTemp = ((val / 100 * duration) % 60).floor();
              String seconds = secondsTemp < 9
                  ? '0${secondsTemp.toString()}'
                  : secondsTemp.toString();
              int minutesTemp = ((val / 100 * duration) / 60).floor();
              String minutes = minutesTemp < 10
                  ? '0${minutesTemp.toString()}'
                  : minutesTemp.toString();
              widget.setTimeChange('$minutes:$seconds');
            },
            onChangeStart: (val) {
              setState(() {
                seekFlag = true;
              });
            },
            onChangeEnd: (val) {
              setState(() {
                seekFlag = false;
                playTime = val;
              });
              widget.setPosition(val / 100 * duration);
            },
          )),
    );
  }
}

class FullWidthTrackShape extends RoundedRectSliderTrackShape {
  FullWidthTrackShape({this.addHeight = 0});
  double addHeight;
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    super.paint(context, offset,
        parentBox: parentBox,
        sliderTheme: sliderTheme,
        enableAnimation: enableAnimation,
        textDirection: textDirection,
        thumbCenter: thumbCenter,
        additionalActiveTrackHeight: addHeight);
  }
}
