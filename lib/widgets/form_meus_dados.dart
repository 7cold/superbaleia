import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/forms.dart';
import 'package:superbaleia/widgets/texts.dart';

final Controller c = Get.find();

class BaleiaMeusDados {
  static Widget nome() {
    TextEditingController nome = TextEditingController();
    nome.text = c.clienteData['nome'];
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Editar nome", style: textSemiBold(22, corBackDark)),
                  BaleiaForms.textFormField("Nome", nome, []),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          color: CupertinoColors.systemGreen,
                          child: Text("Salvar"),
                          onPressed: () async {
                            c.clienteData['nome'] = nome.text.capitalize;
                            await FirebaseFirestore.instance
                                .collection("clientes")
                                .doc(c.firebaseUser.value.uid)
                                .update({
                              "nome": nome.text.capitalize,
                            });
                            Get.back();
                          }),
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          color: Color(corRed),
                          child: Text("Cancelar"),
                          onPressed: () {
                            Get.back();
                            nome.text = c.clienteData['nome'];
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
          isDismissible: false,
          enableDrag: false,
        );
      },
      child: Material(
        elevation: 5,
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 4,
                    child: Container(
                      width: Get.width,
                      child: Text("Nome", style: textSemiBold(16, corGrey)),
                    )),
                Flexible(
                    flex: 6,
                    child: Container(
                      width: Get.width,
                      child: Text(c.clienteData['nome'],
                          style: textRegular(18, corBackDark)),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      width: Get.width,
                      child: Icon(Icons.chevron_right_rounded),
                    )),
              ],
            )),
      ),
    );
  }

  static Widget sobrenome() {
    TextEditingController sobrenome = TextEditingController();
    sobrenome.text = c.clienteData['sobrenome'];
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Editar Sobrenome",
                      style: textSemiBold(22, corBackDark)),
                  BaleiaForms.textFormField("Sobrenome", sobrenome, []),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          color: CupertinoColors.systemGreen,
                          child: Text("Salvar"),
                          onPressed: () async {
                            c.clienteData['sobrenome'] =
                                sobrenome.text.capitalize;
                            await FirebaseFirestore.instance
                                .collection("clientes")
                                .doc(c.firebaseUser.value.uid)
                                .update({
                              "sobrenome": sobrenome.text.capitalize,
                            });
                            Get.back();
                          }),
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          color: Color(corRed),
                          child: Text("Cancelar"),
                          onPressed: () {
                            Get.back();
                            sobrenome.text = c.clienteData['sobrenome'];
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
          isDismissible: false,
          enableDrag: false,
        );
      },
      child: Material(
        elevation: 5,
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 4,
                    child: Container(
                      width: Get.width,
                      child:
                          Text("Sobrenome", style: textSemiBold(16, corGrey)),
                    )),
                Flexible(
                    flex: 6,
                    child: Container(
                      width: Get.width,
                      child: Text(c.clienteData['sobrenome'],
                          style: textRegular(18, corBackDark)),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      width: Get.width,
                      child: Icon(Icons.chevron_right_rounded),
                    )),
              ],
            )),
      ),
    );
  }

  static Widget cpf() {
    return Material(
      elevation: 5,
      shadowColor: Colors.white.withAlpha(50),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                  flex: 4,
                  child: Container(
                    width: Get.width,
                    child: Text("CPF", style: textSemiBold(16, corGrey)),
                  )),
              Flexible(
                  flex: 6,
                  child: Container(
                    width: Get.width,
                    child: Text(c.clienteData['cpf'],
                        style: textRegular(18, corBackDark)),
                  )),
              Flexible(
                flex: 1,
                child: Container(
                  width: Get.width,
                  child: SizedBox(),
                ),
              ),
            ],
          )),
    );
  }

  static Widget email() {
    return Material(
      elevation: 5,
      shadowColor: Colors.white.withAlpha(50),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                  flex: 4,
                  child: Container(
                    width: Get.width,
                    child: Text("Email", style: textSemiBold(16, corGrey)),
                  )),
              Flexible(
                  flex: 6,
                  child: Container(
                    width: Get.width,
                    child: Text(c.clienteData['email'],
                        style: textRegular(18, corBackDark)),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    width: Get.width,
                    child: SizedBox(),
                  )),
            ],
          )),
    );
  }

  static Widget celular() {
    TextEditingController celular = TextEditingController();
    celular.text = c.clienteData['celular'];
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Editar Celular", style: textSemiBold(22, corBackDark)),
                  BaleiaForms.textFormField("Celular", celular, [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          color: CupertinoColors.systemGreen,
                          child: Text("Salvar"),
                          onPressed: () async {
                            c.clienteData['celular'] = celular.text;
                            await FirebaseFirestore.instance
                                .collection("clientes")
                                .doc(c.firebaseUser.value.uid)
                                .update({
                              "celular": celular.text,
                            });
                            Get.back();
                          }),
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          color: Color(corRed),
                          child: Text("Cancelar"),
                          onPressed: () {
                            Get.back();
                            celular.text = c.clienteData['celular'];
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
          isDismissible: false,
          enableDrag: false,
        );
      },
      child: Material(
        elevation: 5,
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 4,
                    child: Container(
                      width: Get.width,
                      child: Text("Celular", style: textSemiBold(16, corGrey)),
                    )),
                Flexible(
                    flex: 6,
                    child: Container(
                      width: Get.width,
                      child: Text(c.clienteData['celular'],
                          style: textRegular(18, corBackDark)),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      width: Get.width,
                      child: Icon(Icons.chevron_right_rounded),
                    )),
              ],
            )),
      ),
    );
  }

  static Widget endereco() {
    TextEditingController endereco = TextEditingController();
    endereco.text = c.clienteData['endereco'];
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Editar Endereço", style: textSemiBold(22, corBackDark)),
                  BaleiaForms.textFormField("Endereço", endereco, []),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          color: CupertinoColors.systemGreen,
                          child: Text("Salvar"),
                          onPressed: () async {
                            c.clienteData['endereco'] =
                                endereco.text.capitalize;
                            await FirebaseFirestore.instance
                                .collection("clientes")
                                .doc(c.firebaseUser.value.uid)
                                .update({
                              "endereco": endereco.text.capitalize,
                            });
                            Get.back();
                          }),
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          color: Color(corRed),
                          child: Text("Cancelar"),
                          onPressed: () {
                            Get.back();
                            endereco.text = c.clienteData['endereco'];
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
          isDismissible: false,
          enableDrag: false,
        );
      },
      child: Material(
        elevation: 5,
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 4,
                    child: Container(
                      width: Get.width,
                      child: Text("Endereço", style: textSemiBold(16, corGrey)),
                    )),
                Flexible(
                    flex: 6,
                    child: Container(
                      width: Get.width,
                      child: Text(c.clienteData['endereco'],
                          style: textRegular(18, corBackDark)),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      width: Get.width,
                      child: Icon(Icons.chevron_right_rounded),
                    )),
              ],
            )),
      ),
    );
  }

  static Widget enderecoNum() {
    TextEditingController numero = TextEditingController();
    numero.text = c.clienteData['num'];
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Editar Número", style: textSemiBold(22, corBackDark)),
                  BaleiaForms.textFormField("Número", numero, []),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          color: CupertinoColors.systemGreen,
                          child: Text("Salvar"),
                          onPressed: () async {
                            c.clienteData['num'] = numero.text;
                            await FirebaseFirestore.instance
                                .collection("clientes")
                                .doc(c.firebaseUser.value.uid)
                                .update({
                              "num": numero.text,
                            });
                            Get.back();
                          }),
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          color: Color(corRed),
                          child: Text("Cancelar"),
                          onPressed: () {
                            Get.back();
                            numero.text = c.clienteData['num'];
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
          isDismissible: false,
          enableDrag: false,
        );
      },
      child: Material(
        elevation: 5,
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 4,
                    child: Container(
                      width: Get.width,
                      child: Text("Numero", style: textSemiBold(16, corGrey)),
                    )),
                Flexible(
                    flex: 6,
                    child: Container(
                      width: Get.width,
                      child: Text(c.clienteData['num'],
                          style: textRegular(18, corBackDark)),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      width: Get.width,
                      child: Icon(Icons.chevron_right_rounded),
                    )),
              ],
            )),
      ),
    );
  }

  static Widget bairro() {
    TextEditingController bairro = TextEditingController();
    bairro.text = c.clienteData['bairro'];
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Editar Bairro", style: textSemiBold(22, corBackDark)),
                  BaleiaForms.textFormField("Bairro", bairro, []),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          color: CupertinoColors.systemGreen,
                          child: Text("Salvar"),
                          onPressed: () async {
                            c.clienteData['bairro'] = bairro.text.capitalize;
                            await FirebaseFirestore.instance
                                .collection("clientes")
                                .doc(c.firebaseUser.value.uid)
                                .update({
                              "bairro": bairro.text.capitalize,
                            });
                            Get.back();
                          }),
                      CupertinoButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          color: Color(corRed),
                          child: Text("Cancelar"),
                          onPressed: () {
                            Get.back();
                            bairro.text = c.clienteData['bairro'];
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
          isDismissible: false,
          enableDrag: false,
        );
      },
      child: Material(
        elevation: 5,
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 4,
                    child: Container(
                      width: Get.width,
                      child: Text("Bairro", style: textSemiBold(16, corGrey)),
                    )),
                Flexible(
                    flex: 6,
                    child: Container(
                      width: Get.width,
                      child: Text(c.clienteData['bairro'],
                          style: textRegular(18, corBackDark)),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                      width: Get.width,
                      child: Icon(Icons.chevron_right_rounded),
                    )),
              ],
            )),
      ),
    );
  }

  static Widget cidade() {
    TextEditingController cidade = TextEditingController();
    cidade.text = c.clienteData['cidade'];
    return Material(
      elevation: 5,
      shadowColor: Colors.white.withAlpha(50),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                  flex: 4,
                  child: Container(
                    width: Get.width,
                    child: Text("Cidade", style: textSemiBold(18, corGrey)),
                  )),
              Flexible(
                flex: 8,
                child: Container(
                  width: Get.width,
                  child: Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: CupertinoColors.tertiarySystemGroupedBackground,
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
                      hint: Text(c.clienteData['cidade']),
                      items: [
                        'Ouro Fino',
                        'Jacutinga',
                        'Borda da Mata',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (_) async {
                        c.clienteData['cidade'] = _;
                        await FirebaseFirestore.instance
                            .collection("clientes")
                            .doc(c.firebaseUser.value.uid)
                            .update({
                          "cidade": _,
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
