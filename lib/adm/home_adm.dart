import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/produtos/produtos_adm.dart';
import 'package:superbaleia/adm/pedidos/pedidos_adm.dart';
import 'package:superbaleia/widgets/extras.dart';

class HomeAdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ControllerAdm c = Get.put(ControllerAdm());
    return Scaffold(
      appBar: BaleiaExtras.appBar("Home"),
      drawer: BaleiaExtras.drawerAdm(c, [
        BaleiaExtras.itemDrawer(
            Icons.maps_home_work_outlined, "Produtos", ProdutosAdm()),
        BaleiaExtras.itemDrawer(
            Icons.people_outline, "Clientes", ProdutosAdm()),
        BaleiaExtras.itemDrawer(
            Icons.attach_money_rounded, "Vendas", VendasAdm()),
        BaleiaExtras.itemDrawer(
            Icons.engineering_outlined, "Configurações", ProdutosAdm()),
      ]),
    );
  }
}
