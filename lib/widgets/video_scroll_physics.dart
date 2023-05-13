// ignore: file_names
import 'package:flutter/material.dart';

class VideoScrollPhysics extends BouncingScrollPhysics {
  const VideoScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  VideoScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return VideoScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => SpringDescription.withDampingRatio(
        mass: 0.5,
        stiffness: 300.0,
        ratio: 1.1,
      );
}
