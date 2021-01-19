import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'LogInScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00025),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyImage(),
                  Text(
                    "Arsitek App",
                    style: TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        color: Color(0xffff2fc3)),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Online store for every one",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Color(0xffffffff)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void NavigateToLogin() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => LogInScreen(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    NavigateToLogin();
  }
}

class MyImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage image = new AssetImage("images/logo-rumah.png");
    Image logo = new Image(
      image: image,
      width: 70,
      height: 70,
    );
    return logo;
  }
}
