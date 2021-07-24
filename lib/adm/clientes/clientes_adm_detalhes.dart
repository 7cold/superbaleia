import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/adm/pedidos/pedidos_detalhes_adm.dart';
import 'package:superbaleia/adm/widgets/baleiaAdmWidgets.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:intl/intl.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';

final formatter = new NumberFormat("#,##0.00", "pt_BR");

class ClientesDetalhesAdm extends StatelessWidget {
  final ClienteData cliente;
  const ClientesDetalhesAdm({@required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corBack),
      appBar: BaleiaAdm.appBar(cliente.nome, [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: IconButton(
            tooltip: "Imprimir Info.",
            onPressed: () {},
            icon: Icon(Icons.print_outlined),
          ),
        )
      ]),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ResponsiveGridRow(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveGridCol(
              xl: 6,
              lg: 6,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Material(
                  elevation: 5,
                  shadowColor: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dados",
                          style: textBold(22, corBackDark),
                        ),
                        SizedBox(height: 20),
                        Row(children: [
                          Text("Nome: ", style: textLight(16, corGrey)),
                          Text(cliente.nome + " " + cliente.sobrenome,
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Cliente ID: ", style: textLight(16, corGrey)),
                          Text(cliente.id.toString(),
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("CPF: ", style: textLight(16, corGrey)),
                          Text(cliente.cpf,
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("E-mail: ", style: textLight(16, corGrey)),
                          Text(cliente.email,
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Celular: ", style: textLight(16, corGrey)),
                          Text(cliente.celular,
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Dt. Cadastro: ", style: textLight(16, corGrey)),
                          Text(
                              DateFormat('dd/MM/yy - HH:mm - EE', "pt_BR")
                                  .format(DateTime.fromMicrosecondsSinceEpoch(
                                      cliente
                                          .dataCadastro.microsecondsSinceEpoch))
                                  .capitalize,
                              style: textRegular(16, corBackDark)),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              xl: 6,
              lg: 6,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Material(
                  elevation: 5,
                  shadowColor: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Entrega",
                          style: textBold(22, corBackDark),
                        ),
                        SizedBox(height: 20),
                        Row(children: [
                          Text("Endereço: ", style: textLight(16, corGrey)),
                          Text(cliente.endereco + ", " + cliente.numero,
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Bairro: ", style: textLight(16, corGrey)),
                          Text(cliente.bairro,
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Cidade: ", style: textLight(16, corGrey)),
                          Text(cliente.cidade,
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Complemento: ", style: textLight(16, corGrey)),
                          Text(cliente.complemento,
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              xl: 12,
              lg: 12,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Material(
                  elevation: 5,
                  shadowColor: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pedidos",
                          style: textBold(22, corBackDark),
                        ),
                        SizedBox(height: 20),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("clientes")
                                .doc(cliente.id)
                                .collection("pedidos")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return BaleiaExtras.widgetLoading;
                              } else {
                                return SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: snapshot.data.docs.length == 0
                                        ? [
                                            Center(
                                                child: BaleiaExtras
                                                    .nenhumPedido()),
                                          ]
                                        : snapshot.data.docs
                                            .map((doc) {
                                              String pedId = doc['pedidoId'];
                                              return StreamBuilder<
                                                      DocumentSnapshot>(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("pedidos")
                                                      .doc(pedId)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return BaleiaExtras
                                                          .widgetLoading;
                                                    } else {
                                                      PedidoData ped =
                                                          PedidoData
                                                              .fromDocument(
                                                                  snapshot
                                                                      .data);
                                                      return _Item(ped: ped);
                                                    }
                                                  });
                                            })
                                            .toList()
                                            .reversed
                                            .toList(),
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
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

class _Item extends StatelessWidget {
  final PedidoData ped;

  const _Item({@required this.ped});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(10),
          shadowColor: Colors.white.withAlpha(50),
          color: Colors.white,
          elevation: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            hoverColor: Color(corPri).withAlpha(30),
            highlightColor: Color(corBack).withAlpha(10),
            splashColor: Colors.transparent,
            onTap: () {
              Get.to(() => PedidosDetalhesAdm(
                    ped: ped,
                  ));
            },
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(10),
              width: Get.context.width,
              child: ResponsiveGridRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResponsiveGridCol(
                    lg: 2,
                    child: Text(
                      "#" + ped.id.substring(0, 6),
                      style: textRegular(14, corGrey),
                    ),
                  ),
                  ResponsiveGridCol(
                    lg: 2,
                    child: Text(
                      ped.produtos.length == 1
                          ? ped.produtos.length.toString() + " Item"
                          : ped.produtos.length.toString() + " Itens",
                      style: textRegular(14, corBackDark),
                    ),
                  ),
                  ResponsiveGridCol(
                    lg: 2,
                    child: Text(
                      DateFormat('dd/MM/yy - HH:mm - EEE', "pt_BR").format(
                          DateTime.fromMicrosecondsSinceEpoch(
                              ped.data.microsecondsSinceEpoch)),
                      style: textRegular(14, corBackDark),
                    ),
                  ),
                  ResponsiveGridCol(
                    lg: 2,
                    child: Row(
                      children: [
                        Icon(
                          ped.formaPag == "Cartão"
                              ? Icons.credit_card_rounded
                              : ped.formaPag == "Pix"
                                  ? Icons.transform_rounded
                                  : Icons.monetization_on_outlined,
                          size: 16,
                          color: ped.formaPag == "Cartão"
                              ? Colors.orange[800]
                              : ped.formaPag == "Pix"
                                  ? Colors.blue
                                  : Colors.green[600],
                        ),
                        SizedBox(width: 10),
                        Text(
                          ped.formaPag,
                          style: textRegular(14, corBackDark),
                        ),
                      ],
                    ),
                  ),
                  ResponsiveGridCol(
                    lg: 2,
                    child: Text(
                      "R\$ " + formatter.format(ped.totalPedido),
                      style: textRegular(14, corGreen),
                    ),
                  ),
                  ResponsiveGridCol(
                    lg: 1,
                    child: BaleiaExtras.widgetEntrega(ped.status, 14, ped.id),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
