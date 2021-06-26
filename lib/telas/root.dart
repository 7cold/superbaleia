import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/home.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    return Obx(() => c.carregando.value == true
        ? Scaffold(
            backgroundColor: Color(corBack), body: BaleiaExtras.widgetLoading)
        : HomeUi());

    // return Obx(() {
    //   if (c.carregando.value == true)
    //     return Scaffold(
    //         backgroundColor: Color(corBack), body: BaleiaExtras.widgetLoading);
    //   if (c.verifLogado().value == true) {
    //     return HomeUi();
    //   }
    // });
  }
}
