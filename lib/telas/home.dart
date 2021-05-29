import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/extras.dart';

class HomeUi extends StatelessWidget {
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        ClienteData clienteData = ClienteData.fromJson(c.dadosCliente);
        return c.dadosCliente['cliente_nome'] != null
            ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Bem vindo de voltar " + clienteData.clienteNome),
                        SizedBox(height: 40),
                        BaleiaButtons.buttonSecondary(
                            "Logout", Get.context.width, 35, () async {
                          c.logoutCliente();
                        }),
                      ],
                    ),
                  ],
                ),
              )
            : BaleiaExtras.widgetLoading;
      }),
    );
  }
}
