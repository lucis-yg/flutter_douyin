// ignore: file_names
import 'package:flutter/material.dart';

class QuickerScrollPhysics extends ClampingScrollPhysics {
  const QuickerScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  QuickerScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return QuickerScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => SpringDescription.withDampingRatio(
        mass: 0.5,
        stiffness: 300.0,
        ratio: 1.1,
      );
}
