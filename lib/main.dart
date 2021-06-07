import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/home.dart';
import 'package:superbaleia/telas/login.dart';

void main() {
  // await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
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
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Container(
                color: Colors.red,
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                color: Colors.blue,
              ),
            );
          }

          return Scaffold(
            body: Container(
              color: Colors.green,
            ),
          );
        },
      ),
    );
    // final Controller c = Get.put(Controller());

    // return GetMaterialApp(
    //   defaultTransition: Transition.topLevel,
    //   transitionDuration: Duration(milliseconds: 190),
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: Obx(() =>
    //       c.getStorage.value.read('cliente_id') == null ? LoginUi() : HomeUi()),
    // );
  }
}
