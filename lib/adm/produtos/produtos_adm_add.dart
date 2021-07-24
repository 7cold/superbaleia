import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/widgets/baleiaAdmWidgets.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/forms.dart';
import 'package:superbaleia/widgets/texts.dart';

class ProdutosAdmAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController titulo = TextEditingController();
    TextEditingController marca = TextEditingController();
    TextEditingController desc = TextEditingController();
    TextEditingController preco = TextEditingController();
    TextEditingController precodesc = TextEditingController();
    TextEditingController img = TextEditingController();
    TextEditingController imgFit = TextEditingController();
    Rx<String> categoria = "".obs;
    Rx<String> unidadeMed = "".obs;
    RxList espec = [].obs;

    Rx<bool> imgContain = true.obs;
    Rx<bool> desconto = false.obs;
    Rx<bool> ativo = true.obs;

    final ControllerAdm c = Get.find();

    limparCampos() {
      titulo.text = "";
      marca.text = "";
      desc.text = "";
      preco.text = "";
      precodesc.text = "";
      img.text = "";
      imgFit.text = "";
      categoria.value = "";
      unidadeMed.value = "";
      ativo = true.obs;
      espec = [].obs;
      c.url = "".obs;
    }

    return Scaffold(
      appBar: BaleiaAdm.appBar("Adicionar Novo Produto", null),
      body: Obx(
        () => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                ResponsiveGridRow(children: [
                  ResponsiveGridCol(
                    lg: 6,
                    child: Padding(
                      padding: EdgeInsets.only(top: 0, left: 20, bottom: 20),
                      child: ResponsiveGridRow(
                        children: [
                          //PRIMEIRA COLUNA
                          ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 0, left: 20, bottom: 20),
                              child: Text(
                                "Dados",
                                style: textBold(20, corBackDark),
                              ),
                            ),
                          ),
                          ResponsiveGridCol(
                            lg: 12,
                            child:
                                BaleiaForms.textFormField("Titulo", titulo, []),
                          ),
                          ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: BaleiaForms.textFormField(
                                "Marca",
                                marca,
                                [],
                              ),
                            ),
                          ),
                          ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: BaleiaForms.textFormFieldText(
                                  "Descrição", desc, []),
                            ),
                          ),
                          ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 20, left: 20, bottom: 20),
                              child: Text(
                                "Imagem",
                                style: textBold(20, corBackDark),
                              ),
                            ),
                          ),
                          ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: c.url.value == ""
                                  ? SizedBox()
                                  : Container(
                                      height: 200,
                                      child: c.url.value == ""
                                          ? SizedBox()
                                          : Image.network(c.url.value)),
                            ),
                          ),
                          ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: c.url.value == ""
                                  ? SizedBox()
                                  : Row(
                                      children: [
                                        CupertinoSwitch(
                                            value: imgContain.value,
                                            onChanged: (_) {
                                              imgContain.value = _;
                                            }),
                                        SizedBox(width: 15),
                                        Text(
                                          imgContain.value == true
                                              ? "Contain"
                                              : "Full",
                                          style: textRegular(18, corBackDark),
                                        )
                                      ],
                                    ),
                            ),
                          ),
                          ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 20, right: 20, left: 20),
                              child: Container(
                                child: LinearProgressIndicator(
                                  color: c.urlPorcentagem.value == 1
                                      ? CupertinoColors.activeGreen
                                      : Colors.blue,
                                  value: c.urlPorcentagem.value,
                                ),
                              ),
                            ),
                          ),
                          ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: BaleiaButtons.buttonPrimary(
                                  "Selecionar", Get.context.width, 50, () {
                                c.getImage();
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    lg: 6,
                    child: ResponsiveGridRow(
                      children: [
                        //SEGUNDA COLUNA
                        ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Preços",
                                style: textBold(20, corBackDark),
                              ),
                            )),
                        ResponsiveGridCol(
                          lg: 4,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: BaleiaForms.textFormField("Preço", preco, [
                              FilteringTextInputFormatter.digitsOnly,
                              RealInputFormatter(centavos: true, moeda: true),
                            ]),
                          ),
                        ),

                        ResponsiveGridCol(
                          lg: 3,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                CupertinoSwitch(
                                    value: desconto.value,
                                    onChanged: (_) {
                                      desconto.value = _;
                                    }),
                                Text(
                                  "Desconto",
                                  style: textRegular(14, corBackDark),
                                )
                              ],
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 4,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: desconto.value == true
                                ? BaleiaForms.textFormField(
                                    "Preço Desconto", precodesc, [
                                    FilteringTextInputFormatter.digitsOnly,
                                    RealInputFormatter(
                                        centavos: true, moeda: true),
                                  ])
                                : SizedBox(),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 12,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              "Categoria",
                              style: textBold(20, corBackDark),
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 6,
                          child: Container(
                            width: Get.context.width,
                            child: Container(
                              padding: EdgeInsets.only(right: 20, left: 20),
                              margin:
                                  EdgeInsets.only(right: 20, left: 20, top: 20),
                              width: Get.context.width,
                              decoration: BoxDecoration(
                                color: CupertinoColors
                                    .tertiarySystemGroupedBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButton(
                                style: textRegular(18, corBackDark),
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
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 12,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              "Tipo de venda",
                              style: textBold(20, corBackDark),
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 6,
                          child: Container(
                            width: Get.context.width,
                            child: Container(
                              padding: EdgeInsets.only(right: 20, left: 20),
                              margin:
                                  EdgeInsets.only(right: 20, left: 20, top: 20),
                              width: Get.context.width,
                              decoration: BoxDecoration(
                                color: CupertinoColors
                                    .tertiarySystemGroupedBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButton(
                                style: textRegular(18, corBackDark),
                                underline: SizedBox(),
                                isExpanded: true,
                                icon: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Color(corBackDark),
                                ),
                                hint: Text(unidadeMed.value),
                                items: [
                                  'unitario',
                                  'por peso',
                                  'por capacidade',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (_) {
                                  unidadeMed.value = _;
                                },
                              ),
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 12,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Especificações",
                                  style: textBold(20, corBackDark),
                                ),
                                IconButton(
                                  color: CupertinoColors.activeGreen,
                                  onPressed: () {
                                    espec.add({
                                      "espec": "",
                                      "valor": "",
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 12,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Column(
                              children: espec.map((res) {
                                return ResponsiveGridRow(
                                  children: [
                                    ResponsiveGridCol(
                                      xl: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CupertinoTextField(
                                          placeholder: "Especificação",
                                          onChanged: (_) {
                                            res['espec'] = _.capitalize;
                                          },
                                        ),
                                      ),
                                    ),
                                    ResponsiveGridCol(
                                      xl: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CupertinoTextField(
                                          placeholder: "Valor",
                                          onChanged: (_) {
                                            res['valor'] = _.capitalize;
                                          },
                                        ),
                                      ),
                                    ),
                                    ResponsiveGridCol(
                                        xl: 2,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: IconButton(
                                              onPressed: () {
                                                espec.remove(res);
                                              },
                                              icon: Icon(Icons
                                                  .remove_circle_outline_sharp)),
                                        )),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        ResponsiveGridCol(
                          lg: 12,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 30, left: 20, bottom: 10),
                            child: Text(
                              "Status do Produto",
                              style: textBold(20, corBackDark),
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 12,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                CupertinoSwitch(
                                    value: ativo.value,
                                    onChanged: (_) {
                                      ativo.value = _;
                                    }),
                                SizedBox(width: 15),
                                Text(
                                  ativo.value == true ? "Ativo" : "Desativado",
                                  style: textRegular(18, corBackDark),
                                )
                              ],
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 6,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 40, right: 20, left: 20),
                            child: CupertinoButton(
                              color: CupertinoColors.activeGreen,
                              child: Text("Salvar"),
                              onPressed: () {
                                if (titulo.text == "" ||
                                    desc.text == "" ||
                                    c.url.value == "" ||
                                    preco.text == "" ||
                                    marca.text == "" ||
                                    unidadeMed.value == "" ||
                                    categoria.value == "") {
                                  Get.snackbar("Faltam dados 😕",
                                      "Verifique seus dados e tente novamente!",
                                      backgroundColor:
                                          CupertinoColors.systemRed,
                                      borderRadius: 10,
                                      margin: EdgeInsets.all(20),
                                      colorText: Colors.white);
                                } else {
                                  Get.snackbar("Cadastrado com Sucesso",
                                      "Limpando campos!",
                                      backgroundColor:
                                          CupertinoColors.activeGreen,
                                      borderRadius: 10,
                                      margin: EdgeInsets.all(20),
                                      colorText: Colors.white);

                                  c.salvarProduto(categoria.value, {
                                    "titulo": titulo.text.capitalize,
                                    "desc": desc.text.capitalizeFirst,
                                    "img": c.url.value,
                                    "categoria": categoria.value,
                                    "preco": double.parse(preco.text
                                        .replaceAll("R\$ ", "")
                                        .replaceAll(",", ".")),
                                    "precoDesc": desconto.value == true
                                        ? double.parse(precodesc.text
                                            .replaceAll("R\$ ", "")
                                            .replaceAll(",", "."))
                                        : double.parse(preco.text
                                            .replaceAll("R\$ ", "")
                                            .replaceAll(",", ".")),
                                    "ativo": true,
                                    "espec": espec,
                                    "marca": marca.text.capitalize,
                                    "unidadeMed": unidadeMed.value,
                                    "imgFit": imgContain.value == true
                                        ? "contain"
                                        : "full",
                                  });
                                  limparCampos();
                                }
                              },
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          lg: 6,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 40, left: 20, right: 20),
                            child: CupertinoButton(
                              color: CupertinoColors.systemGrey,
                              child: Text("Limpar Campos"),
                              onPressed: () {
                                limparCampos();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
