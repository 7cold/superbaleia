import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/root.dart';
import 'package:superbaleia/widgets/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Controller c = Get.put(Controller());
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1400), () {
      Get.off(() => Root());
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
            ),
          ),
        ],
      ),
    );
  }
}
