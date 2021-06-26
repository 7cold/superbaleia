import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/produtos/produtos_adm_add.dart';
import 'package:superbaleia/adm/widgets/baleiaAdmWidgets.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class ProdutosAdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ControllerAdm c = Get.find();
    return Obx(
      () => Scaffold(
        backgroundColor: Color(corBack),
        appBar: BalAdm.appBar("Produtos", [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Get.to(() => ProdutosAdmAdd());
              },
              icon: Icon(Icons.add),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                c.carregarTodos();
              },
              icon: Icon(Icons.cloud_download_outlined),
            ),
          ),
        ]),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: c.carregando.value == true
              ? BaleiaExtras.widgetLoading
              : Column(
                  children: c.produtos.map((val) {
                    ProdutoData prod = val;
                    return BalAdm.produtosItens(prod);
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
