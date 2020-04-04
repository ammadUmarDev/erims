import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    var path = Path();

    paint.color = Colors.white.withOpacity(0.2);
    paint.style = PaintingStyle.fill;

    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);

    path.reset();
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);

    path.reset();
    path.moveTo(0, size.height / 3);
    path.lineTo(size.width / 3, 2 * size.height / 3);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height / 3);
    canvas.drawPath(path, paint);

    path.reset();
    path.moveTo(0, size.height / 3);
    path.lineTo(size.width,0);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height / 3);
    canvas.drawPath(path, paint);

    path.reset();
    paint.color = Colors.white;
    path.moveTo(0, size.height);
    paint.style = PaintingStyle.fill;
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
