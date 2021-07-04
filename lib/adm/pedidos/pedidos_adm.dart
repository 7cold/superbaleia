import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/widgets/baleiaAdmWidgets.dart';
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
        appBar: BaleiaAdm.appBar("Vendas", []),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: c.carregando.value == true
              ? BaleiaExtras.widgetLoading
              : Container(
                  height: Get.context.height,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("pedidos")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return BaleiaExtras.widgetLoading;
                        } else {
                          return ListView(
                            physics: BouncingScrollPhysics(),
                            children: snapshot.data.docs.length == 0
                                ? [
                                    SizedBox(height: 100),
                                    BaleiaExtras.nenhumPedido(),
                                  ]
                                : snapshot.data.docs
                                    .map((doc) {
                                      PedidoData ped =
                                          PedidoData.fromDocument(doc);
                                      return BaleiaAdm.vendasItens(ped);
                                    })
                                    .toList()
                                    .reversed
                                    .toList(),
                          );
                        }
                      }),
                ),
        ),
      ),
    );
  }
}
