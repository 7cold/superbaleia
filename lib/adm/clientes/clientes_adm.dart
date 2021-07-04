import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/widgets/baleiaAdmWidgets.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';

class ClientesAdm extends StatelessWidget {
  final RxString cidade = "Ouro Fino".obs;
  final RxString clienteSearch = "".obs;
  final RxString tipoSearch = "nome".obs;

  @override
  Widget build(BuildContext context) {
    final ControllerAdm c = Get.find();
    return Obx(
      () => Scaffold(
        backgroundColor: Color(corBack),
        appBar: BaleiaAdm.appBar("Clientes", [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                c.carregarClientes();
              },
              icon: Icon(Icons.cloud_download_outlined),
            ),
          ),
        ]),
        body: c.carregando.value == true
            ? BaleiaExtras.widgetLoading
            : SingleChildScrollView(
                child: Column(
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
                                      hint: Text(cidade.value),
                                      items: [
                                        'Ouro Fino',
                                        'Jacutinga',
                                        'Borda da Mata',
                                        'Todas',
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (_) {
                                        cidade.value = _;
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
                                      inputFormatters: tipoSearch.value == "cpf"
                                          ? [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              CpfInputFormatter(),
                                            ]
                                          : [],
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
                                                  "CPF",
                                                  style:
                                                      textRegular(12, corBack),
                                                ),
                                                onPressed:
                                                    tipoSearch.value == "cpf"
                                                        ? null
                                                        : () {
                                                            tipoSearch.value =
                                                                "cpf";
                                                          }),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                      placeholder: "Pesquisar",
                                      onChanged: (_) {
                                        clienteSearch.value = _;
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
                      children: c.clientes.where((i) {
                        ClienteData cli = i;
                        return clienteSearch.value == ""
                            ? cidade.value == "Todas"
                                ? cli.cidade != ""
                                : cli.cidade == cidade.value
                            : tipoSearch.value == "nome"
                                ? cli.nome.isCaseInsensitiveContainsAny(
                                    clienteSearch.value)
                                : tipoSearch.value == "cpf"
                                    ? cli.cpf.isCaseInsensitiveContainsAny(
                                        clienteSearch.value)
                                    : null;
                      }).map((val) {
                        ClienteData clienteData = val;
                        return BaleiaAdm.clienteItens(clienteData);
                      }).toList(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
