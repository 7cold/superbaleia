import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/telas/home.dart';
import 'package:superbaleia/telas/pedidos.dart';
import 'package:superbaleia/widgets/buttons.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/texts.dart';

class FinalizarCompraUiFinal extends StatelessWidget {
  final Controller c = Get.find();
  final FlareControls _controls = FlareControls();

  final String tipoEntrega;

  FinalizarCompraUiFinal({@required this.tipoEntrega});

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
                  "Pedido realizado com sucesso!!!\n Obrigado pela preferência!",
                  style: textSemiBold(24, corBackDark),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    tipoEntrega == "Entregar a qualquer momento"
                        ? "Dentro de algumas horas entregaremos seu pedido 😀"
                        : tipoEntrega == "Retirada no mercado"
                            ? "Avisaremos pelo menu 'Meus Pedidos' quando seu pedido estiver separado e pronto para retirada!"
                            : "Entregaremos seu pedido na data marcada!",
                    style: textRegular(20, corGrey),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                BaleiaButtons.buttonPrimary(
                    "Meus Pedidos", Get.context.width, 45, () {
                  Get.off(() => HomeUi());
                  Get.to(() => PedidosUi());
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
