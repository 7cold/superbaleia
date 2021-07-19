import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/adm/clientes/clientes_adm.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/produtos/produtos_adm.dart';
import 'package:superbaleia/adm/pedidos/pedidos_adm.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,##0.00", "pt_BR");

class HomeAdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ControllerAdm c = Get.put(ControllerAdm());
    return Obx(
      () => c.carregando.value == true || c.clienteDataAdm['nome'] == null
          ? BaleiaExtras.widgetLoading
          : Scaffold(
              appBar: BaleiaExtras.appBar(c.clienteDataAdm['nome']),
              drawer: BaleiaExtras.drawerAdm(c, [
                BaleiaExtras.itemDrawer(
                    Icons.store_outlined, "Produtos", ProdutosAdm()),
                BaleiaExtras.itemDrawer(
                    Icons.people_outline, "Clientes", ClientesAdm()),
                BaleiaExtras.itemDrawer(
                    Icons.attach_money_outlined, "Vendas", VendasAdm()),
                BaleiaExtras.itemDrawer(
                    Icons.settings, "Configurações", ProdutosAdm()),
              ]),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ResponsiveGridRow(
                  children: [
                    ResponsiveGridCol(
                      lg: 4,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () => Get.to(() => ClientesAdm()),
                          child: Container(
                            height: 190,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(corPri),
                                    Color(corPri).withAlpha(150),
                                  ]),
                            ),
                            child: Center(
                              child: Text(
                                "Total de Clientes: " +
                                    c.clientes.length.toString(),
                                style: textBold(20, corBack),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ResponsiveGridCol(
                      lg: 4,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () => Get.to(() => ProdutosAdm()),
                          child: Container(
                            height: 190,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(corPri),
                                    Color(corPri).withAlpha(150),
                                  ]),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Total de Produtos: " +
                                    c.produtos.length.toString(),
                                style: textBold(20, corBack),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ResponsiveGridCol(
                      lg: 4,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () => Get.to(() => VendasAdm()),
                          child: Container(
                            height: 190,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(corPri),
                                    Color(corPri).withAlpha(150),
                                  ]),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Total de Vendas: " +
                                    c.vendas.length.toString(),
                                style: textBold(20, corBack),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ResponsiveGridCol(
                      lg: 4,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () => Get.to(() => VendasAdm()),
                          child: Container(
                            height: 190,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(corGreen),
                                    Color(corGreen).withAlpha(120),
                                  ]),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Total em Vendas (R\$): " +
                                    formatter.format(c.getVendasTotal()),
                                style: textBold(20, corBack),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
