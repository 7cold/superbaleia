import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/categorias_data.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:superbaleia/data/dicas_data.dart';
import 'package:superbaleia/telas/dados_cliente.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/card.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/forms.dart';
import 'package:superbaleia/widgets/texts.dart';

class HomeUi extends StatelessWidget {
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      ClienteData cliente = ClienteData.fromJson(c.dadosCliente);
      return Scaffold(
        appBar: c.dadosCliente['cliente_nome'] != null
            ? AppBar(
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(
                        Icons.menu_rounded,
                        color: Color(corPri),
                        size: 30,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Color(corPri),
                        size: 30,
                      ),
                    ),
                  ),
                ],
              )
            : null,
        drawer: c.dadosCliente['cliente_nome'] != null
            ? BaleiaExtras.drawer(cliente, c, [
                BaleiaExtras.itemDrawer(
                  Icons.person_outline_rounded,
                  "Meus Dados",
                  DadosClienteUi(),
                ),
                BaleiaExtras.itemDrawer(
                  Icons.shopping_cart_outlined,
                  "Carrinho",
                  DadosClienteUi(),
                ),
                BaleiaExtras.itemDrawer(
                  Icons.paste,
                  "Meus Pedidos",
                  DadosClienteUi(),
                ),
                BaleiaExtras.itemDrawer(
                  Icons.help_outline_rounded,
                  "Ajuda",
                  DadosClienteUi(),
                ),
              ])
            : null,
        backgroundColor: Color(corBack),
        body: SafeArea(
          child: c.dadosCliente['cliente_nome'] != null
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Color(corBack),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            BaleiaForms.textFormFielSearch(
                                "Pesquisar...", (null)),
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 35, bottom: 35, left: 20, right: 20),
                                child: Row(
                                    children: c.categorias.map((res) {
                                  CategoriasData catData =
                                      CategoriasData.fromJson(res);
                                  return BaleiaCards.cardCategoria(
                                      catData.catNome,
                                      catData.catImagem,
                                      catData.catCor,
                                      catData,
                                      c);
                                }).toList()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BaleiaCards.cardSlide(
                          Get.context.width,
                          170,
                          c.banners
                              .map((banner) => BaleiaCards.cardSlideItem(
                                  banner['banner_img']))
                              .toList()),
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 35, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Dicas do dia",
                              style: textHeavy(
                                22,
                                corBackDark,
                              ),
                            ),
                            BaleiaButtons.buttonText("Ver Todas", () {})
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 15),
                          child: Row(
                              children: c.dicas.map((res) {
                            DicasData dicaData = DicasData.fromJson(res);
                            return BaleiaCards.cardTips(dicaData);
                          }).toList()),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 0, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lanches rápidos",
                              style: textHeavy(
                                22,
                                corBackDark,
                              ),
                            ),
                            BaleiaButtons.buttonText("Ver Todos", () {})
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 0),
                          child: Row(
                              children: c.dicas.map((res) {
                            DicasData dicaData = DicasData.fromJson(res);
                            return BaleiaCards.cardPratos(dicaData);
                          }).toList()),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 40, top: 20),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BaleiaButtons.buttonSecondary(
                                      "Mais informações", Get.context.width, 40,
                                      () async {
                                    //c.logoutCliente();
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : BaleiaExtras.widgetLoading,
        ),
      );
    });
  }
}
