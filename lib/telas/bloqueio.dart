import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/telas/login.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';

class Bloquieo extends StatelessWidget {
  final String appBar;
  Bloquieo(this.appBar);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaleiaExtras.appBar(appBar),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/cadastro.png",
                // scale: 9,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  "Por favor, entre para continuar! 😕",
                  style: textRegular(18, corBackDark),
                  textAlign: TextAlign.center,
                ),
              ),
              BaleiaButtons.buttonPrimary("Entrar", Get.width, 45, () {
                Get.off(() => LoginUi());
              }),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
