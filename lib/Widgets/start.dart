import 'package:flutter/material.dart';

import 'camera.dart';
import '../helper/globals.dart' as globals;


class Start extends StatefulWidget {
  @override
  StartState createState() => StartState();
}

class StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clean your city")),
      body: Center(
        child: Container(child: Column(
          children: <Widget>[
          SizedBox(height: 10,),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TakePictureScreen(camera: globals.firstCamera,
                      ),
                ),
              );
            },
            child: const Text('Report Trash', style: TextStyle(fontSize: 20)),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
