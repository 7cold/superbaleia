import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/dicas_data.dart';
import 'package:superbaleia/widgets/card.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class PratosDicasUi extends StatelessWidget {
  final String tipo;

  const PratosDicasUi({@required this.tipo});
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.find();

    return Scaffold(
      appBar: BaleiaExtras.appBar(tipo == "dicas" ? "Dicas" : "Pratos"),
      backgroundColor: Color(corBack),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            c.categorias.length == 0
                ? SizedBox(
                    width: Get.context.width,
                    child: BaleiaExtras.widgetLoading,
                  )
                : Column(
                    children: tipo == "dicas"
                        ? c.dicas.map((doc) {
                            DicasData dica = doc;
                            return BaleiaCards.cardTodasDicas(dica);
                          }).toList()
                        : c.pratos.map((doc) {
                            DicasData dica = doc;
                            return BaleiaCards.cardTodasDicas(dica);
                          }).toList()),
          ],
        ),
      ),
    );
  }
}
