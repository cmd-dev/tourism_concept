import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final Gradient gradient = new LinearGradient(
    end: Alignment.topCenter,
    begin: Alignment.bottomCenter,
    colors: <Color>[
      Colors.red,
      Colors.orange.withOpacity(0.9),
      Colors.green.withOpacity(0.9)
    ],
   
  );

  final rect1 = Rect.fromLTWH(5, 0, 10, 80);
  final rect2 = Rect.fromLTWH(145, 270, 20, 40);
  final rect3 = Rect.fromLTWH(175, 290, 20, 40);
  // .32,.59,1,1.2
  Path path = Path()
    ..moveTo(152, 200)
    ..quadraticBezierTo(32, 59, 10, 12);
  double startAngle = math.pi / 2;
  double sweepAngle = math.pi;
  bool useCenter = false;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    Paint brush = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke;

    canvas.translate(0, size.height);
    canvas.scale(1, -1);

    canvas.drawLine(Offset(150, 130), Offset(160, 200), brush);
    canvas.translate(152, 200);
    canvas.drawArc(rect1, startAngle, sweepAngle, false, brush);
    canvas.translate(2, 70);
    canvas.drawPath(path, brush);

    canvas.translate(-2, -70);
    startAngle = -math.pi / 2;
    sweepAngle = math.pi - 1.5;
    canvas.drawArc(rect2, startAngle, sweepAngle, false, brush);
    startAngle = math.pi / 2;
    sweepAngle = math.pi - 1.2;
    canvas.drawLine(Offset(166, 295), Offset(175, 308), brush);
    canvas.drawArc(rect3, startAngle, sweepAngle, false, brush);

    canvas.drawLine(Offset(180, 470), Offset(185, 330), brush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
