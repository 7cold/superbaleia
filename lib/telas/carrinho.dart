import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller_carrinho.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/widgets/card.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class CarrinhoUi extends StatelessWidget {
  final ControllerCarrinho cart = Get.put(ControllerCarrinho());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: BaleiaExtras.appBarCart(
            "Carrinho", cart.carrinho.length.toString()),
        backgroundColor: Color(corBack),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: c.carregando.value == true
              ? BaleiaExtras.widgetLoading
              : Column(
                  children: cart.carrinho.map((res) {
                    CarrinhoData cart = res;
                    return BaleiaCards.cardProdCarrinho(cart);
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
