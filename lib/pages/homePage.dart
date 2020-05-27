import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  final String name;

  HomePage({this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Success you made it $name",
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.blue),
        ),
      ),
    );
  }
}