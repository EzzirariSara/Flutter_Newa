import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirstPage.dart';
import 'package:flutter_application_1/HomePage.dart';

class SplashWrapper extends StatefulWidget {
  @override
  _SplashWrapperState createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  bool showFirstPage = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        showFirstPage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return showFirstPage ? FirstPage() : Homepage();
  }
}
