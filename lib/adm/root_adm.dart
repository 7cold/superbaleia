import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/home_adm.dart';
import 'package:superbaleia/adm/login/login_adm.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/home.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class RootAdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ControllerAdm c = Get.put(ControllerAdm());
    // return Obx(() => c.carregando.value == true
    //     ? Scaffold(
    //         backgroundColor: Color(corBack), body: BaleiaExtras.widgetLoading)
    //     : HomeUi());

    return Obx(() {
      if (c.carregando.value == true)
        return Scaffold(
            backgroundColor: Color(corBack), body: BaleiaExtras.widgetLoading);
      if (c.clienteDataAdm['nome'] == null) {
        return LoginAdm();
      } else {
        return HomeAdm();
      }
    });
  }
}
