import 'package:flutter/material.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(height: 5.0),
        Divider(),
        SizedBox(height: 5.0),
        SizedBox(height: 5.0),
        Divider(),
      ],
    );
  }
}
