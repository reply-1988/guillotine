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

///Menu animation status
enum _GuillotineAnimationStatus { closed, open, forward, reverse }

class _GuillotineMenuState extends State<GuillotineMenu>
    with SingleTickerProviderStateMixin {
  AnimationController animationControllerMenu;
  Animation<double> animationMenu;
  Animation<double> animationTitleFadeInOut;
  Animation _rotateAnimation;
  double rotationAngle = 0.0;
  double screenHeight;
  double screenWidth;
  _GuillotineAnimationStatus menuAnimationStatus =
      _GuillotineAnimationStatus.closed;

  ///Menu Icon onPress() handle
  _handleMenuOpenClose() {
    if (menuAnimationStatus == _GuillotineAnimationStatus.closed) {
      animationControllerMenu.forward().orCancel;
    } else if (menuAnimationStatus == _GuillotineAnimationStatus.open) {
      animationControllerMenu.reverse().orCancel;
    } else if (menuAnimationStatus == _GuillotineAnimationStatus.forward) {
      animationControllerMenu.reverse().orCancel;
    } else if (menuAnimationStatus == _GuillotineAnimationStatus.reverse) {
      animationControllerMenu.forward().orCancel;
    }
  }

  @override
  void initState() {
    super.initState();
    animationControllerMenu =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((AnimationStatus status) {
            switch (status) {
              case AnimationStatus.completed:
                menuAnimationStatus = _GuillotineAnimationStatus.open;
                break;
              case AnimationStatus.dismissed:
                menuAnimationStatus = _GuillotineAnimationStatus.closed;
                break;
              case AnimationStatus.forward:
                menuAnimationStatus = _GuillotineAnimationStatus.forward;
                break;
              case AnimationStatus.reverse:
                menuAnimationStatus = _GuillotineAnimationStatus.reverse;
                break;
            }
          });
    _rotateAnimation = Tween(begin: -pi / 2.0, end: 0.0).animate(
        new CurvedAnimation(
            parent: animationControllerMenu,
            curve: Curves.bounceOut,
            reverseCurve: Curves.bounceIn));
    animationTitleFadeInOut = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
        parent: animationControllerMenu,
        curve: Interval(0.0, 0.5, curve: Curves.ease)));
  }

  @override
  void dispose() {
    animationControllerMenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenHeight = mediaQueryData.size.height;
    screenWidth = mediaQueryData.size.width;
    double angle = _rotateAnimation.value;

    return Transform.rotate(
      angle: angle,
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
              _buildMenuIcon(),
              _buildMenuContent(),
            ],
          ),
        ),
      ),
    );
  }

  ///Menu Title
  Widget _buildMenuTitle() {
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
          child: Center(
            child: Container(
              child: Opacity(
                opacity: animationTitleFadeInOut.value,
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
          ),
        ),
      ),
    );
  }

  ///Menu Icon
  Widget _buildMenuIcon() {
    return Positioned(
      child: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            _handleMenuOpenClose();
          }),
      top: 32,
      left: 4.0,
    );
  }

  Widget _buildMenuContent() {
    final List<Map> _menus = <Map>[
      {
        "icon": Icons.person,
        "title": "profile",
        "color": Colors.white,
      },
      {
        "icon": Icons.view_agenda,
        "title": "feed",
        "color": Colors.white,
      },
      {
        "icon": Icons.swap_calls,
        "title": "activity",
        "color": Colors.cyan,
      },
      {
        "icon": Icons.settings,
        "title": "settings",
        "color": Colors.white,
      }
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 64, top: 96),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _menus.map((menuItem) {
              return ListTile(
                leading: Icon(
                  menuItem["icon"],
                  color: menuItem["color"],
                ),
                title: Text(
                  menuItem["title"],
                  style: TextStyle(
                    color: menuItem["color"],
                    fontSize: 24,
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }
}
