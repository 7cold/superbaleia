import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/form_meus_dados.dart';

class DadosClienteUi extends StatelessWidget {
  final String telaAnterior;

  const DadosClienteUi({@required this.telaAnterior});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: BaleiaExtras.appBar(
            telaAnterior == "drawer" ? "Meus Dados" : "Endereço"),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: telaAnterior == "drawer"
                ? Column(
                    children: [
                      BaleiaMeusDados.nome(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.sobrenome(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.cpf(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.email(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.celular(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.endereco(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.enderecoNum(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.bairro(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.cidade(),
                    ],
                  )
                : Column(
                    children: [
                      BaleiaMeusDados.endereco(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.enderecoNum(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.bairro(),
                      SizedBox(height: 25),
                      BaleiaMeusDados.cidade(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
