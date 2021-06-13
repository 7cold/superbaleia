import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'colors.dart';
import 'texts.dart';

class BaleiaExtras {
  static Widget widgetLoading = Center(
    child: CupertinoActivityIndicator(),
  );

  static Widget drawer(Controller c, List<Widget> list) {
    ClienteData cliente = ClienteData.fromJson(c.clienteData);
    return Drawer(
      elevation: 0,
      child: Container(
        color: Color(corBack),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: cliente.nome == null
                    ? BaleiaExtras.widgetLoading
                    : Column(
                        children: [
                          Text(
                            cliente.nome,
                            style: textHeavy(22, corBackDark),
                          ),
                          SizedBox(height: 15),
                          Text(
                            cliente.celular,
                            style: textLight(14, corGrey),
                          ),
                          Text(
                            cliente.endereco + " - " + cliente.numero,
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
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      c.sair();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(corRed),
                                ),
                                child: Icon(Icons.logout_rounded,
                                    size: 18, color: Color(corBack)),
                              ),
                              SizedBox(width: 10),
                              Text("Sair", style: textRegular(16, 0XFF6B6B6C)),
                            ],
                          ),
                          Icon(CupertinoIcons.chevron_right,
                              size: 18, color: Color(corGrey))
                        ],
                      ),
                    ),
                  ),
                )

                // Padding(
                //   padding: EdgeInsets.only(bottom: 40),
                //   child: BaleiaButtons.buttonSecondary("Sair", 180, 35, () {
                //     c.sair();
                //   }),
                // ),
                ),
          ],
        ),
      ),
    );
  }

  static Widget itemDrawer(IconData icon, String label, Widget page) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: InkWell(
          onTap: () {
            Get.back();
            Get.to(() => page, transition: Transition.rightToLeft);
          },
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
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(corPri),
                      ),
                      child: Icon(icon, size: 18, color: Color(corBack)),
                    ),
                    SizedBox(width: 10),
                    Text(label, style: textRegular(16, 0XFF6B6B6C)),
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

  static Widget appBarCart(String title, String qtd) => AppBar(
        elevation: 5,
        shadowColor: Colors.white.withOpacity(0.2),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(top: 22, bottom: 22, right: 15),
            padding: EdgeInsets.only(left: 13, right: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(corPri),
            ),
            child: Center(child: Text(qtd, style: textSemiBold(16, corBack))),
          )
        ],
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
