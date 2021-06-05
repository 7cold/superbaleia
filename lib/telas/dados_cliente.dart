import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/telas/login.dart';

class DadosClienteUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
          onPressed: () {
            Get.to(() => LoginUi());
          },
          child: Text("Login")),
    );
  }
}
