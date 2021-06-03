import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/services/services.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/forms.dart';
import 'package:superbaleia/widgets/texts.dart';

TextEditingController email = TextEditingController();
TextEditingController senha = TextEditingController();

class LoginUi extends StatelessWidget {
  final Controller c = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => c.carregando.value == true
            ? BaleiaExtras.widgetLoading
            : SafeArea(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.contain),
                        ),
                      ),
                      Container(
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
                            BaleiaForms.textFormField("Email", email),
                            SizedBox(height: 15),
                            BaleiaForms.textFormFieldPass("Senha", senha),
                            Padding(
                              padding: EdgeInsets.only(right: 10, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BaleiaButtons.buttonText(
                                      "Esqueci minha senha", () {})
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            BaleiaButtons.buttonPrimary(
                              "Entrar",
                              Get.width,
                              35,
                              () async {
                                //chama funcao de login
                                login(email.text, senha.text).then((result) {
                                  //checa o resultado com o mysql e retorna um snackbar usando pacote GET
                                  if (result == "error") {
                                    return Get.rawSnackbar(
                                        snackPosition: SnackPosition.BOTTOM,
                                        message:
                                            "Usuário ou senhas incorretos! 😕",
                                        backgroundColor: Color(corRed));
                                  } else if (result == "ok") {
                                    email.clear();
                                    senha.clear();
                                    return Get.rawSnackbar(
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Color(corGreen),
                                      message: "Sucesso! 😃",
                                    );
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Text(
                        "Ou",
                        style: textHeavy(
                          14,
                          corGrey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ainda não tem uma conta?",
                            style: textRegular(
                              14,
                              corGrey,
                            ),
                          ),
                          BaleiaButtons.buttonText("Cadastre-se", () {})
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
