import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/cadastro.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/forms.dart';
import 'package:superbaleia/widgets/texts.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  final Controller c = Get.put(Controller());
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        //deixar branco para poder dar contraste com o text field
        // backgroundColor: Color(corBack),
        body: c.carregando.value == true
            ? BaleiaExtras.widgetLoading
            : SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40, bottom: 20),
                          height: 130,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.contain),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 40),
                          child: Column(
                            children: [
                              Text(
                                "Bem vindo!",
                                style: textHeavy(
                                  36,
                                  corBackDark,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Entre para continuar",
                                style: textRegular(
                                  16,
                                  corGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              BaleiaForms.textFormField("Email", email, []),
                              SizedBox(height: 15),
                              BaleiaForms.textFormFieldPass("Senha", senha,
                                  (_) {
                                c.login(
                                  email: email.text,
                                  pass: senha.text,
                                );
                              }),
                              Padding(
                                padding: EdgeInsets.only(right: 10, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BaleiaButtons.buttonText(
                                      "Esqueci minha senha",
                                      () {
                                        if (email.text.isEmpty) {
                                          Get.snackbar("Redefinição de Senha",
                                              "Por favor insira seu email.",
                                              backgroundColor:
                                                  CupertinoColors.systemRed,
                                              borderRadius: 10,
                                              margin: EdgeInsets.all(20),
                                              colorText: Colors.white);
                                        } else {
                                          c.redefinicaoSenha(email.text);
                                          Get.defaultDialog(
                                            title: 'Redefinição de Senha',
                                            titleStyle: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 21),
                                            middleText:
                                                'Um link para redefinição de senha foi enviado para seu email',
                                            middleTextStyle:
                                                TextStyle(fontSize: 16),
                                            textCancel: "Ok",
                                            cancelTextColor: Colors.blue,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              BaleiaButtons.buttonPrimary(
                                  "Entrar",
                                  Get.context.width,
                                  45,
                                  () => c.login(
                                        email: email.text,
                                        pass: senha.text,
                                      ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "ou",
                          style: textHeavy(
                            16,
                            corGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Ainda não tem uma conta?",
                              style: textRegular(
                                16,
                                corGrey,
                              ),
                            ),
                            BaleiaButtons.buttonText("Cadastre-se", () {
                              Get.to(() => Cadastro());
                            })
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
