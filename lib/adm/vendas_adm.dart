import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/adm/controller_adm.dart';
import 'package:superbaleia/adm/widgets/balAdm.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class VendasAdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ControllerAdm c = Get.find();
    return Obx(
      () => Scaffold(
        backgroundColor: Color(corBack),
        appBar: BalAdm.appBar("Vendas", []),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: c.carregando.value == true
              ? BaleiaExtras.widgetLoading
              : Column(
                  children: c.pedidos.map((val) {
                    PedidoData ped = val;
                    return BalAdm.vendasItens(ped);
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
