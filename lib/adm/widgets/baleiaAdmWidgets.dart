import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/pedidos/pedidos_detalhes_adm.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,##0.00", "pt_BR");
final ControllerAdm c = Get.find();

class BalAdm {
  static Widget produtosItens(ProdutoData prod) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          hoverColor: Color(corPri).withAlpha(50),
          highlightColor: Color(corBack).withAlpha(10),
          splashColor: Colors.transparent,
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            width: Get.context.width,
            child: ResponsiveGridRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveGridCol(
                  lg: 1,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(prod.img),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 3,
                  child: Text(
                    prod.titulo,
                    style: textRegular(16, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 3,
                  child: Text(
                    prod.marca,
                    style: textLight(16, corGrey),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 1,
                  child: Text(
                    prod.ativo == true ? "Ativo" : "Desabilitado",
                    style:
                        textRegular(16, prod.ativo == true ? corGreen : corRed),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 1,
                  child: Text(
                    "R\$ " + formatter.format(prod.preco),
                    style: textRegular(16, corGreen),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 1,
                  child: prod.precoDesc != prod.preco
                      ? Text(
                          "R\$ " + formatter.format(prod.precoDesc),
                          style: textRegular(16, corOrange),
                        )
                      : Text(
                          "-",
                          style: textRegular(16, corOrange),
                        ),
                ),
                ResponsiveGridCol(
                  lg: 1,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          print(prod);
                          Get.defaultDialog(
                              title: "Deseja Remover",
                              middleText: "",
                              confirm: CupertinoButton(
                                  color: CupertinoColors.systemRed,
                                  child: Text("Sim"),
                                  onPressed: () {
                                    c.deleteProduto(prod);
                                    c.produtos.remove(prod);
                                    Get.back();
                                  }),
                              cancel: CupertinoButton(
                                child: Text(
                                  "Não",
                                  style: TextStyle(
                                      color: CupertinoColors.systemGrey),
                                ),
                                onPressed: () => Get.back(),
                              ));
                        },
                        icon: Icon(Icons.delete_outline_rounded,
                            color: Color(corGrey)),
                      ),
                      IconButton(
                        onPressed: () {
                          print(prod);
                          Get.defaultDialog(
                            title: "Resumo",
                            titleStyle: textBold(16, corBackDark),
                            content: Container(child: prodDetalhes(prod)),
                            middleText: "",
                          );
                        },
                        icon: Icon(Icons.remove_red_eye_outlined,
                            color: Color(corGrey)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget produtosItensDetalhes(ProdutoData prod) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          hoverColor: Color(corPri).withAlpha(50),
          highlightColor: Color(corBack).withAlpha(10),
          splashColor: Colors.transparent,
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            width: Get.context.width,
            child: ResponsiveGridRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveGridCol(
                  lg: 1,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(prod.img),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 5,
                  child: Text(
                    prod.titulo,
                    style: textRegular(16, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 4,
                  child: Text(
                    prod.marca,
                    style: textLight(16, corGrey),
                  ),
                ),
                ResponsiveGridCol(
                    lg: 2,
                    child: Text(
                      "R\$ " +
                          formatter.format(prod.precoDesc != prod.preco
                              ? prod.precoDesc
                              : prod.preco),
                      style: textRegular(16, corBackDark),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget prodDetalhes(ProdutoData prod) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Título", style: textLight(14, corGrey)),
          Text(prod.titulo, style: textBold(16, corBackDark)),
          SizedBox(height: 10),
          Text("Marca", style: textLight(14, corGrey)),
          Text(prod.marca, style: textBold(16, corBackDark)),
          SizedBox(height: 10),
          Text("Unidade de Medida", style: textLight(14, corGrey)),
          Text(
              prod.unidadeMed == "unitario"
                  ? "Unitário"
                  : prod.unidadeMed == "por massa"
                      ? "Por peso"
                      : "Por capacidade",
              style: textBold(16, corBackDark)),
          SizedBox(height: 10),
          Text("Especificação", style: textLight(14, corGrey)),
          Column(
            children: prod.espec.map((e) {
              ProdEscpec espec = ProdEscpec.fromList(e);
              return Row(
                children: [
                  Text(espec.espec.toString() + ": ",
                      style: textSemiBold(16, corBackDark)),
                  Text(espec.valor.toString(),
                      style: textRegular(16, corBackDark)),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Text("Ativo", style: textLight(14, corGrey)),
          Text(prod.ativo == true ? "Sim" : "Não",
              style: textBold(16, corBackDark)),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  static Widget appBar(String title, List<Widget> actions) => AppBar(
        elevation: 5,
        shadowColor: Colors.white.withOpacity(0.2),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: actions,
        title: Text(
          title.toString(),
          style: textSemiBold(20, corBackDark),
        ),
        iconTheme: IconThemeData(
          color: Color(corBackDark),
        ),
      );

  static Widget vendasItens(PedidoData ped) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          hoverColor: Color(corPri).withAlpha(50),
          highlightColor: Color(corBack).withAlpha(10),
          splashColor: Colors.transparent,
          onTap: () {
            Get.to(() => PedidosDetalhesAdm(
                  ped: ped,
                ));
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            width: Get.context.width,
            child: ResponsiveGridRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveGridCol(
                  lg: 1,
                  child: Text(
                    "#" + ped.id.substring(0, 6),
                    style: textRegular(14, corGrey),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 2,
                  child: Tooltip(
                    padding: EdgeInsets.all(8),
                    message: ped.cliente['endereco'] +
                        " - " +
                        ped.cliente['num'] +
                        "\n" +
                        ped.cliente['bairro'] +
                        " - " +
                        ped.cliente['cidade'],
                    child: Text(
                      ped.cliente['nome'],
                      style: textRegular(14, corBackDark),
                    ),
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
                        size: 18,
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
                    ped.produtos.length.toString() + " Itens",
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
                  lg: 1,
                  child: Text(
                    "R\$ " + formatter.format(ped.totalPedido),
                    style: textRegular(14, corPri),
                  ),
                ),
                ResponsiveGridCol(
                    lg: 1,
                    child: ped.status == 1
                        ? BaleiaExtras.statusPreparandoAdm()
                        : ped.status == 2
                            ? BaleiaExtras.statusEnviandoAdm()
                            : BaleiaExtras.statusEntregueAdm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
