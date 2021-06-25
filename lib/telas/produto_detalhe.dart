import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';

class ProdutoDetalheUi extends StatelessWidget {
  final ProdutoData prod;
  final String catId;

  ProdutoDetalheUi({@required this.prod, @required this.catId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corBack),
      appBar: BaleiaExtras.appBar(prod.titulo),
      bottomNavigationBar: c.verifLogado().value == false
          ? null
          : Material(
              elevation: 10,
              child: Container(
                height: 90,
                margin: EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                  text: "R\$ ",
                                  style: textRegular(12, corBack),
                                ),
                                TextSpan(
                                  text: formatter
                                      .format(prod.preco != prod.precoDesc
                                          ? prod.precoDesc
                                          : prod.preco)
                                      .toString(),
                                  style: textHeavy(20, corBack),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text("Add ao Carrinho",
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
                        CarrinhoData cart = CarrinhoData();

                        cart.categoria = catId;
                        cart.data = Timestamp.fromDate(DateTime.now());
                        cart.produtoData = prod;
                        cart.produtoId = prod.id;
                        cart.qtd = 1;

                        c.addCartItem(cart);

                        Get.rawSnackbar(
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Color(corGreen),
                          message: "Add ao carrinho! 😃",
                        );
                      }),
                ),
              ),
            ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(prod.img),
                        fit: prod.imgFit == "full"
                            ? BoxFit.cover
                            : BoxFit.contain,
                      ),
                    ),
                  )
                ],
                options: CarouselOptions(
                  viewportFraction: 1,
                  initialPage: 0,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, bottom: 0),
              child: Text(prod.titulo, style: textBold(22, corBackDark)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 0, bottom: 10),
              child: Text(prod.marca, style: textSemiBold(18, corBackDark)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Material(
                color: Colors.white,
                shadowColor: Colors.white.withAlpha(50),
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 15, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Color(corPri),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                prod.unidadeMed == "por massa"
                                    ? "Preço por " + prod.medida['massaUnidMed']
                                    : prod.unidadeMed == "por capacidade"
                                        ? "Preço por " +
                                            prod.medida['capacUnidMed']
                                        : "Preço Unitário ",
                                style: textRegular(16, corBack),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: prod.medida['capac'] != 0
                                  ? BaleiaExtras.iconCarrinhoMl(
                                      prod.medida['capac'].toString())
                                  : BaleiaExtras.iconCarrinhoKg(
                                      prod.medida['massa'].toString()),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 20, right: 20),
                        child: Text(prod.desc, style: textRegular(16, corGrey)),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
