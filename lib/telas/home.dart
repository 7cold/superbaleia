import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/categorias_data.dart';
import 'package:superbaleia/telas/ajuda.dart';
import 'package:superbaleia/telas/carrinho.dart';
import 'package:superbaleia/telas/localizacao.dart';
import 'package:superbaleia/telas/pedidos.dart';
import 'package:superbaleia/telas/pratos_dicas.dart';
import 'package:superbaleia/telas/todas_categorias.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/card.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';
import 'dados_cliente.dart';

class HomeUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());

    return Obx(
      () => c.carregando.value == true
          ? Scaffold(
              body: BaleiaExtras.widgetLoading,
            )
          : Scaffold(
              appBar: AppBar(
                toolbarHeight: 80,
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
                title: Text('Inicio', style: textSemiBold(20, corBackDark)),
                centerTitle: true,
                actions: [
                  c.verifLogado().value == false
                      ? SizedBox()
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(corPri),
                              ),
                              margin: EdgeInsets.only(right: 10),
                              child: IconButton(
                                onPressed: () {
                                  Get.to(() => CarrinhoUi());
                                },
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Color(corBack),
                                  size: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 4,
                              top: 8,
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(5),
                                shadowColor: Colors.blue[900],
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[900],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    c.carrinho.length.toString(),
                                    style: textSemiBold(14, corBack),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
              drawer: BaleiaExtras.drawer(
                  c,
                  c.clienteData['nome'] == null
                      ? [
                          BaleiaExtras.itemDrawer(
                            Icons.list_alt_outlined,
                            "Todos as Categorias",
                            TodasCategoriasUi(),
                          ),
                          BaleiaExtras.itemDrawer(
                            Icons.map_rounded,
                            "Localização",
                            LocalizacaoUi(),
                          ),
                          BaleiaExtras.itemDrawer(
                            Icons.help_outline_rounded,
                            "Ajuda",
                            AjudaUI(),
                          ),
                        ]
                      : [
                          BaleiaExtras.itemDrawer(
                            Icons.person_outline_rounded,
                            "Meus Dados",
                            DadosClienteUi(telaAnterior: "drawer"),
                          ),
                          BaleiaExtras.itemDrawer(
                            Icons.shopping_cart_outlined,
                            "Carrinho",
                            CarrinhoUi(),
                          ),
                          BaleiaExtras.itemDrawer(
                            Icons.list_alt_outlined,
                            "Todos as Categorias",
                            TodasCategoriasUi(),
                          ),
                          BaleiaExtras.itemDrawer(
                            Icons.paste,
                            "Meus Pedidos",
                            PedidosUi(),
                          ),
                          BaleiaExtras.itemDrawer(
                            Icons.map_rounded,
                            "Localização",
                            LocalizacaoUi(),
                          ),
                          BaleiaExtras.itemDrawer(
                            Icons.help_outline_rounded,
                            "Ajuda",
                            AjudaUI(),
                          ),
                        ]),
              backgroundColor: Color(corBack),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //retirada do espacamento pq tem efeito gradiente no fundo
                      // SizedBox(height: 10),
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
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 35, left: 20, right: 20),
                                child: c.categorias.length == 0
                                    ? SizedBox(
                                        width: context.width,
                                        child: BaleiaExtras.widgetLoading,
                                      )
                                    : Row(
                                        children: c.categorias.map((doc) {
                                          CategoriaData cat = doc;
                                          return BaleiaCards.cardCategoria(cat);
                                        }).toList(),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BaleiaCards.cardSlide(
                          Get.context.width,
                          170,
                          c.banners.map((doc) {
                            return BaleiaCards.cardSlideItem(doc['img']);
                          }).toList()),
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
                            BaleiaButtons.buttonText(
                                "Ver Todas",
                                () => Get.to(() => PratosDicasUi(
                                      tipo: "dicas",
                                    )))
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
                            children: c.dicas.map((dicaData) {
                              return BaleiaCards.cardDicas(dicaData);
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 0, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pratos",
                              style: textHeavy(
                                22,
                                corBackDark,
                              ),
                            ),
                            BaleiaButtons.buttonText(
                                "Ver Todos",
                                () => Get.to(() => PratosDicasUi(
                                      tipo: "pratos",
                                    )))
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 15),
                          child: Row(
                            children: c.pratos.map((dicaData) {
                              return BaleiaCards.cardPratos(dicaData);
                            }).toList(),
                          ),
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
                                      "Mais informações",
                                      context.width,
                                      40,
                                      () async {}),
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
            ),
    );
  }
}
