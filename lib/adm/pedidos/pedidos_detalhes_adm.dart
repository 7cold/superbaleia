import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/adm/pedidos/pedidos_adm_impressao.dart';
import 'package:superbaleia/adm/widgets/baleiaAdmWidgets.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:intl/intl.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';

class PedidosDetalhesAdm extends StatelessWidget {
  final PedidoData ped;
  const PedidosDetalhesAdm({@required this.ped});

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    ClienteData cliente = ClienteData.fromJson(ped.cliente);

    return Scaffold(
      backgroundColor: Color(corBack),
      appBar: BaleiaAdm.appBar("#" + ped.id.substring(0, 6), [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: IconButton(
            tooltip: "Impressão de Pedido",
            onPressed: () => Get.to(() => PedidoAdmImpressao(
                  ped: ped,
                )),
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
                          "Dados do cliente",
                          style: textBold(22, corBackDark),
                        ),
                        SizedBox(height: 20),
                        Row(children: [
                          Text("Cliente: ", style: textLight(16, corGrey)),
                          Text(cliente.nome,
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Cliente ID: ", style: textLight(16, corGrey)),
                          Text(ped.clienteId.toString(),
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
                          Text("Celular: ", style: textLight(16, corGrey)),
                          Text(cliente.celular,
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 25),
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
                          Text("Tipo de entrega: ",
                              style: textLight(16, corGrey)),
                          Text(
                              ped.entrega['entregaTipo'] ==
                                      "Entregar a qualquer momento"
                                  ? "Entregar a qualquer momento"
                                  : ped.entrega['entregaTipo'] ==
                                          "Retirada no mercado"
                                      ? "Retirada no mercado"
                                      : "Entrega Agendada",
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Preço da Entrega: ",
                              style: textLight(16, corGrey)),
                          Text(
                              ped.entrega['entregaTipo'] ==
                                      "Entregar a qualquer momento"
                                  ? "R\$ 0,00"
                                  : ped.entrega['entregaTipo'] == "R\$ 0,00"
                                      ? "Retirada no mercado"
                                      : "R\$ " +
                                          formatter.format(
                                              ped.entrega['entregaPreco']),
                              style: textRegular(16, corBackDark)),
                        ]),
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
                          "Detalhes do pedido",
                          style: textBold(22, corBackDark),
                        ),
                        SizedBox(height: 20),
                        Row(children: [
                          Text("Pedido ID: ", style: textLight(16, corGrey)),
                          SizedBox(height: 6),
                          Text(ped.id.toString(),
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Data: ", style: textLight(16, corGrey)),
                          Text(
                              DateFormat('dd/MM/yy - HH:mm - EEEE', "pt_BR")
                                  .format(DateTime.fromMicrosecondsSinceEpoch(
                                      ped.data.microsecondsSinceEpoch)),
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Forma de Pagamento: ",
                              style: textLight(16, corGrey)),
                          Text(
                            ped.formaPag,
                            style: textRegular(16, corBackDark),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            ped.formaPag == "Cartão"
                                ? Icons.credit_card_rounded
                                : ped.formaPag == "Pix"
                                    ? Icons.transform_rounded
                                    : Icons.monetization_on_outlined,
                            size: 18,
                            color: ped.formaPag == "Cartão"
                                ? CupertinoColors.activeOrange
                                : ped.formaPag == "Pix"
                                    ? Colors.blue
                                    : Colors.green[600],
                          ),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Status: ", style: textLight(16, corGrey)),
                          BaleiaExtras.widgetEntrega(ped.status, 14)
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text("Valor dos produtos: ",
                              style: textLight(16, corGrey)),
                          Text("R\$ " + formatter.format(ped.totalProdutos),
                              style: textRegular(16, corBackDark)),
                        ]),
                        SizedBox(height: 25),
                        Row(children: [
                          Text("Total do Pedido: ",
                              style: textBold(16, corBackDark)),
                          Text("R\$ " + formatter.format(ped.totalPedido),
                              style: textBold(16, corBackDark)),
                        ]),
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
                        Row(
                          children: [
                            Text(
                              "Produtos",
                              style: textBold(22, corBackDark),
                            ),
                            SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: CupertinoColors.activeBlue,
                              ),
                              child: Text(
                                ped.produtos.length.toString(),
                                style: textBold(14, corBack),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: ped.produtos.map((val) {
                            CarrinhoData ped = CarrinhoData.fromMap(val);
                            ProdutoData prod = ped.produtoData;

                            return BaleiaAdm.pedidoProdDetalhes(prod, ped);
                          }).toList(),
                        ),
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
