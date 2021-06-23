/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/home.dart';
import 'package:superbaleia/telas/login.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    return Obx(() => c.carregando.value == true
        ? Scaffold(
            backgroundColor: Color(corBack), body: BaleiaExtras.widgetLoading)
        : c.verifLogado().value == true
            ? HomeUi()
            : LoginUi());
  }
} */
