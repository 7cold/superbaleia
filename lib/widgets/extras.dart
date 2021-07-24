import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/telas/dados_cliente.dart';
import 'package:superbaleia/telas/login.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'colors.dart';
import 'texts.dart';
import 'package:intl/intl.dart';

final Controller c = Get.find();
final ControllerAdm cadm = Get.find();
final formatter = new NumberFormat("#,##0.00", "pt_BR");

class BaleiaExtras {
  static Widget widgetLoading = Center(
    child: CupertinoActivityIndicator(),
  );

  static Widget drawer(Controller c, List<Widget> list) {
    ClienteData cliente = ClienteData.fromJson(c.clienteData);
    return Container(
      width: Get.context.width / 1.2,
      child: Drawer(
        elevation: 0,
        child: Container(
          color: Color(corBack),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                    child: c.verifLogado().value == false
                        ? Column(
                            children: [
                              Image.asset(
                                "assets/images/logo.png",
                                scale: 1.5,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Por favor, entre ou cadastre-se:",
                                        style: textRegular(
                                          14,
                                          corBackDark,
                                        ),
                                      ),
                                    ),
                                    BaleiaButtons.buttonText("Login", () {
                                      Get.to(() => LoginUi());
                                    })
                                  ],
                                ),
                              )
                            ],
                          )
                        : SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Text(
                                  cliente.nome,
                                  style: textHeavy(22, corBackDark),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  cliente.endereco + " - " + cliente.numero,
                                  style: textLight(16, corGrey),
                                ),
                                Text(
                                  cliente.email,
                                  style: textLight(16, corGrey),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Material(
                    shadowColor: CupertinoColors.tertiaryLabel.withAlpha(40),
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: list,
                      ),
                    ),
                  ),
                ),
                c.verifLogado().value == false
                    ? SizedBox()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                              c.sair();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(corRed),
                                        ),
                                        child: Icon(
                                          Icons.logout_rounded,
                                          size: 18,
                                          color: Color(corBack),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Sair",
                                        style: textRegular(16, 0XFF6B6B6C),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    CupertinoIcons.chevron_right,
                                    size: 18,
                                    color: Color(corGrey),
                                  )
                                ],
                              ),
                            ),
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

  static Widget drawerAdm(ControllerAdm c, List<Widget> list) {
    return Container(
      child: Drawer(
        elevation: 0,
        child: Container(
          color: Color(corBack),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 30),
                          child: Material(
                            shadowColor:
                                CupertinoColors.tertiaryLabel.withAlpha(40),
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: list,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 40),
                  child: InkWell(
                    onTap: () {
                      c.sairAdm();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(corRed),
                                ),
                                child: Icon(Icons.logout_rounded,
                                    size: 18, color: Color(corBack)),
                              ),
                              SizedBox(width: 10),
                              Text("Sair", style: textRegular(16, 0XFF6B6B6C)),
                            ],
                          ),
                          Icon(CupertinoIcons.chevron_right,
                              size: 18, color: Color(corGrey))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget itemDrawer(IconData icon, String label, Widget page) {
    return InkWell(
      onTap: () {
        Get.back();
        Get.to(() => page, transition: Transition.rightToLeft);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(corPri),
                      ),
                      child: Icon(icon, size: 18, color: Color(corBack)),
                    ),
                    SizedBox(width: 10),
                    Text(label, style: textRegular(16, 0XFF6B6B6C)),
                  ],
                ),
                Icon(CupertinoIcons.chevron_right,
                    size: 18, color: Color(corGrey))
              ],
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 0.4,
            )
          ],
        ),
      ),
    );
  }

  static Widget appBar(String title) => AppBar(
        elevation: 5,
        shadowColor: Colors.white.withOpacity(0.2),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          title.toString(),
          style: textSemiBold(20, corBackDark),
        ),
        iconTheme: IconThemeData(
          color: Color(corBackDark),
        ),
      );

  static Widget appBarCart(String title, String qtd) => AppBar(
        elevation: 5,
        shadowColor: Colors.white.withOpacity(0.2),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(top: 22, bottom: 22, right: 15),
            padding: EdgeInsets.only(left: 13, right: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(corPri),
            ),
            child: Center(child: Text(qtd, style: textSemiBold(16, corBack))),
          )
        ],
        title: Text(
          title.toString(),
          style: textSemiBold(20, corBackDark),
        ),
        iconTheme: IconThemeData(
          color: Color(corBackDark),
        ),
      );

  static Widget iconFreteGratis() => Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
            color: CupertinoColors.activeBlue,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            "FRETE GRÁTIS",
            style: textRegular(10, corBack),
          ),
        ),
      );

  static Widget iconDesconto() => Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
            color: CupertinoColors.systemOrange,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            "OFERTA",
            style: textRegular(10, corBack),
          ),
        ),
      );

  static Widget nenhumProd() => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/pag_nenhum_prod.png",
                scale: 9,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  "Nenhum produto, volte para continuar! 😕",
                  style: textRegular(18, corBackDark),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );

  static Widget nenhumPedido() => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/nenhum_pedido.png",
                scale: 9,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  "Nenhum pedido, volte para continuar! 😕",
                  style: textRegular(18, corBackDark),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );

  static Widget iconCarrinhoMl(String ml) => Padding(
        padding: EdgeInsets.only(right: 12),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(corPri),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                Icons.local_drink,
                size: 12,
                color: Color(corBack),
              ),
            ),
            SizedBox(width: 5),
            Text(
              ml + " ml",
              style: textRegular(13, corGrey),
            ),
          ],
        ),
      );

  static Widget iconCarrinhoKg(String ml) => Padding(
        padding: EdgeInsets.only(right: 12),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(corPri),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                Icons.fitness_center_rounded,
                size: 13,
                color: Color(corBack),
              ),
            ),
            SizedBox(width: 5),
            Text(
              ml + " kg",
              style: textRegular(13, corGrey),
            ),
          ],
        ),
      );

  static Widget meusPedidosItens(String docId) {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    return Padding(
      padding: EdgeInsets.only(bottom: 35),
      child: Material(
        shadowColor: CupertinoColors.tertiaryLabel.withAlpha(40),
        borderRadius: BorderRadius.circular(10),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("pedidos")
                  .doc(docId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return BaleiaExtras.widgetLoading;
                } else {
                  PedidoData pedido = PedidoData.fromDocument(snapshot.data);
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Pedido ID", style: textSemiBold(18, corGrey)),
                            Text("#" + pedido.id.substring(0, 6),
                                style: textSemiBold(18, corPri)),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Data", style: textSemiBold(18, corGrey)),
                            Text(
                                DateFormat('dd/MM/yy')
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                        pedido.data.millisecondsSinceEpoch))
                                    .toString(),
                                style: textSemiBold(18, corPri)),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 10, top: 15, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Itens do Pedido",
                                style: textSemiBold(18, corGrey)),
                            InkWell(
                              onTap: () {
                                Get.bottomSheet(Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text("Itens do Pedido",
                                          style: textBold(22, corBackDark)),
                                      SizedBox(height: 30),
                                      SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: pedido.produtos.map((res) {
                                            var preco = res['produto']['preco'];
                                            var precoDesc =
                                                res['produto']['precoDesc'];
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      res['qtd'].toString(),
                                                      style: textSemiBold(
                                                          16, corBackDark),
                                                    ),
                                                    SizedBox(width: 15),
                                                    Text(
                                                        res['produto']
                                                            ['titulo'],
                                                        style: textRegular(
                                                            16, corGrey)),
                                                  ],
                                                ),
                                                Text(
                                                  "R\$ " +
                                                      formatter.format(
                                                        (precoDesc != preco
                                                                ? precoDesc
                                                                : preco) *
                                                            res['qtd'],
                                                      ),
                                                  style: textSemiBold(
                                                      16, corBackDark),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                              },
                              child: Row(
                                children: [
                                  Text(
                                      pedido.produtos.length.toString() +
                                          " Itens",
                                      style: textSemiBold(18, corBackDark)),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(corGrey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total", style: textSemiBold(18, corGrey)),
                            Text("R\$ " + formatter.format(pedido.totalPedido),
                                style: textSemiBold(18, corPri)),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Status", style: textSemiBold(18, corGrey)),
                            BaleiaExtras.widgetEntrega(
                                pedido.status, 18, pedido.id)
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  static Widget finalizarUiEndereco() {
    return Material(
      elevation: 5,
      shadowColor: Colors.white.withAlpha(50),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: Get.context.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 8, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Endereço", style: textSemiBold(18, corGrey)),
                  BaleiaButtons.buttonText("Alterar", () {
                    Get.to(
                        () => DadosClienteUi(telaAnterior: "finalizar_compra"));
                  })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 5, bottom: 20),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 2,
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color:
                                CupertinoColors.tertiarySystemGroupedBackground,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("assets/images/map.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              width: Get.context.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.place_outlined,
                                        color: Color(corGrey),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          c.clienteData['endereco'] +
                                              ", " +
                                              c.clienteData['num'] +
                                              " - " +
                                              c.clienteData['bairro'],
                                          style: textLight(16, corBackDark),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person_outline_rounded,
                                        color: Color(corGrey),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          c.clienteData['nome'] +
                                              " " +
                                              c.clienteData['sobrenome'],
                                          style: textLight(16, corBackDark),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.smartphone_rounded,
                                        color: Color(corGrey),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          c.clienteData['celular'],
                                          style: textLight(16, corBackDark),
                                        ),
                                      ),
                                    ],
                                  ),
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
          ],
        ),
      ),
    );
  }

  static Widget finalizarUiEntrega() {
    Future<void> _selectDate(BuildContext context) async {
      DateTime picked = await showDatePicker(
          context: context,
          initialDate: c.diaEntrega.value,
          firstDate: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              DateTime.now().hour,
              DateTime.now().minute - 2),
          lastDate: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 7));
      if (picked != null && picked != c.diaEntrega.value)
        c.diaEntrega.value = picked;
    }

    Future<void> _selectHours(BuildContext context) async {
      TimeOfDay picked = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.dial,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null && picked != c.horaEntrega.value)
        c.horaEntrega.value = picked;
    }

    return Material(
      elevation: 5,
      shadowColor: Colors.white.withAlpha(50),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: Get.context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Detalhes da Entrega", style: textSemiBold(18, corGrey)),
                  c.tipoEntega.value == "Entrega agendada"
                      ? Tooltip(
                          message: "Entregas somente em horário comercial.",
                          child: Icon(
                            Icons.info_outline,
                            color: Color(corGrey),
                            size: 22,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                width: Get.context.width,
                decoration: BoxDecoration(
                  color: CupertinoColors.tertiarySystemGroupedBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                  style: textRegular(18, corBackDark),
                  underline: SizedBox(),
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Color(corBackDark),
                  ),
                  hint: Text(c.tipoEntega.value),
                  items: [
                    'Entregar a qualquer momento',
                    'Entrega agendada',
                    'Retirada no mercado',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (_) {
                    c.tipoEntega.value = _;
                  },
                ),
              ),
            ),
            c.tipoEntega.value == "Entrega agendada"
                ? Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 20, right: 20, bottom: 20),
                    child: Container(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        width: Get.context.width,
                        decoration: BoxDecoration(
                          color:
                              CupertinoColors.tertiarySystemGroupedBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //data
                            CupertinoButton(
                                child: Text(DateFormat('dd/MM/yy')
                                    .format(c.diaEntrega.value)),
                                onPressed: () {
                                  _selectDate(Get.context);
                                }),
                            //hora
                            CupertinoButton(
                                child: Text(
                                    c.horaEntrega.value.format(Get.context)),
                                onPressed: () {
                                  _selectHours(Get.context);
                                }),
                          ],
                        )),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  static Widget finalizarUiResumo() {
    return Material(
      elevation: 5,
      shadowColor: Colors.white.withAlpha(50),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: Get.context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Resumo", style: textSemiBold(18, corGrey)),
                ],
              ),
            ),
            Divider(
              thickness: 0.4,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Valor", style: textSemiBold(18, corGrey)),
                  Text(
                      "R\$ " +
                          formatter.format(c.getProductsPrice()).toString(),
                      style: textRegular(18, corBackDark)),
                ],
              ),
            ),
            Divider(
              thickness: 0.4,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Frete", style: textSemiBold(18, corGrey)),
                  Text("R\$ " + formatter.format(c.getShipPrice()).toString(),
                      style: textRegular(18, corBackDark)),
                ],
              ),
            ),
            Divider(
              thickness: 0.4,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: textSemiBold(18, corGrey)),
                  Text("R\$ " + formatter.format(c.getTotalPrice()).toString(),
                      style: textSemiBold(18, corPri)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget finalizarUiPagamento() {
    return Material(
      elevation: 5,
      shadowColor: Colors.white.withAlpha(50),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: Get.context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Forma de Pagamento", style: textSemiBold(18, corGrey)),
                ],
              ),
            ),
            Divider(
              thickness: 0.4,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cartão", style: textSemiBold(18, corGrey)),
                  Checkbox(
                    checkColor: Colors.white,
                    value: c.formaPag.value == 1 ? true : false,
                    shape: CircleBorder(),
                    onChanged: (_) {
                      _ == true
                          ? c.formaPag.value = 1
                          : c.formaPag.value = null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dinheiro", style: textSemiBold(18, corGrey)),
                  Checkbox(
                    checkColor: Colors.white,
                    value: c.formaPag.value == 2 ? true : false,
                    shape: CircleBorder(),
                    onChanged: (_) {
                      _ == true
                          ? c.formaPag.value = 2
                          : c.formaPag.value = null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Pix", style: textSemiBold(18, corGrey)),
                  Checkbox(
                    checkColor: Colors.white,
                    value: c.formaPag.value == 3 ? true : false,
                    shape: CircleBorder(),
                    onChanged: (_) {
                      _ == true
                          ? c.formaPag.value = 3
                          : c.formaPag.value = null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget localizacao(String cidade, String endereco, String tel) {
    return Material(
      elevation: 5,
      shadowColor: Colors.white.withAlpha(50),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
          width: Get.context.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cidade, style: textSemiBold(18, corGrey)),
                ],
              ),
              SizedBox(height: 20),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                        width: Get.context.width,
                        child: Text("Rua:", style: textSemiBold(16, corGrey)),
                      )),
                  Flexible(
                      flex: 6,
                      child: Container(
                        width: Get.context.width,
                        child:
                            Text(endereco, style: textRegular(16, corBackDark)),
                      )),
                ],
              ),
              SizedBox(height: 20),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                        width: Get.context.width,
                        child:
                            Text("Telefone:", style: textSemiBold(16, corGrey)),
                      )),
                  Flexible(
                      flex: 6,
                      child: Container(
                        width: Get.context.width,
                        child: Text(tel, style: textRegular(16, corBackDark)),
                      )),
                ],
              ),
            ],
          )),
    );
  }

  static Widget ajudaCard() {
    return Material(
      elevation: 5,
      shadowColor: Colors.white.withAlpha(50),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
          width: Get.context.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("WhatsApp", style: textSemiBold(18, corGrey)),
                ],
              ),
              SizedBox(height: 20),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                        width: Get.context.width,
                        child:
                            Text("Telefone", style: textSemiBold(18, corGrey)),
                      )),
                  Flexible(
                      flex: 6,
                      child: Container(
                        width: Get.context.width,
                        child: Text("35-99999-99999",
                            style: textRegular(18, corBackDark)),
                      )),
                ],
              ),
            ],
          )),
    );
  }

  static Widget widgetEntrega(int status, double fsize, String pedId) {
    return Container(
      height: 33,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: status == 1
            ? CupertinoColors.activeBlue
            : status == 2
                ? CupertinoColors.activeOrange
                : status == 3
                    ? CupertinoColors.activeGreen
                    : status == 4
                        ? CupertinoColors.systemRed
                        : CupertinoColors.black,
      ),
      child: DropdownButton(
        style: textRegular(18, corBackDark),
        underline: SizedBox(),
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: Color(corBack),
        ),
        hint: Text(
          status == 1
              ? "Preparando"
              : status == 2
                  ? "Enviando"
                  : status == 3
                      ? "Entregue"
                      : status == 4
                          ? "Cancelado"
                          : "ERROR",
          style: textRegular(fsize, corBack),
        ),
        items: [
          'Preparando',
          'Enviando',
          'Entregue',
          'Cancelado',
        ].map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (_) {
          var status;

          switch (_) {
            case "Preparando":
              status = 1;
              break;
            case "Enviando":
              status = 2;
              break;
            case "Entregue":
              status = 3;
              break;
            case "Cancelado":
              status = 4;
              break;
            default:
          }

          cadm.alterarStatusPed(pedId, status);
        },
      ),

      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Text(
      //       "Preparando",
      //       style: textRegular(fsize, corBack),
      //     ),
      //     Icon(
      //       Icons.drag_indicator_sharp,
      //       size: 14,
      //       color: Colors.white,
      //     ),
      //   ],
      // ),
    );

    // switch (status) {
    //   case 1:
    //     return Container(
    //       padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //         color: CupertinoColors.activeBlue,
    //       ),
    //       child: DropdownButton(
    //         style: textRegular(18, corBackDark),
    //         underline: SizedBox(),
    //         isExpanded: true,
    //         icon: Icon(
    //           Icons.arrow_drop_down_rounded,
    //           color: Color(corBackDark),
    //         ),
    //         hint: Text("categoria.value"),
    //         items: [
    //           'bebidas',
    //           'bebidas alcoolicas',
    //           'carnes e peixaria',
    //         ].map((String value) {
    //           return DropdownMenuItem<String>(value: value, child: Text(value));
    //         }).toList(),
    //         onChanged: (_) {},
    //       ),

    //       // Row(
    //       //   crossAxisAlignment: CrossAxisAlignment.center,
    //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       //   children: [
    //       //     Text(
    //       //       "Preparando",
    //       //       style: textRegular(fsize, corBack),
    //       //     ),
    //       //     Icon(
    //       //       Icons.drag_indicator_sharp,
    //       //       size: 14,
    //       //       color: Colors.white,
    //       //     ),
    //       //   ],
    //       // ),
    //     );

    //     break;
    //   case 2:
    //     return Container(
    //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //         color: CupertinoColors.activeOrange,
    //       ),
    //       child: Center(
    //         child: Text(
    //           "Enviando",
    //           style: textRegular(fsize, corBack),
    //         ),
    //       ),
    //     );
    //     break;

    //   case 3:
    //     return Container(
    //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //         color: CupertinoColors.activeGreen,
    //       ),
    //       child: Center(
    //         child: Text(
    //           "Entregue",
    //           style: textRegular(fsize, corBack),
    //         ),
    //       ),
    //     );
    //     break;
    //   case 4:
    //     return Container(
    //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //         color: CupertinoColors.destructiveRed,
    //       ),
    //       child: Center(
    //         child: Text(
    //           "Cancelado",
    //           style: textRegular(fsize, corBack),
    //         ),
    //       ),
    //     );
    //     break;
    //   default:
    //     return Container();
  }
}
