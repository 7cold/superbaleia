import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class PedidosUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.find();

    return Obx(
      () => Scaffold(
        appBar: BaleiaExtras.appBar("Meus Pedidos"),
        backgroundColor: Color(corBack),
        body: c.carregando.value == true
            ? BaleiaExtras.widgetLoading
            : FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("clientes")
                    .doc(c.firebaseUser.value.uid)
                    .collection("pedidos")
                    .orderBy("data")
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: BaleiaExtras.widgetLoading);
                  } else {
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      children: snapshot.data.docs.length == 0
                          ? [
                              SizedBox(height: 100),
                              BaleiaExtras.nenhumPedido(),
                            ]
                          : snapshot.data.docs
                              .map((doc) =>
                                  BaleiaExtras.meusPedidosItens(doc.id))
                              .toList()
                              .reversed
                              .toList(),
                    );
                  }
                },
              ),
      ),
    );
  }
}
