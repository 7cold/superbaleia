import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/widgets/baleiaAdmWidgets.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/forms.dart';
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
        appBar: BalAdm.appBar("Clientes", [
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
                      child: Column(
                        children: [
                          Text("Filtros", style: textSemiBold(18, corBackDark)),
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BaleiaButtons.buttonPrimary(
                                    "Ouro Fino",
                                    150,
                                    30,
                                    cidade.value == "Ouro Fino"
                                        ? null
                                        : () {
                                            cidade.value = "Ouro Fino";
                                          }),
                                BaleiaButtons.buttonPrimary(
                                    "Jacutinga",
                                    150,
                                    30,
                                    cidade.value == "Jacutinga"
                                        ? null
                                        : () {
                                            cidade.value = "Jacutinga";
                                          }),
                                BaleiaButtons.buttonPrimary(
                                    "Borda da Mata",
                                    150,
                                    30,
                                    cidade.value == "Borda da Mata"
                                        ? null
                                        : () {
                                            cidade.value = "Borda da Mata";
                                          }),
                                BaleiaButtons.buttonPrimary(
                                    "Todos",
                                    150,
                                    30,
                                    cidade.value == ""
                                        ? null
                                        : () {
                                            cidade.value = "";
                                          })
                              ]),
                          SizedBox(height: 10),
                          CupertinoTextField(
                            suffix: Row(
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: CupertinoButton(
                                      padding: EdgeInsets.all(0),
                                      color: CupertinoColors.activeGreen,
                                      child: Text(
                                        "Nome",
                                        style: textRegular(14, corBack),
                                      ),
                                      onPressed: tipoSearch.value == "nome"
                                          ? null
                                          : () {
                                              tipoSearch.value = "nome";
                                            }),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: CupertinoButton(
                                      padding: EdgeInsets.all(0),
                                      color: CupertinoColors.activeGreen,
                                      child: Text(
                                        "CPF",
                                        style: textRegular(14, corBack),
                                      ),
                                      onPressed: tipoSearch.value == "cpf"
                                          ? null
                                          : () {
                                              tipoSearch.value = "cpf";
                                            }),
                                ),
                              ],
                            ),
                            placeholder: "Pesquisar",
                            onChanged: (_) {
                              clienteSearch.value = _;
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Column(
                      children: c.clientes.where((i) {
                        ClienteData cli = i;
                        return clienteSearch.value == ""
                            ? cidade.value == ""
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
                        return BalAdm.clienteItens(clienteData);
                      }).toList(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
