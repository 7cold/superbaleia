import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/adm/controller_adm.dart';
import 'package:superbaleia/adm/widgets/balAdm.dart';
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
    TextEditingController capac = TextEditingController();
    Rx<String> capacUnidMed = "".obs;
    TextEditingController massa = TextEditingController();
    Rx<String> massaUnidMed = "".obs;
    Rx<bool> massaBool = false.obs;
    Rx<bool> capacBool = false.obs;
    Rx<bool> imgContain = true.obs;
    Rx<bool> ativo = true.obs;

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
      capac.text = "";
      capacUnidMed.value = "";
      massa.text = "";
      massaUnidMed.value = "";
      massaBool = false.obs;
      capacBool = false.obs;
      ativo = true.obs;
    }

    final ControllerAdm c = Get.find();

    return Scaffold(
      appBar: BalAdm.appBar("Adicionar Novo Produto", null),
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
                                padding: EdgeInsets.only(
                                    top: 0, left: 20, bottom: 20),
                                child: Text(
                                  "Dados",
                                  style: textBold(20, corBackDark),
                                ),
                              )),
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
                                    "Marca", marca, [])),
                          ),
                          ResponsiveGridCol(
                              lg: 12,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: BaleiaForms.textFormFieldText(
                                    "Descrição", desc, []),
                              )),
                          ResponsiveGridCol(
                              lg: 12,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 20, bottom: 20),
                                child: Text(
                                  "Imagem",
                                  style: textBold(20, corBackDark),
                                ),
                              )),
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
                              )),
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
                              )),
                          ResponsiveGridCol(
                              lg: 12,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 20, right: 20, left: 20),
                                child: Container(
                                  child: LinearProgressIndicator(
                                    color: c.urlPorcentagem.value == 1
                                        ? CupertinoColors.activeGreen
                                        : Colors.blue,
                                    value: c.urlPorcentagem.value,
                                  ),
                                ),
                              )),
                          ResponsiveGridCol(
                              lg: 12,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: BaleiaButtons.buttonPrimary(
                                    "Selecionar", Get.width, 50, () {
                                  c.getImage();
                                }),
                              )),
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
                            lg: 6,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: BaleiaForms.textFormField("Preço", preco, [
                                FilteringTextInputFormatter.digitsOnly,
                                RealInputFormatter(centavos: true, moeda: true),
                              ]),
                            )),
                        ResponsiveGridCol(
                            lg: 6,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: BaleiaForms.textFormField(
                                  "Preço Desconto", precodesc, [
                                FilteringTextInputFormatter.digitsOnly,
                                RealInputFormatter(centavos: true, moeda: true),
                              ]),
                            )),
                        ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20, left: 20),
                              child: Text(
                                "Categoria",
                                style: textBold(20, corBackDark),
                              ),
                            )),
                        ResponsiveGridCol(
                          lg: 6,
                          child: Container(
                            width: Get.width,
                            child: Container(
                              padding: EdgeInsets.only(right: 20, left: 20),
                              margin:
                                  EdgeInsets.only(right: 20, left: 20, top: 20),
                              width: Get.width,
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
                            )),
                        ResponsiveGridCol(
                          lg: 6,
                          child: Container(
                            width: Get.width,
                            child: Container(
                              padding: EdgeInsets.only(right: 20, left: 20),
                              margin:
                                  EdgeInsets.only(right: 20, left: 20, top: 20),
                              width: Get.width,
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
                                  'por massa',
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
                                    "Medidas",
                                    style: textBold(20, corBackDark),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Capacidade",
                                        style: textBold(16, corBackDark),
                                      ),
                                      CupertinoSwitch(
                                          value: capacBool.value,
                                          onChanged: (_) {
                                            capacBool.value = _;
                                          }),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Massa",
                                        style: textBold(16, corBackDark),
                                      ),
                                      CupertinoSwitch(
                                          value: massaBool.value,
                                          onChanged: (_) {
                                            massaBool.value = _;
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            )),

                        ResponsiveGridCol(
                            lg: 5,
                            child: capacBool.value == false
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: BaleiaForms.textFormField(
                                        "Capacidade", capac, [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ]),
                                  )),
                        ResponsiveGridCol(
                            lg: 6,
                            child: capacBool.value == false
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(right: 20, left: 20),
                                      margin:
                                          EdgeInsets.only(right: 20, left: 20),
                                      width: Get.width,
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
                                        hint: Text(capacUnidMed.value),
                                        items: [
                                          '',
                                          'ml',
                                          'L',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        onChanged: (_) async {
                                          capacUnidMed.value = _;
                                        },
                                      ),
                                    ),
                                  )),

                        ResponsiveGridCol(
                            lg: 5,
                            child: massaBool.value == false
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: BaleiaForms.textFormField(
                                        "Massa", massa, [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ]),
                                  )),
                        ResponsiveGridCol(
                            lg: 6,
                            child: massaBool.value == false
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(right: 20, left: 20),
                                      margin:
                                          EdgeInsets.only(right: 20, left: 20),
                                      width: Get.width,
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
                                        hint: Text(massaUnidMed.value),
                                        items: [
                                          '',
                                          'mg',
                                          'g',
                                          'kg',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        onChanged: (_) async {
                                          massaUnidMed.value = _;
                                        },
                                      ),
                                    ),
                                  )),
                        ResponsiveGridCol(
                            lg: 12,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 30, left: 20, bottom: 10),
                              child: Text(
                                "Status do Produto",
                                style: textBold(20, corBackDark),
                              ),
                            )),
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
                                    ativo.value == true
                                        ? "Ativo"
                                        : "Desativado",
                                    style: textRegular(18, corBackDark),
                                  )
                                ],
                              ),
                            )),
                        ResponsiveGridCol(
                            lg: 6,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 40, right: 20, left: 20),
                                child: CupertinoButton(
                                    color: CupertinoColors.activeGreen,
                                    child: Text("Salvar"),
                                    onPressed: () {
                                      if (titulo.text == "" ||
                                          desc.text == "" ||
                                          c.url.value == "" ||
                                          preco.text == "" ||
                                          precodesc.text == "" ||
                                          marca.text == "" ||
                                          unidadeMed.value == "" ||
                                          categoria.value == "") {
                                        Get.snackbar("ERRO",
                                            "Faltam dados para cadastro do produto!");
                                      } else {
                                        Get.snackbar("ok", "ok");

                                        c.salvarProduto(categoria.value, {
                                          "titulo": titulo.text,
                                          "desc": desc.text,
                                          "img": c.url.value,
                                          "preco": double.parse(preco.text
                                              .replaceAll("R\$ ", "")
                                              .replaceAll(",", ".")),
                                          "precoDesc": double.parse(precodesc
                                              .text
                                              .replaceAll("R\$ ", "")
                                              .replaceAll(",", ".")),
                                          "ativo": true,
                                          "marca": marca.text,
                                          "unidadeMed": unidadeMed.value,
                                          "imgFit": imgContain.value == true
                                              ? "contain"
                                              : "full",
                                          "medida": {
                                            "capac": capacBool.value == false
                                                ? ""
                                                : num.parse(capac.text),
                                            "capacUnidMed":
                                                capacBool.value == false
                                                    ? ""
                                                    : capacUnidMed.value,
                                            "massa": massaBool.value == false
                                                ? ""
                                                : num.parse(massa.text),
                                            "massaUnidMed":
                                                massaBool.value == false
                                                    ? ""
                                                    : massaUnidMed.value,
                                          }
                                        });
                                      }
                                    }))),
                        ResponsiveGridCol(
                            lg: 6,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 40, left: 20, right: 20),
                                child: CupertinoButton(
                                    color: CupertinoColors.systemGrey,
                                    child: Text("Limpar Campos"),
                                    onPressed: () {
                                      limparCampos();
                                    }))),
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
