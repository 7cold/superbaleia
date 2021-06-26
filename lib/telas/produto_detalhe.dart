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
              width: Get.context.width,
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
              child: Text(prod.marca, style: textSemiBold(18, corGrey)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Material(
                color: Colors.white,
                shadowColor: Colors.white.withAlpha(50),
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Descrição", style: textSemiBold(16, corBackDark)),
                      SizedBox(height: 10),
                      Text(prod.desc, style: textRegular(16, corGrey)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Material(
                color: Colors.white,
                shadowColor: Colors.white.withAlpha(50),
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Especificações",
                          style: textSemiBold(16, corBackDark)),
                      SizedBox(height: 10),
                      Column(
                        children: prod.espec.map((e) {
                          ProdEscpec espec = ProdEscpec.fromList(e);
                          return Row(
                            children: [
                              Text(espec.espec.toString() + ":",
                                  style: textRegular(16, corBackDark)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(espec.valor.toString(),
                                  style: textRegular(16, corGrey)),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
