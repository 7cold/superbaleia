import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/cadastroFinalizado.dart';
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
    return Scaffold(
      backgroundColor: Color(corBack),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 70),
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Cadastro",
                        style: textHeavy(
                          36,
                          corBackDark,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Por favor preencha os campos abaixo",
                        style: textHeavy(
                          12,
                          corGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, top: 70, bottom: 15, right: 20),
                        child: ResponsiveGridCol(
                          lg: 12,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: Colors.grey[350],
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    'Cidade:',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))),
                                      dropdownColor: Color(corBack),
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey[600],
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      BaleiaForms.textFormFieldCad(
                        "Nome",
                        _nome,
                        valNum,
                        TextInputType.name,
                        false,
                        TextCapitalization.words,
                      ),
                      BaleiaForms.textFormFieldCad(
                        "Sobrenome",
                        _sobrenome,
                        valNum,
                        TextInputType.name,
                        false,
                        TextCapitalization.words,
                      ),
                      BaleiaForms.textFormFieldCad(
                        "CPF",
                        _cpf,
                        valCpf,
                        TextInputType.number,
                        false,
                        TextCapitalization.none,
                      ),
                      BaleiaForms.textFormFieldCad(
                        "Endereço",
                        _endereco,
                        valNum,
                        TextInputType.name,
                        false,
                        TextCapitalization.words,
                      ),
                      ResponsiveGridRow(
                        children: [
                          ResponsiveGridCol(
                            xs: 4,
                            child: Container(
                              width: 120,
                              child: BaleiaForms.textFormFieldCad(
                                  "N°",
                                  _numero,
                                  valNum,
                                  TextInputType.number,
                                  false,
                                  TextCapitalization.none),
                            ),
                          ),
                          ResponsiveGridCol(
                            xs: 8,
                            child: Container(
                              width: 240,
                              child: BaleiaForms.textFormFieldCad(
                                  "Complemento",
                                  _complemento,
                                  valPadrao,
                                  TextInputType.name,
                                  false,
                                  TextCapitalization.words),
                            ),
                          )
                        ],
                      ),
                      BaleiaForms.textFormFieldCad(
                        "Bairro",
                        _bairro,
                        valNum,
                        TextInputType.name,
                        false,
                        TextCapitalization.words,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: ResponsiveGridRow(
                          children: [
                            ResponsiveGridCol(
                              xs: 2,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Container(
                                  height: 45,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/brasil.png'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                            ResponsiveGridCol(
                              xs: 10,
                              child: Container(
                                width: 280,
                                child: BaleiaForms.textFormFieldCad(
                                    "Telefone",
                                    _telefone,
                                    valTelefone,
                                    TextInputType.number,
                                    false,
                                    TextCapitalization.none),
                              ),
                            )
                          ],
                        ),
                      ),
                      BaleiaForms.textFormFieldCad(
                          "E-mail",
                          _email,
                          valEmail,
                          TextInputType.emailAddress,
                          false,
                          TextCapitalization.none),
                      BaleiaForms.textFormFieldCad(
                          "Senha",
                          _senha,
                          valSenha,
                          TextInputType.emailAddress,
                          true,
                          TextCapitalization.none),
                      BaleiaForms.textFormFieldCad(
                          "Confirmar senha",
                          _confirmaSenha,
                          valConfirmSenha,
                          TextInputType.emailAddress,
                          true,
                          TextCapitalization.none),
                      SizedBox(height: 20),
                      BaleiaButtons.buttonPrimary(
                          c.carregando.value == true
                              ? BaleiaExtras.widgetLoading
                              : "Cadastrar",
                          Get.width,
                          43, () async {
                        if (formKey.currentState.validate()) {
                          if (_senha.text == _confirmaSenha.text) {
                            Map<String, dynamic> clienteData = {
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
                            };
                            c.cadastrar(
                              clienteData: clienteData,
                              email: _email.text,
                              pass: _senha.text,
                              onSuccess: () {
                                Get.offAll(() => CadastroFinalizado());
                              },
                              onFail: () {
                                Get.defaultDialog(
                                  title: 'Erro ao Cadastrar  😕',
                                  titleStyle: TextStyle(
                                      color: Colors.blue, fontSize: 21),
                                  middleText:
                                      'Por favor verifique as informações e tente novamente. ',
                                  middleTextStyle: TextStyle(fontSize: 16),
                                  textCancel: "Ok",
                                  cancelTextColor: Colors.blue,
                                );
                              },
                            );
                          } else {
                            Get.defaultDialog(
                              title: 'Erro de Senha  😕',
                              titleStyle:
                                  TextStyle(color: Colors.blue, fontSize: 21),
                              middleText:
                                  'As senhas não coincidem, verifique e tente novamente.',
                              middleTextStyle: TextStyle(fontSize: 16),
                              textCancel: "Ok",
                              cancelTextColor: Colors.blue,
                            );
                          }
                        }
                      }),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
