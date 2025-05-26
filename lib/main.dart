import 'package:flutter/material.dart';
import 'package:flutter_application_1/SplashWrapper.dart';
import 'package:flutter_application_1/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NEWA',
      debugShowCheckedModeBanner: false,
      home: SplashWrapper(),

    );
  }
}
