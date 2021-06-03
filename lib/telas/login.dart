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
final Controller c = Get.put(Controller());

class LoginUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(corBack),
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
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/logo2.png'),
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ],
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
                              style: textHeavy(
                                12,
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
                            BaleiaForms.textFormFieldPass("Senha", senha),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    //TODO Funão para recuperação de senha
                                    onPressed: () {},
                                    child: Text(
                                      "Esqueci minha senha",
                                      style: textHeavy(
                                        12,
                                        corPri,
                                      ),
                                    ),
                                  ),
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
                          12,
                          corGrey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ainda não tem uma conta?",
                            style: textHeavy(
                              12,
                              corGrey,
                            ),
                          ),
                          TextButton(
                            //TODO Chamar tela de Cadastro
                            onPressed: () {},
                            child: Text(
                              "Cadastre-se",
                              style: textHeavy(
                                12,
                                corPri,
                              ),
                            ),
                          ),
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
