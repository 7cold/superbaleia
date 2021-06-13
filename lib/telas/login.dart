import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/home.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/forms.dart';
import 'package:superbaleia/widgets/texts.dart';

class LoginUi extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();
  final Controller c = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
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
                      BaleiaButtons.buttonPrimary("Entrar", Get.width, 35, () {
                        c.login(
                            email: email.text,
                            pass: senha.text,
                            onSuccess: () {
                              Get.to(() => HomeUi());
                            },
                            onFail: () {
                              Get.snackbar("Email ou Senha Incorretos 😕",
                                  "Verifique seus dados e tente novamente!",
                                  backgroundColor: CupertinoColors.systemRed,
                                  borderRadius: 10,
                                  margin: EdgeInsets.all(20),
                                  colorText: Colors.white);
                            });
                      })
                    ],
                  ),
                ),
                Text(
                  "ou",
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
                    BaleiaButtons.buttonText("Cadastre-se", () {
                      // Get.to(() => Cadastro());
                    })
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
