import 'package:flutter/material.dart';

class CountUp extends AnimatedWidget {
  CountUp({Key key, this.controller, this.textData, this.style})
      : super(key: key, listenable: controller);
  final AnimationController controller;
  final TextStyle style;
  final int textData;

  Animation _animation;

  @override
  Widget build(BuildContext context) {
    _animation = StepTween(begin: 0, end: textData).animate(controller);
    return Text(
      _animation.value.toString(),
      style: style,
    );
  }
}
