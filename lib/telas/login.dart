import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/services/services.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/forms.dart';

TextEditingController email = TextEditingController();
TextEditingController senha = TextEditingController();

class LoginUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            BaleiaForms.textFormField("email", email),
            BaleiaForms.textFormFieldPass("senha", senha),
            BaleiaButtons.buttonPrimary(
              "Login",
              Get.width,
              35,
              () async {
                //chama funcao de login
                login(email.text, senha.text).then((result) {
                  //checa o resultado com o mysql e retorna um snackbar usando pacote GET
                  if (result == "error") {
                    return Get.rawSnackbar(
                        snackPosition: SnackPosition.BOTTOM,
                        message: "Usuário ou senhas incorretos! 😕",
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
    );
  }
}
