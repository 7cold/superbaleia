import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/controller/controller_prod.dart';
import 'package:superbaleia/data/categorias_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/card.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

final Controller c = Get.put(Controller());

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
        body: Center(
          child: c.carregando.value == true
              ? BaleiaExtras.widgetLoading
              : cP.produtos.length < 1
                  ? BaleiaExtras.nenhumProd()
                  : GridView.count(
                      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                      crossAxisCount: Get.width < 330
                          ? 1
                          : Get.width > 485
                              ? 3
                              : 2,
                      childAspectRatio: Get.width < 330 ? 1.2 : 0.8,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      children: cP.produtos.map((element) {
                        ProdutoData produtoData = ProdutoData.fromJson(element);
                        return BaleiaCards.cardProd(produtoData);
                      }).toList(),
                    ),
        ),
      ),
    );
  }
}
