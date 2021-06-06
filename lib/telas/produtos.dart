import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/controller/controller_prod.dart';
import 'package:superbaleia/data/categorias_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/card.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

final Controller c = Get.find();

class ProdutosUi extends StatelessWidget {
  final ControllerProd cP = Get.put(ControllerProd());
  final CategoriasData categoriasData;

  ProdutosUi({@required this.categoriasData});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: BaleiaExtras.appBar(categoriasData.catNome),
        backgroundColor: Color(corBack),
        body: c.carregando.value == true
            ? Center(child: BaleiaExtras.widgetLoading)
            : cP.produtos.length < 1
                ? Center(child: BaleiaExtras.nenhumProd())
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ResponsiveGridRow(
                        children: cP.produtos.map((element) {
                          ProdutoData produtoData =
                              ProdutoData.fromJson(element);
                          return ResponsiveGridCol(
                              sm: 4,
                              md: 3,
                              xs: 6,
                              child: BaleiaCards.cardProd(produtoData));
                        }).toList(),
                      ),
                    ),
                  ),
      ),
    );
  }
}
