import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/produtos/produtos_adm_add.dart';
import 'package:superbaleia/adm/widgets/baleiaAdmWidgets.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';

class ProdutosAdm extends StatelessWidget {
  final RxString categoria = "".obs;
  final RxString prodSearch = "".obs;
  final RxString tipoSearch = "".obs;

  @override
  Widget build(BuildContext context) {
    final ControllerAdm c = Get.find();
    return Obx(
      () => Scaffold(
        backgroundColor: Color(corBack),
        appBar: BaleiaAdm.appBar("Produtos", [
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
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: ResponsiveGridRow(
                        children: [
                          ResponsiveGridCol(
                              lg: 12,
                              child: Text("Filtros",
                                  style: textSemiBold(18, corBackDark))),
                          ResponsiveGridCol(
                            lg: 3,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10, top: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Cidade", style: textLight(16, corGrey)),
                                  SizedBox(height: 6),
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 20, left: 20),
                                    width: Get.context.width,
                                    decoration: BoxDecoration(
                                      color: CupertinoColors
                                          .tertiarySystemGroupedBackground,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownButton(
                                      style: textRegular(16, corBackDark),
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: Color(corBackDark),
                                      ),
                                      hint: Text(categoria.value),
                                      items: [
                                        'bebidas',
                                        'bebidas alcoolicas',
                                        'carnes e peixaria',
                                        'congelados',
                                        'higiene',
                                        'hortifruti',
                                        'infantil',
                                        'laticinios',
                                        'limpeza',
                                        'mercearia',
                                        'padaria',
                                        'pet',
                                        'utilidades',
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (_) {
                                        categoria.value = _;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ResponsiveGridCol(
                            lg: 9,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pesquisa",
                                      style: textLight(16, corGrey)),
                                  SizedBox(height: 6),
                                  SizedBox(
                                    height: 45,
                                    child: CupertinoTextField(
                                      suffix: Row(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            child: CupertinoButton(
                                                padding: EdgeInsets.all(0),
                                                disabledColor:
                                                    CupertinoColors.activeGreen,
                                                color:
                                                    CupertinoColors.systemGrey2,
                                                child: Text(
                                                  "Nome",
                                                  style:
                                                      textRegular(12, corBack),
                                                ),
                                                onPressed:
                                                    tipoSearch.value == "nome"
                                                        ? null
                                                        : () {
                                                            tipoSearch.value =
                                                                "nome";
                                                          }),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            height: 30,
                                            child: CupertinoButton(
                                                padding: EdgeInsets.all(0),
                                                disabledColor:
                                                    CupertinoColors.activeGreen,
                                                color:
                                                    CupertinoColors.systemGrey2,
                                                child: Text(
                                                  "#ID",
                                                  style:
                                                      textRegular(12, corBack),
                                                ),
                                                onPressed: tipoSearch.value ==
                                                        "id"
                                                    ? null
                                                    : () {
                                                        tipoSearch.value = "id";
                                                      }),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            height: 30,
                                            child: CupertinoButton(
                                                padding: EdgeInsets.all(0),
                                                disabledColor:
                                                    CupertinoColors.activeGreen,
                                                color:
                                                    CupertinoColors.systemGrey2,
                                                child: Text(
                                                  "Marca",
                                                  style:
                                                      textRegular(12, corBack),
                                                ),
                                                onPressed:
                                                    tipoSearch.value == "marca"
                                                        ? null
                                                        : () {
                                                            tipoSearch.value =
                                                                "marca";
                                                          }),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                      placeholder: "Pesquisar",
                                      onChanged: (_) {
                                        prodSearch.value = _;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: c.produtos.where((i) {
                        ProdutoData prod = i;
                        return prodSearch.value == ""
                            ? categoria.value == "Todas"
                                ? prod.categoria != ""
                                : prod.categoria == categoria.value
                            : tipoSearch.value == "marca"
                                ? prod.marca.isCaseInsensitiveContainsAny(
                                    prodSearch.value)
                                : tipoSearch.value == "nome"
                                    ? prod.titulo.isCaseInsensitiveContainsAny(
                                        prodSearch.value)
                                    : tipoSearch.value == "id"
                                        ? prod.id.isCaseInsensitiveContainsAny(
                                            prodSearch.value)
                                        : null;
                      }).map((val) {
                        ProdutoData prod = val;
                        return BaleiaAdm.produtosItens(prod);
                      }).toList(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
