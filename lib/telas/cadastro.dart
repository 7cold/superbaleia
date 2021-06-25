import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/home.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/forms.dart';
import 'package:superbaleia/widgets/texts.dart';
import 'package:superbaleia/widgets/validators.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final Controller c = Get.put(Controller());

  final formKey = GlobalKey<FormState>();
  var _cidadeSelecionada = 'Ouro Fino';
  final _nome = TextEditingController();
  final _sobrenome = TextEditingController();
  final _endereco = TextEditingController();
  final _numero = TextEditingController();
  final _complemento = TextEditingController();
  final _bairro = TextEditingController();
  final _telefone = MaskedTextController(mask: '(00) 00000-0000');
  final _cpf = MaskedTextController(mask: '000.000.000-00');
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmaSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: BaleiaExtras.appBar("Cadastro"),
        backgroundColor: Color(corBack),
        body: c.carregando.value == true
            ? BaleiaExtras.widgetLoading
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 20),
                              child: Text(
                                "Por favor preencha os campos abaixo",
                                style: textHeavy(16, corGrey),
                              ),
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          child: BaleiaForms.textFormFieldCad(
                            "Nome",
                            _nome,
                            valNum,
                            TextInputType.name,
                            false,
                            TextCapitalization.words,
                          ),
                        ),
                        ResponsiveGridCol(
                          child: BaleiaForms.textFormFieldCad(
                            "Sobrenome",
                            _sobrenome,
                            valNum,
                            TextInputType.name,
                            false,
                            TextCapitalization.words,
                          ),
                        ),
                        ResponsiveGridCol(
                          child: BaleiaForms.textFormFieldCad(
                            "CPF",
                            _cpf,
                            valCpf,
                            TextInputType.number,
                            false,
                            TextCapitalization.none,
                          ),
                        ),
                        ResponsiveGridCol(
                            child: Divider(
                          thickness: 0.4,
                        )),
                        ResponsiveGridCol(
                          child: BaleiaForms.textFormFieldCad(
                            "Endereço",
                            _endereco,
                            valNum,
                            TextInputType.name,
                            false,
                            TextCapitalization.words,
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 4,
                          child: BaleiaForms.textFormFieldCad(
                              "N°",
                              _numero,
                              valNum,
                              TextInputType.number,
                              false,
                              TextCapitalization.none),
                        ),
                        ResponsiveGridCol(
                            xs: 8,
                            child: BaleiaForms.textFormFieldCad(
                                "Complem.",
                                _complemento,
                                valPadrao,
                                TextInputType.name,
                                false,
                                TextCapitalization.words)),
                        ResponsiveGridCol(
                          child: BaleiaForms.textFormFieldCad(
                            "Bairro",
                            _bairro,
                            valNum,
                            TextInputType.name,
                            false,
                            TextCapitalization.words,
                          ),
                        ),
                        ResponsiveGridCol(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Container(
                                width: Get.width,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: CupertinoColors
                                        .tertiarySystemGroupedBackground,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white))),
                                    style: textRegular(18, corBackDark),
                                    isExpanded: true,
                                    icon: Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Color(corBackDark),
                                    ),
                                    onChanged: (String valor) {
                                      _cidadeSelecionada = valor;
                                    },
                                    value: _cidadeSelecionada,
                                    items: <String>[
                                      'Ouro Fino',
                                      'Jacutinga',
                                      'Borda da Mata'
                                    ].map((String dropDrownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDrownStringItem,
                                        child: Text(dropDrownStringItem),
                                      );
                                    }).toList(),
                                  ),
                                )),
                          ),
                        ),
                        ResponsiveGridCol(
                            child: Divider(
                          thickness: 0.4,
                        )),
                        ResponsiveGridCol(
                          child: BaleiaForms.textFormFieldCad(
                              "Telefone",
                              _telefone,
                              valTelefone,
                              TextInputType.number,
                              false,
                              TextCapitalization.none),
                        ),
                        ResponsiveGridCol(
                          child: BaleiaForms.textFormFieldCad(
                              "E-mail",
                              _email,
                              valEmail,
                              TextInputType.emailAddress,
                              false,
                              TextCapitalization.none),
                        ),
                        ResponsiveGridCol(
                          child: BaleiaForms.textFormFieldCad(
                              "Senha",
                              _senha,
                              valSenha,
                              TextInputType.emailAddress,
                              true,
                              TextCapitalization.none),
                        ),
                        ResponsiveGridCol(
                          child: BaleiaForms.textFormFieldCad(
                              "Confirmar senha",
                              _confirmaSenha,
                              valConfirmSenha,
                              TextInputType.emailAddress,
                              true,
                              TextCapitalization.none),
                        ),
                        ResponsiveGridCol(
                          child: Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: BaleiaButtons.buttonPrimary(
                                c.carregando.value == true
                                    ? BaleiaExtras.widgetLoading
                                    : "Cadastrar",
                                Get.width,
                                43, () async {
                              if (formKey.currentState.validate()) {
                                if (_senha.text == _confirmaSenha.text) {
                                  c.cadastroCliente(
                                    clienteData: {
                                      "cpf": _cpf.text,
                                      "nome": _nome.text,
                                      "sobrenome": _sobrenome.text,
                                      "celular": _telefone.text,
                                      "email": _email.text,
                                      "endereco": _endereco.text,
                                      "num": _numero.text,
                                      "cidade": _cidadeSelecionada,
                                      "bairro": _bairro.text,
                                      "data_cadastro": DateTime.now(),
                                    },
                                    email: _email.text,
                                    pass: _senha.text,
                                    onSuccess: () {
                                      c.login(
                                        email: _email.text,
                                        pass: _senha.text,
                                        onSuccess: () =>
                                            Get.offAll(() => HomeUi()),
                                        onFail: () {
                                          Get.defaultDialog(
                                            title: 'Erro ao Cadastrar  😕',
                                            titleStyle: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 21),
                                            middleText:
                                                'Por favor verifique as informações e tente novamente. ',
                                            middleTextStyle:
                                                TextStyle(fontSize: 16),
                                            textCancel: "Ok",
                                            cancelTextColor: Colors.blue,
                                          );
                                        },
                                      );
                                    },
                                    onFail: () {
                                      Get.defaultDialog(
                                        title: 'Erro ao Cadastrar  😕',
                                        titleStyle: TextStyle(
                                            color: Colors.blue, fontSize: 21),
                                        middleText:
                                            'Por favor verifique as informações e tente novamente. ',
                                        middleTextStyle:
                                            TextStyle(fontSize: 16),
                                        textCancel: "Ok",
                                        cancelTextColor: Colors.blue,
                                      );
                                    },
                                  );
                                } else {
                                  Get.defaultDialog(
                                    title: 'Erro de Senha  😕',
                                    titleStyle: TextStyle(
                                        color: Colors.blue, fontSize: 21),
                                    middleText:
                                        'As senhas não coincidem, verifique e tente novamente.',
                                    middleTextStyle: TextStyle(fontSize: 16),
                                    textCancel: "Ok",
                                    cancelTextColor: Colors.blue,
                                  );
                                }
                              }
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
