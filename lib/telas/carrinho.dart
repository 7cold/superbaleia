import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/controller/controller_carrinho.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/card.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';

class CarrinhoUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: BaleiaExtras.appBarCart(
            "Carrinho", ControllerCarrinho.to.carrinho.length.toString()),
        backgroundColor: Color(corBack),
        bottomSheet: Material(
          elevation: 10,
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Controller.to.carregando.value == true
                      ? BaleiaExtras.widgetLoading
                      : Text(
                          FlutterMoneyFormatter(
                            amount: ControllerCarrinho.to.totalCompra.value,
                            settings: MoneyFormatterSettings(
                                symbol: "R\$", decimalSeparator: ","),
                          ).output.symbolOnLeft,
                          style: textBold(20, corGreen),
                        ),
                ),
                BaleiaButtons.buttonPrimary("Comprar", context.width / 1.6, 35,
                    Controller.to.carregando.value == true ? null : () {})
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: c.carregando.value == true
              ? BaleiaExtras.widgetLoading
              : Column(
                  children: ControllerCarrinho.to.carrinho.map((res) {
                    CarrinhoData cart = res;
                    return BaleiaCards.cardProdCarrinho(cart);
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
