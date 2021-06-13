import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/widgets/buttons.dart';
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
        bottomSheet: Material(
          elevation: 10,
          child: Container(
            height: 90,
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: c.carregando.value == true
                        ? BaleiaExtras.widgetLoading
                        : RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "R\$ ",
                                    style: textRegular(12, corBackDark)),
                                TextSpan(
                                  text: formatter
                                      .format(c.getProductsPrice())
                                      .toString(),
                                  style: textHeavy(20, corBackDark),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: BaleiaButtons.buttonPrimary("Comprar", Get.width, 35,
                      c.carregando.value == true ? null : () {}),
                )
              ],
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
