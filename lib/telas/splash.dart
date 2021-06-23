import 'package:flutter/material.dart';
import 'package:superbaleia/telas/index.dart';
import 'package:superbaleia/widgets/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Root(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corBack),
      body: Stack(
        children: <Widget>[
          // FlareActor(
          //   "assets/animators/splash.flr",
          //   animation: "Untitled",
          //   fit: BoxFit.cover,
          // ),
          Center(
              child: Image.asset(
            "assets/images/logo.png",
            scale: 1.5,
          ))
        ],
      ),
    );
  }
}
