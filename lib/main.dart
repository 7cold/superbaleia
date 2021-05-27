import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/services/services.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/forms.dart';

void main() {
  runApp(MyApp());
}

TextEditingController email = TextEditingController();
TextEditingController senha = TextEditingController();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
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
                      message: "error",
                    );
                  } else if (result == "ok") {
                    return Get.rawSnackbar(
                      snackPosition: SnackPosition.BOTTOM,
                      message: "OK",
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
