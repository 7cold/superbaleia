import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        bottomSheet: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "R\$",
                  style: textBold(20, corBackDark),
                ),
              ),
              BaleiaButtons.buttonPrimary(
                  "Comprar", context.width / 1.6, 35, () {})
            ],
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
