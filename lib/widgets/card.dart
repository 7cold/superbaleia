import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/controller/controller_carrinho.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/data/categorias_data.dart';
import 'package:superbaleia/data/dicas_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/services/services.dart';
import 'package:superbaleia/telas/produtos.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/fonts.dart';
import 'buttons.dart';
import 'colors.dart';
import 'texts.dart';

final Controller c = Get.find();

class BaleiaCards {
  static Widget cardSlide(double w, double h, List<Widget> list) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          shadowColor: CupertinoColors.tertiaryLabel,
          borderRadius: BorderRadius.circular(10),
          elevation: 10,
          child: Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CarouselSlider(
              items: list,
              options: CarouselOptions(
                aspectRatio: 16 / 9,
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
        ),
      );

  static Widget cardSlideItem(String url) => Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      );

  static Widget cardTips(DicasData dicasData) => Padding(
        padding: EdgeInsets.only(left: 10, bottom: 24),
        child: Material(
          elevation: 5,
          shadowColor: Colors.white.withOpacity(0.5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 170,
            width: 120,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(dicasData.dicasImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dicasData.dicasTitulo,
                              style: textBold(13, corBackDark),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dicasData.dicasTempo + " min",
                                  style: textRegular(12, corGrey),
                                ),
                                Text(
                                  dicasData.dicasKcal + " kcal",
                                  style: textRegular(12, corGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      );

  static Widget cardPratos(DicasData dicasData) => Padding(
        padding: EdgeInsets.only(left: 10, bottom: 24, right: 10),
        child: Material(
          elevation: 5,
          shadowColor: Colors.white.withOpacity(0.5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 160,
            width: Get.context.width / 1.6,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(dicasData.dicasImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withAlpha(55),
                        Colors.black.withAlpha(200),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dicasData.dicasTitulo,
                          style: textBold(16, corBack),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              dicasData.dicasTempo + " min",
                              style: textMedium(14, corGrey),
                            ),
                            Text(
                              "  •  ",
                              style: textMedium(14, corGrey),
                            ),
                            Text(
                              dicasData.dicasKcal + " kcal",
                              style: textMedium(14, corGrey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  static Widget cardProd(ProdutoData prod) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      child: Material(
        elevation: 5,
        shadowColor: Colors.white.withOpacity(0.5),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 240,
          width: 150,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flexible(
                flex: 5,
                child: Stack(
                  children: [
                    Container(
                      margin: prod.prodImgFit == "full"
                          ? EdgeInsets.all(0)
                          : EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(prod.prodImg),
                          fit: prod.prodImgFit == "full"
                              ? BoxFit.cover
                              : BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 6,
                      bottom: 6,
                      child: prod.prodPrecoDesc != null
                          ? BaleiaExtras.iconDesconto()
                          : BaleiaExtras.iconFreteGratis(),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Container(
                          width: Get.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prod.prodTitulo,
                                style: textSemiBold(15, corBackDark),
                              ),
                              Text(
                                prod.prodUnd == "kg"
                                    ? "Preço por Kg"
                                    : "Preço Unitário",
                                style: textRegular(14, corGrey),
                              ),
                            ],
                          ),
                        ),
                        prod.prodPrecoDesc != null
                            ? Positioned(
                                bottom: 0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FlutterMoneyFormatter(
                                        amount: double.parse(prod.prodPreco),
                                        settings: MoneyFormatterSettings(
                                            symbol: "R\$",
                                            decimalSeparator: ","),
                                      ).output.symbolOnLeft,
                                      style: TextStyle(
                                          fontFamily: fontRegular,
                                          fontSize: 11,
                                          color: CupertinoColors.inactiveGray,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      FlutterMoneyFormatter(
                                        amount:
                                            double.parse(prod.prodPrecoDesc),
                                        settings: MoneyFormatterSettings(
                                            symbol: "R\$",
                                            decimalSeparator: ","),
                                      ).output.symbolOnLeft,
                                      style: textSemiBold(15, corOrange),
                                    ),
                                  ],
                                ),
                              )
                            : Positioned(
                                bottom: 5,
                                left: 0,
                                child: Text(
                                  FlutterMoneyFormatter(
                                    amount: double.parse(prod.prodPreco),
                                    settings: MoneyFormatterSettings(
                                        symbol: "R\$", decimalSeparator: ","),
                                  ).output.symbolOnLeft,
                                  style: textSemiBold(16, corGreen),
                                ),
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: BaleiaButtons.iconButtonCart(() async {
                            CarrinhoData cartData = CarrinhoData();
                            cartData.cartQtd = 1;
                            cartData.cartProdId = prod.prodId;
                            cartData.produtoData = prod;
                            ControllerCarrinho.to.carrinho.add(cartData);

                            addProdCarrinho(c.clienteId.value, prod.prodId)
                                .then((value) {
                              if (value == "ok") {
                                return Get.rawSnackbar(
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Color(corGreen),
                                  message: "Add ao carrinho! 😃",
                                );
                              } else {
                                return Get.rawSnackbar(
                                    snackPosition: SnackPosition.BOTTOM,
                                    message: "Ops! tente novamente! 😕",
                                    backgroundColor: Color(corRed));
                              }
                            });
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget cardProdCarrinho(CarrinhoData cart) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: InkWell(
          onLongPress: () {
            Get.bottomSheet(Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Remover item do carrinho?",
                      style: textSemiBold(18, corBackDark)),
                  CupertinoButton(
                      color: CupertinoColors.systemRed,
                      child: Text("Remover"),
                      onPressed: () {
                        delProdCarrinho(cart.cartId).then((value) {
                          if (value == "ok") {
                            ControllerCarrinho.to.carrinho.clear();
                            carregarCarrinho(c.clienteId.value);
                            return Get.back();
                          } else {
                            return Get.rawSnackbar(
                                snackPosition: SnackPosition.BOTTOM,
                                message: "Ops! tente novamente! 😕",
                                backgroundColor: Color(corRed));
                          }
                        });
                      })
                ],
              ),
            ));
          },
          child: Material(
            elevation: 5,
            shadowColor: Colors.white.withOpacity(0.5),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 100,
              width: Get.width,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 2,
                    child: Stack(
                      children: [
                        Container(
                          margin: cart.produtoData.prodImgFit == "full"
                              ? EdgeInsets.all(14)
                              : EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(cart.produtoData.prodImg),
                              fit: cart.produtoData.prodImgFit == "full"
                                  ? BoxFit.cover
                                  : BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            Container(
                              width: Get.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cart.produtoData.prodTitulo +
                                        " - " +
                                        cart.produtoData.prodMarca,
                                    style: textSemiBold(15, corBackDark),
                                  ),
                                  Text(
                                    cart.produtoData.prodUnd == "kg"
                                        ? "Preço por Kg"
                                        : "Preço Unitário",
                                    style: textRegular(14, corGrey),
                                  ),
                                ],
                              ),
                            ),
                            cart.produtoData.prodPrecoDesc != null
                                ? Positioned(
                                    bottom: 0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FlutterMoneyFormatter(
                                            amount: (double.parse(cart
                                                    .produtoData.prodPreco) *
                                                int.parse(
                                                    cart.cartQtd.toString())),
                                            settings: MoneyFormatterSettings(
                                                symbol: "R\$",
                                                decimalSeparator: ","),
                                          ).output.symbolOnLeft,
                                          style: TextStyle(
                                              fontFamily: fontRegular,
                                              fontSize: 11,
                                              color:
                                                  CupertinoColors.inactiveGray,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          FlutterMoneyFormatter(
                                            amount: (double.parse(cart
                                                    .produtoData
                                                    .prodPrecoDesc) *
                                                int.parse(
                                                    cart.cartQtd.toString())),
                                            settings: MoneyFormatterSettings(
                                                symbol: "R\$",
                                                decimalSeparator: ","),
                                          ).output.symbolOnLeft,
                                          style: textSemiBold(15, corGreen),
                                        ),
                                      ],
                                    ),
                                  )
                                : Positioned(
                                    bottom: 5,
                                    left: 0,
                                    child: Text(
                                      FlutterMoneyFormatter(
                                        amount: (double.parse(
                                                cart.produtoData.prodPreco) *
                                            int.parse(cart.cartQtd.toString())),
                                        settings: MoneyFormatterSettings(
                                            symbol: "R\$",
                                            decimalSeparator: ","),
                                      ).output.symbolOnLeft,
                                      style: textSemiBold(16, corGreen),
                                    ),
                                  ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Row(
                                children: [
                                  BaleiaButtons.iconCartRemove(cart.cartQtd ==
                                          "1"
                                      ? null
                                      : () {
                                          remQtdCarrinho(
                                                  cart.cartId, cart.cartQtd)
                                              .then((value) {
                                            ControllerCarrinho.to.carrinho
                                                .clear();
                                            carregarCarrinho(c.clienteId.value);
                                          });
                                        }),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      cart.cartQtd.toString(),
                                      style: textRegular(14, corBackDark),
                                    ),
                                  ),
                                  BaleiaButtons.iconCartAdd(() {
                                    addQtdCarrinho(cart.cartId, cart.cartQtd)
                                        .then((value) {
                                      ControllerCarrinho.to.carrinho.clear();
                                      carregarCarrinho(c.clienteId.value);
                                    });
                                  }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  static Widget cardCategoria(String nome, String imgUrl, int color,
          CategoriasData categoriasData, Controller c) =>
      Padding(
        padding: EdgeInsets.only(right: 8),
        child: Material(
          color: Color(color),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            focusColor: Colors.white,
            highlightColor: Colors.white.withOpacity(0.1),
            hoverColor: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              c.idCat.value = categoriasData.catId;
              Get.to(() => ProdutosUi(categoriasData: categoriasData));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    height: 22,
                    imageUrl: imgUrl,
                    placeholder: (context, url) => CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline),
                  ),
                  SizedBox(width: 10),
                  Text(
                    nome,
                    style: textMedium(15, corBack),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
