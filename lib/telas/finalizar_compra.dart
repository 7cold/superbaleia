import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';

import 'finalizar_compra_final.dart';

class FinalizarCompraUi extends StatelessWidget {
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Color(corBack),
        bottomNavigationBar: Material(
          elevation: 10,
          child: Container(
            height: 90,
            margin: EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Color(corGreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "R\$ ", style: textRegular(12, corBack)),
                            TextSpan(
                              text: formatter
                                  .format(c.getTotalPrice())
                                  .toString(),
                              style: textHeavy(20, corBack),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text("Finalizar Compra",
                              style: textRegular(20, corBack)),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Color(corBack),
                          )
                        ],
                      )
                    ],
                  ),
                  onPressed: () {
                    c.finishOrder();
                    Get.off(() => FinalizarCompraUiFinal(
                          tipoEntrega: c.tipoEntega.value,
                        ));
                  }),
            ),
          ),
        ),
        appBar: BaleiaExtras.appBar("Finalizar Pedido"),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                BaleiaExtras.finalizarUiEndereco(),
                SizedBox(height: 30),
                BaleiaExtras.finalizarUiEntrega(),
                SizedBox(height: 30),
                BaleiaExtras.finalizarUiResumo(),
                SizedBox(height: 30),
                BaleiaExtras.finalizarUiPagamento(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
