import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: 500,
      alignment: Alignment.center,
      child: Text(
        'mAPP',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.pink,
            fontSize: 85,
            fontFamily: 'Main'),
      ),
    ));
  }
}
