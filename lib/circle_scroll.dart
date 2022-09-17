import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';

class CircleScroll extends CustomPainter {
  const CircleScroll({
    super.repaint,
    required this.valueList,
    required this.call,
    required this.c,
  });

  final List<double> valueList;
  final Function(List<Offset>) call;
  final Animation<double> c;

  @override
  void paint(Canvas canvas, Size size) {
    final sizeSet = size.width / 2;
    final center = Offset(sizeSet, sizeSet);
    var piCircle = 0.0;
    List<Offset> offsetList = [];
    for (final v in valueList) {
      piCircle = ((pi * 2) * ((c.value) + v)) - pi / 2;
      Offset circleOffset = Offset(
        sizeSet * math.cos(piCircle) + center.dx,
        sizeSet * math.sin(piCircle) + center.dy,
      );
      offsetList.add(Offset(circleOffset.dx, circleOffset.dy));
    }
    call.call(offsetList);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
