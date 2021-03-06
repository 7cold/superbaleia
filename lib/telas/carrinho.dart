import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/telas/finalizar_compra.dart';
import 'package:superbaleia/widgets/card.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';

class CarrinhoUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    final Controller c = Get.find();
    return Obx(
      () => Scaffold(
        appBar:
            BaleiaExtras.appBarCart("Carrinho", c.carrinho.length.toString()),
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
                  color: Color(corPri),
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
                                  .format(c.getProductsPrice())
                                  .toString(),
                              style: textHeavy(20, corBack),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text("Continuar", style: textRegular(20, corBack)),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Color(corBack),
                          )
                        ],
                      )
                    ],
                  ),
                  onPressed: c.carrinho.length == 0
                      ? null
                      : () {
                          Get.to(() => FinalizarCompraUi());
                        }),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: c.carregando.value == true
              ? BaleiaExtras.widgetLoading
              : Column(
                  children: c.carrinho.map((res) {
                    CarrinhoData cart = res;
                    return BaleiaCards.cardProdCarrinho(cart);
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
