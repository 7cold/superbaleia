import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/data/categorias_data.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:superbaleia/data/dicas_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/telas/produto_detalhe.dart';
import 'package:superbaleia/telas/produtos.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/fonts.dart';
import 'buttons.dart';
import 'colors.dart';
import 'texts.dart';

final Controller c = Get.find();
ClienteData cliente = ClienteData.fromJson(c.clienteData);

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

  static Widget cardTips(DicaData dica) => Padding(
        padding: EdgeInsets.only(left: 10, bottom: 24),
        child: Material(
          elevation: 5,
          shadowColor: Colors.white.withAlpha(50),
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
                        image: NetworkImage(dica.img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                      width: Get.context.width,
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
                              dica.titulo,
                              style: textBold(13, corBackDark),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dica.tempo.toString() + " min",
                                  style: textRegular(12, corGrey),
                                ),
                                Text(
                                  dica.kcal.toString() + " kcal",
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

  static Widget cardPratos(DicaData dica) => Padding(
        padding: EdgeInsets.only(left: 10, bottom: 24, right: 10),
        child: Material(
          elevation: 5,
          shadowColor: Colors.white.withAlpha(50),
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
                      image: NetworkImage(dica.img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: Get.context.width,
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
                          dica.titulo,
                          style: textBold(16, corBack),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              dica.tempo.toString() + " min",
                              style: textMedium(14, corGrey),
                            ),
                            Text(
                              "  •  ",
                              style: textMedium(14, corGrey),
                            ),
                            Text(
                              dica.kcal.toString() + " kcal",
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

  static Widget cardProd(ProdutoData prod, String catId) {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      child: Material(
        elevation: 5,
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Get.to(() => ProdutoDetalheUi(prod: prod, catId: catId));
          },
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
                        margin: prod.img == "full"
                            ? EdgeInsets.all(0)
                            : EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(prod.img),
                            fit: prod.imgFit == "full"
                                ? BoxFit.cover
                                : BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 6,
                        bottom: 6,
                        child: prod.precoDesc != prod.preco
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
                            width: Get.context.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  prod.titulo,
                                  style: textSemiBold(15, corBackDark),
                                ),
                                Text(
                                  prod.unidadeMed == "unitario"
                                      ? "Preço Unitário"
                                      : prod.unidadeMed == "por massa"
                                          ? "Preço por peso"
                                          : "Preço por capacidade",
                                  style: textRegular(15, corGrey),
                                ),
                              ],
                            ),
                          ),
                          prod.precoDesc != prod.preco
                              ? Positioned(
                                  bottom: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "R\$" +
                                            formatter
                                                .format(prod.preco)
                                                .toString(),
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
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "R\$ ",
                                                style:
                                                    textRegular(10, corOrange)),
                                            TextSpan(
                                              text: formatter
                                                  .format(prod.precoDesc)
                                                  .toString(),
                                              style:
                                                  textSemiBold(15, corOrange),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Positioned(
                                  bottom: 5,
                                  left: 0,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "R\$ ",
                                            style: textRegular(10, corGreen)),
                                        TextSpan(
                                          text: formatter
                                              .format(prod.precoDesc)
                                              .toString(),
                                          style: textSemiBold(16, corGreen),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: c.verifLogado().value == false
                                ? Container(
                                    color: Color(corBack),
                                  )
                                : BaleiaButtons.iconButtonCart(() async {
                                    CarrinhoData cart = CarrinhoData();

                                    cart.categoria = catId;
                                    cart.data =
                                        Timestamp.fromDate(DateTime.now());
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
  }

  static Widget cardProdCarrinho(CarrinhoData cart) {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Material(
        elevation: 5,
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          focusColor: Colors.white,
          highlightColor: Colors.blue[100].withOpacity(0.1),
          hoverColor: Colors.blue[100].withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          onLongPress: () {
            Get.bottomSheet(
              Container(
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
                          c.removeCartItem(cart);
                          Get.back();
                        })
                  ],
                ),
              ),
            );
          },
          child: Container(
            height: 110,
            width: Get.context.width,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 2,
                  child: Stack(
                    children: [
                      Container(
                        margin: cart.produtoData.imgFit == "full"
                            ? EdgeInsets.all(14)
                            : EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(cart.produtoData.img),
                            fit: cart.produtoData.imgFit == "full"
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
                            width: Get.context.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cart.produtoData.titulo,
                                  style: textSemiBold(16, corBackDark),
                                ),
                                Text(
                                  cart.produtoData.marca,
                                  style: textRegular(16, corBackDark),
                                ),
                              ],
                            ),
                          ),
                          cart.produtoData.precoDesc != cart.produtoData.preco
                              ? Positioned(
                                  bottom: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "R\$" +
                                            formatter
                                                .format(cart.produtoData.preco)
                                                .toString(),
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
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: "R\$ ",
                                                    style: textRegular(
                                                        10, corOrange)),
                                                TextSpan(
                                                  text: formatter
                                                      .format(cart.produtoData
                                                          .precoDesc)
                                                      .toString(),
                                                  style: textSemiBold(
                                                      16, corOrange),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          cart.qtd > 1
                                              ? RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: "R\$ ",
                                                          style: textRegular(
                                                              8, corGrey)),
                                                      TextSpan(
                                                        text: formatter
                                                            .format(cart
                                                                    .produtoData
                                                                    .preco *
                                                                cart.qtd)
                                                            .toString(),
                                                        style: textSemiBold(
                                                            14, corGrey),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Positioned(
                                  bottom: 0,
                                  child: Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "R\$ ",
                                                style:
                                                    textRegular(10, corGreen)),
                                            TextSpan(
                                              text: formatter
                                                  .format(
                                                      cart.produtoData.preco)
                                                  .toString(),
                                              style: textSemiBold(16, corGreen),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      cart.qtd > 1
                                          ? RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "R\$ ",
                                                      style: textRegular(
                                                          8, corGrey)),
                                                  TextSpan(
                                                    text: formatter
                                                        .format(cart.produtoData
                                                                .preco *
                                                            cart.qtd)
                                                        .toString(),
                                                    style: textSemiBold(
                                                        14, corGrey),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Row(
                              children: [
                                BaleiaButtons.iconCartRemove(cart.qtd == 1
                                    ? null
                                    : () {
                                        c.decProduct(cart);
                                      }),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    cart.qtd.toString(),
                                    style: textRegular(14, corBackDark),
                                  ),
                                ),
                                BaleiaButtons.iconCartAdd(() {
                                  c.incProduct(cart);
                                }),
                              ],
                            ),
                          ),
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
  }

  static Widget cardCategoria(CategoriaData cat) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: Material(
        color: Color(int.parse(cat.color)),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          focusColor: Colors.white,
          highlightColor: Colors.white.withOpacity(0.1),
          hoverColor: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Get.to(() => ProdutosUi(cat: cat));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  height: 22,
                  imageUrl: cat.icone,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline),
                ),
                SizedBox(width: 10),
                Text(
                  cat.titulo,
                  style: textMedium(15, corBack),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget cardTodasCat(CategoriaData cat) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Material(
        elevation: 5,
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          focusColor: Colors.white,
          highlightColor: Colors.blue[50].withOpacity(0.1),
          hoverColor: Colors.blue[200].withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Get.to(() => ProdutosUi(cat: cat));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
            width: Get.context.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      height: 22,
                      imageUrl: cat.icone,
                      placeholder: (context, url) =>
                          CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline),
                    ),
                    SizedBox(width: 10),
                    Text(
                      cat.titulo,
                      style: textRegular(20, corBackDark),
                    )
                  ],
                ),
                Icon(CupertinoIcons.chevron_right, size: 18)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
