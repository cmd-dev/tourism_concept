import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourism_concept/main.dart';
import 'package:tourism_concept/model.dart';
import 'package:tourism_concept/text_painter.dart';
import 'package:tourism_concept/ui_const.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<String> categories = [
    'Popular',
    'Mountain',
    'Cycling',
    // 'Wildlife',
    // // 'Theme Park'
  ];
  List<Tour> tours = Tour.tours;
  bool isOnTop = false;
  bool isListUnder = false;

  AnimationController _controller;
  Animation<double> _cardOpacityAnim;
  Animation<double> _zoomAnim;
  Animation<double> _outerOpacityAnim;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..addListener(() => setState(() {}));

    _zoomAnim = Tween<double>(begin: 1, end: 2.5)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0.5, 1)));
    _outerOpacityAnim = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.4, 0.7)));
    _cardOpacityAnim = Tween<double>(begin: 1, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0, 0.4)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
    });

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(top: 40),
          child: Text(
            Tour.tours[0].name,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white.withOpacity(_outerOpacityAnim.value)),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: DefaultTextStyle(
        style:
            TextStyle(color: Colors.white.withOpacity(_outerOpacityAnim.value)),
        child: Stack(
          children: <Widget>[
            Container(
              height: height,
              child: Transform.rotate(
                  angle: 3.14,
                  child: Image.asset(
                    'images/homebg.jpg',
                    fit: BoxFit.fitHeight,
                  )),
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
              top: 36,
              right: 10,
              child: Container(
                  margin: EdgeInsets.only(top: 28, right: 10),
                  child: Icon(
                    CupertinoIcons.search,
                    size: 34,
                    color: Colors.white.withOpacity(_outerOpacityAnim.value),
                  )),
            ),
            buildTourSelectList(width),
            buildTourListview(width),
            Positioned(
              bottom: 180,
              width: width,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: isListUnder ? 0 : 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'All Routes',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    UI.horizontalSpaceMedium,
                    FaIcon(
                      Icons.tune,
                      size: 30,
                      color: Colors.white.withOpacity(_outerOpacityAnim.value),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned buildTourListview(double width) {
    return Positioned(
        bottom: 0,
        height: 240,
        width: width,
        child: Opacity(
          opacity: _outerOpacityAnim.value,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFF083f5d),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels > 10.0)
                  setState(() {
                    isListUnder = !isListUnder;
                  });
                if (notification.metrics.pixels == 0) isListUnder = false;
                return true;
              },
              child: ListView(
                children: tours
                    .map((tour) => ListTile(
                          contentPadding: EdgeInsets.all(10),
                          title: Text(tour.name,
                              style: UI.featureTextStyle
                                  .copyWith(fontWeight: FontWeight.w900)),
                          trailing: SizedBox(
                            height: 50,
                            width: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      tour.price.toString(),
                                      style: UI.featureTextStyle
                                          .copyWith(fontSize: 15),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.euroSign,
                                      color: Colors.white,
                                      size: 12,
                                    )
                                  ],
                                ),
                                Text(
                                  'per one',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'images/tour${tours.indexOf(tour)}.jpg',
                              height: 50,
                              width: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ));
  }

  Positioned buildTourSelectList(double width) {
    return Positioned(
        top: 150,
        child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' Hiking & Active Leisure',
                    style: TextStyle(
                      fontFamily: 'Lato',
                    ),
                  ),
                  Text(
                    '89 Routes',
                    style: TextStyle(fontSize: 55, fontWeight: FontWeight.w700),
                  ),
                  UI.verticalSpaceLarge,
                  Container(
                      height: 250,
                      width: width,
                      child: Stack(
                        children: <Widget>[
                          AnimatedOpacity(
                            duration: Duration(microseconds: 500),
                            opacity: isOnTop ? 0 : 1,
                            child: Opacity(
                              opacity: _outerOpacityAnim.value,
                              child: CustomPaint(
                                painter: RTextPainter(categories),
                                child: Center(),
                              ),
                            ),
                          ),
                          NotificationListener<ScrollUpdateNotification>(
                            onNotification: (notification) {
                              if (notification.metrics.pixels > 28.0)
                                setState(() {
                                  isOnTop = !isOnTop;
                                });
                              if (notification.metrics.pixels == 0)
                                isOnTop = false;
                              return true;
                            },
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tours.length,
                              itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    _controller.forward();
                                  },
                                  child: tourCard(tours, index)),
                            ),
                          )
                        ],
                      ))
                ])));
  }

  Widget tourCard(List<Tour> tours, int index) {
    return Opacity(
      opacity: !_outerOpacityAnim.isCompleted
          ? index == 0
              ? _outerOpacityAnim.value.clamp(0.1, 1)
              : _outerOpacityAnim.value
          : 0,
      child: Container(
        margin: EdgeInsets.only(left: index == 0 ? 90 : 0, right: 20),
        child: Transform.scale(
          scale: index == 0 ? _zoomAnim.value : 1,
          child: ClipRect(
            child: Stack(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.only(right: 20),
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    height: 220 * _zoomAnim.value,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage('images/tour$index.jpg'))),
                  ),
                ),
                Container(
                  height: 220,
                  width: 150,
                  child: BackdropFilter(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 0),
                  ),
                ),
                Opacity(
                  opacity: _cardOpacityAnim.value,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFF66A6B),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    width: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tours[index].price.toString() + ' ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                        FaIcon(
                          FontAwesomeIcons.euroSign,
                          color: Colors.white,
                          size: 9,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 75 / 2 - tours[index].name.length * 2.1 / 2,
                  child: Opacity(
                      opacity: _cardOpacityAnim.value,
                      child:
                          Text(tours[index].name, style: UI.featureTextStyle)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
