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
        children: <Widget>[],
      ),
    ));
  }
}

class Page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 90),
      color: Color(0xff222222),
    );
  }

}

class GuillotineMenu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _GuillotineMenuState();
  }

}

class _GuillotineMenuState extends State<GuillotineMenu>{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff333333),
    );
  }
}
