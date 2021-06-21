import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/texts.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,##0.00", "pt_BR");

class BalAdm {
  static Widget produtosItens(ProdutoData prod) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.white.withAlpha(100),
        color: Colors.white,
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
          width: Get.width,
          child: ResponsiveGridRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ResponsiveGridCol(
                lg: 1,
                child: Container(
                  height: 50,
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
                lg: 4,
                child: Text(
                  prod.titulo,
                  style: textRegular(18, corBackDark),
                ),
              ),
              ResponsiveGridCol(
                lg: 4,
                child: Text(
                  prod.marca,
                  style: textRegular(18, corBackDark),
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
                  style: textRegular(18, corBackDark),
                ),
              ),
              ResponsiveGridCol(
                lg: 1,
                child: Text(
                  prod.ativo == true ? "Ativo" : "Desabilitado",
                  style:
                      textRegular(18, prod.ativo == true ? corGreen : corRed),
                ),
              ),
              ResponsiveGridCol(
                lg: 1,
                child: Text(
                  "R\$ " + formatter.format(prod.preco),
                  style: textRegular(18, corGreen),
                ),
              ),
            ],
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
}
