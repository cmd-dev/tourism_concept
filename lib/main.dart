import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourism_concept/clipper.dart';
import 'package:tourism_concept/home.dart';
import 'package:tourism_concept/model.dart';
import 'package:tourism_concept/painter.dart';
import 'package:tourism_concept/ui_const.dart';
import 'dart:math' as Math;

import 'countup.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  bool isClick = false;
  AnimationController transitionController;

  Animation<double> _bgAnim;
  Animation<double> _bgBackAnim;
  Animation<double> _bottomButtonRotateAnim;
  Animation<double> _featureTextOpacityAnim;
  Animation<double> _delayedWidgetOpacityAnim;
  Animation<double> _textOpacity;
  Animation<double> _trailAnim;
  Animation<double> _trailDestAnim;

  //bg-button-feature text-location--dot--text--trail--dot
  @override
  void initState() {
    super.initState();
    transitionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2500))
          ..addListener(() => setState(() {}));

    _bgAnim = Tween<double>(begin: 400, end: 0).animate(CurvedAnimation(
        curve: Interval(0, 0.20), parent: transitionController));
    _bgBackAnim = Tween<double>(begin: 400, end: 800).animate(
        CurvedAnimation(curve: Interval(0, 0.2), parent: transitionController));
    _bottomButtonRotateAnim = Tween<double>(begin: Math.pi / 2, end: 0).animate(
        CurvedAnimation(
            curve: Interval(0.2, 0.25), parent: transitionController));
    _featureTextOpacityAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(0.25, 0.4), parent: transitionController));
    _delayedWidgetOpacityAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            curve: Interval(0.4, 0.55), parent: transitionController));
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        curve: Interval(0.55, 0.7), parent: transitionController));
    _trailAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        curve: Interval(0.55, 0.85), parent: transitionController));
    _trailDestAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        curve: Interval(0.85, 1), parent: transitionController));

    Timer(Duration(milliseconds: 1200), () => transitionController.forward());
  }

  @override
  void dispose() {
    transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(top: 40),
          child: Text(
            Tour.tours[0].name,
            style: TextStyle(
                fontSize: 20,
                color:
                    Colors.white.withOpacity(_delayedWidgetOpacityAnim.value)),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: _bgBackAnim.value,
            height: height / 2,
            width: width,
            child: Image.asset(
              'images/tourbg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: _bgAnim.value,
            height: height,
            child: Image.asset(
              'images/tour0.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 36,
            left: 0,
            child: Container(
              height: 90,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Center(
                child:
                    Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
              ),
            ),
          ),
          Positioned(
            top: 150,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  detailContainer(
                      feature: 'Thu, 19 July',
                      data: 9,
                      icon1: Text(
                        '°C',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      icon2: FaIcon(
                        FontAwesomeIcons.cloudSun,
                        color: Colors.white,
                      )),
                  detailContainer(
                    feature: 'Distance',
                    data: 15,
                    icon1: Text(
                      ' km',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  detailContainer(
                      feature: 'Price per one',
                      data: 945,
                      icon1: FaIcon(
                        FontAwesomeIcons.euroSign,
                        color: Colors.white,
                      )),
                  Opacity(
                    opacity: _delayedWidgetOpacityAnim.value,
                    child: Transform.scale(
                      scale: 0.85,
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(40),
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        color: Colors.pinkAccent,
                        onPressed: () {},
                        child: Text('more'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: _trailAnim.value,
            child: ClipRect(
                clipper: CustomRect(_trailAnim.value * height),
                child: CustomPaint(
                  child: Center(),
                  painter: PathPainter(),
                )),
          ),
          Positioned(
            top: 670,
            left: 130,
            child: Opacity(
              opacity: _trailDestAnim.value,
              child: Icon(
                CupertinoIcons.circle_filled,
                size: 40,
                color: Colors.green,
              ),
            ),
          ),
          Positioned(
            top: 125,
            left: 312,
            child: Opacity(
              opacity: _delayedWidgetOpacityAnim.value,
              child: Icon(
                CupertinoIcons.circle_filled,
                size: 40,
                color: Colors.red,
              ),
            ),
          ),
          buildBottomCard(width)
        ],
      ),
    );
  }

  Positioned buildBottomCard(double width) {
    return Positioned(
      height: 80,
      width: width,
      bottom: 0,
      child: Transform(
        transform: Matrix4.rotationX(_bottomButtonRotateAnim.value),
        child: Card(
          color: Colors.pink,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'Book now',
                style: TextStyle(
                    color: Colors.white.withOpacity(_textOpacity.value),
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              UI.horizontalSpaceMedium,
              FaIcon(
                FontAwesomeIcons.hiking,
                size: 30,
                color: Colors.white.withOpacity(_textOpacity.value),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget detailContainer(
      {String feature, int data, Widget icon1, Widget icon2}) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: 110,
      width: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            feature ?? 'feature',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.white.withOpacity(_featureTextOpacityAnim.value),
            ),
          ),
          UI.verticalSpaceExtraSmall,
          Opacity(
            opacity: _textOpacity.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CountUp(
                  controller: transitionController,
                  textData: data,
                  style: TextStyle(
                      fontSize: 55,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                icon1 ?? Container(),
                icon2 ?? Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
