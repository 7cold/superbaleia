import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/adm/controller_adm.dart';
import 'package:superbaleia/adm/produtos_adm_add.dart';
import 'package:superbaleia/adm/widgets/balAdm.dart';
import 'package:superbaleia/data/produto_data.dart';

class ProdutosAdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ControllerAdm c = Get.find();
    return Obx(
      () => Scaffold(
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
          child: Column(
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
