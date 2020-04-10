
import 'package:flutter/material.dart';

class CustomRect extends CustomClipper<Rect> {
  CustomRect(this.height) ;
  double height;
  @override
  Rect getClip(Size size) {
    
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, height);
    return rect;
  }

  @override
  bool shouldReclip(CustomRect oldClipper) {
    return true;
  }
}