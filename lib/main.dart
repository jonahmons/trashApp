import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:trashapp/Widgets/start.dart';

import 'Widgets/camera.dart';
import 'helper/globals.dart' as globals;

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  globals.cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  globals.firstCamera = globals.cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: Start()
    ),
  );
}
