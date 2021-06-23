import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/home.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/texts.dart';

class CadastroFinalizado extends StatefulWidget {
  @override
  _CadastroFinalizadoState createState() => _CadastroFinalizadoState();
}

class _CadastroFinalizadoState extends State<CadastroFinalizado> {
  final Controller c = Get.find();
  final FlareControls _controls = FlareControls();

  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeUi(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corBack),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  child: FlareActor(
                    "assets/images/success_not_repeat.flr",
                    animation: "Untitled",
                    fit: BoxFit.contain,
                    controller: _controls,
                  ),
                ),
                Text(
                  "Cadastro realizado com sucesso!!!",
                  style: textSemiBold(24, corBackDark),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Satisfação em te ter aqui conosco 😀",
                    style: textRegular(20, corGrey),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
