import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
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
      appBar: BaleiaExtras.appBar(
        "#" + ped.id.substring(0, 6),
      ),
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
                        Row(children: [
                          Text("Cliente ID: ", style: textLight(16, corGrey)),
                          Text(ped.clienteId.toString(),
                              style: textRegular(16, corBackDark)),
                        ]),
                        Row(children: [
                          Text("CPF: ", style: textLight(16, corGrey)),
                          Text(cliente.cpf,
                              style: textRegular(16, corBackDark)),
                        ]),
                        Row(children: [
                          Text("Celular: ", style: textLight(16, corGrey)),
                          Text(cliente.celular,
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
                        Row(children: [
                          Text("Bairro: ", style: textLight(16, corGrey)),
                          Text(cliente.bairro,
                              style: textRegular(16, corBackDark)),
                        ]),
                        Row(children: [
                          Text("Cidade: ", style: textLight(16, corGrey)),
                          Text(cliente.cidade,
                              style: textRegular(16, corBackDark)),
                        ]),
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
                          Text(ped.id.toString(),
                              style: textRegular(16, corBackDark)),
                        ]),
                        Row(children: [
                          Text("Data: ", style: textLight(16, corGrey)),
                          Text(
                              DateFormat('dd/MM/yy - HH:mm - EEEE', "pt_BR")
                                  .format(DateTime.fromMicrosecondsSinceEpoch(
                                      ped.data.microsecondsSinceEpoch)),
                              style: textRegular(16, corBackDark)),
                        ]),
                        Row(children: [
                          Text("Forma de Pagamento: ",
                              style: textLight(16, corGrey)),
                          Text(
                            ped.formaPag,
                            style: textRegular(14, corBackDark),
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
                        Row(children: [
                          Text("Status: ", style: textLight(16, corGrey)),
                          ped.status == 1
                              ? BaleiaExtras.statusPreparandoAdm()
                              : ped.status == 2
                                  ? BaleiaExtras.statusEnviandoAdm()
                                  : BaleiaExtras.statusEntregueAdm(),
                        ]),
                        Row(children: [
                          Text("Valor dos produtos: ",
                              style: textLight(16, corGrey)),
                          Text("R\$ " + formatter.format(ped.totalProdutos),
                              style: textRegular(16, corBackDark)),
                        ]),
                        Row(children: [
                          Text("Total do Pedido: ",
                              style: textLight(16, corGrey)),
                          Text("R\$ " + formatter.format(ped.totalPedido),
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
                          "Produtos",
                          style: textBold(22, corBackDark),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: ped.produtos.map((val) {
                            CarrinhoData ped = CarrinhoData.fromMap(val);
                            ProdutoData prod = ped.produtoData;

                            return BalAdm.produtosItensDetalhes(prod);
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
