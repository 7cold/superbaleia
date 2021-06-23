import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/texts.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,##0.00", "pt_BR");

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
            width: Get.width,
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
                    prod.medida['massa'] == ""
                        ? prod.medida['capac'].toString() +
                            " " +
                            prod.medida['capacUnidMed']
                        : prod.medida['massa'].toString() +
                            " " +
                            prod.medida['massaUnidMed'],
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
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete_outline_rounded))),
              ],
            ),
          ),
        ),
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
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            width: Get.width,
            child: ResponsiveGridRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveGridCol(
                  lg: 1,
                  child: Text(
                    "#" + ped.id.substring(1, 6),
                    style: textRegular(14, corGrey),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 2,
                  child: Tooltip(
                    message: "$ped.endereco",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
