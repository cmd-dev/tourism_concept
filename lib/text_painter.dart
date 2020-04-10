import 'package:flutter/material.dart';

class RTextPainter extends CustomPainter {
  RTextPainter(this.strings);
  List<String> strings;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.rotate(3.14 * 1.5);
    for (int i = 0; i < strings.length; i++) {
      final textStyle = TextStyle(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20);

      final textSpan = TextSpan(text: strings[i], style: textStyle);
      final textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout(minWidth: 0, maxWidth: size.width);
      final offset = Offset(i * 100.9, 0);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(RTextPainter oldDelegate) {
    return false;
  }
}
