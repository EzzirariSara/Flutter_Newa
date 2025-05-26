import 'package:flutter/material.dart';
import 'dart:async';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int currentImageIndex = 0;
  List<String> images = [
    'assets/FirstPage/FirstNewa.png',
    'assets/FirstPage/Newa2.png',
    'assets/FirstPage/Newa3.png',
    'assets/FirstPage/Newa4.png',
  ];
  
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (currentImageIndex < images.length - 1) {
          currentImageIndex++;
        } else {
        }
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(images[currentImageIndex]),
      ),
    );
  }
  
  @override
  void dispose() {
    super.dispose();
  }
}