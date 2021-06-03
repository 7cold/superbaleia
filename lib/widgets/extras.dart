import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/cliente_data.dart';

import 'buttons.dart';
import 'colors.dart';
import 'texts.dart';

class BaleiaExtras {
  static Widget widgetLoading = Center(
    child: CupertinoActivityIndicator(),
  );

  static Widget drawer(ClienteData cliente, Controller c, List<Widget> list) =>
      Drawer(
        elevation: 0,
        child: Container(
          color: Color(corBack),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Text(
                        cliente.clienteNome,
                        style: textHeavy(22, corBackDark),
                      ),
                      SizedBox(height: 15),
                      Text(
                        cliente.clienteCel,
                        style: textLight(14, corGrey),
                      ),
                      Text(
                        cliente.clienteEnd + " - " + cliente.clienteEndNum,
                        style: textLight(14, corGrey),
                      ),
                      SizedBox(height: 40),
                      Column(
                        children: list,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: BaleiaButtons.buttonSecondary("Sair", 180, 35, () {
                    c.logoutCliente();
                  }),
                ),
              ),
            ],
          ),
        ),
      );

  static Widget itemDrawer(IconData icon, String label, Widget page) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: InkWell(
          onTap: () => Get.to(() => page, transition: Transition.rightToLeft),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(label, style: textRegular(16, corBackDark)),
                  ],
                ),
                Icon(CupertinoIcons.chevron_right,
                    size: 18, color: Color(corGrey))
              ],
            ),
          ),
        ),
      );

  static Widget appBar(String title) => AppBar(
        elevation: 5,
        shadowColor: Colors.white.withOpacity(0.2),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          title.toString(),
          style: textSemiBold(20, corBackDark),
        ),
        iconTheme: IconThemeData(
          color: Color(corBackDark),
        ),
      );

  static Widget iconFreteGratis() => Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
            color: CupertinoColors.activeBlue,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            "FRETE GRÁTIS",
            style: textRegular(10, corBack),
          ),
        ),
      );

  static Widget iconDesconto() => Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
            color: CupertinoColors.systemOrange,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            "OFERTA",
            style: textRegular(10, corBack),
          ),
        ),
      );

  static Widget nenhumProd() => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/pag_nenhum_prod.png",
                scale: 9,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  "Nenhum produto, volte para continuar! 😕",
                  style: textRegular(18, corBackDark),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );
}
