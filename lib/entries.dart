import 'dart:async';
import 'package:flutter/material.dart';

class Entries extends StatefulWidget{
  @override
  _Entries createState() => new _Entries();
}

class _Entries extends State<Entries> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Screen')),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Insert a text
              Text(
                'This is a new screen',
                style: TextStyle(fontSize: 24.0),
              ),
              // Insert a button shaped as an image
              new FlatButton(
                child: Image.asset('assets/happy.png', width: 120, height: 120),
                onPressed: () {},
              ),
              // Insert an Image
              new SizedBox(
                width: 30.0,
                height: 30.0,
                child: new Image.asset("assets/happy.png")
              )
             ],),
          ],
        ),
      ),
    );
  }
}