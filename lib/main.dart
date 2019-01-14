import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: new Container(
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Page(),
              GuillotineMenu(),
            ],
          ),
        ));
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 90),
      color: Color(0xff222222),
    );
  }
}

class GuillotineMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _GuillotineMenuState();
  }
}

class _GuillotineMenuState extends State<GuillotineMenu> {
  double rotationAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    double screenWidth = mediaQueryData.size.width;

    return Transform.rotate(
      angle: rotationAngle,
      origin: new Offset(24.0, 56.0),
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Color(0xFF333333),
          child: Stack(
            children: <Widget>[
              _buildMenuTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTitle() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    double screenWidth = mediaQueryData.size.width;
    return Positioned(
      top: 32,
      left: 40,
      width: screenWidth,
      height: 24,
      child: Transform.rotate(
        angle: pi / 2.0,
        alignment: Alignment.topLeft,
        origin: Offset.zero,
        child: Opacity(
          opacity: 1.0,
          child: Text(
            "Activity",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
          ),
        ),
      ),
    );
  }
}
