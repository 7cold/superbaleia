import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/telas/index.dart';
import 'package:superbaleia/widgets/extras.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 190),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Container(
                color: Colors.red,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Root();
          }
          return Scaffold(body: BaleiaExtras.widgetLoading);
        },
      ),
    );
  }
}
