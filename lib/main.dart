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
bool ocultar = true;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaleiaForms.textFormField("email", email),
            BaleiaForms.textFormFieldPass("senha", senha, () {
              //Substituir por GETX pra eu aprender
              setState(() {
                ocultar = !ocultar;
              });
            }, ocultar),
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
