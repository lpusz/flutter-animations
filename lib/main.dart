import 'package:flutter/material.dart';
import 'package:ninja_trips/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context)?.isCurrent;
    return MaterialApp(
      title: 'Ninja Trips',
      home: Home(),
    );
  }
}
