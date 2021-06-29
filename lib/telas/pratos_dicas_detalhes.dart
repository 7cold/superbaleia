import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/data/dicas_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';

class PratosDicasDetalhesUi extends StatelessWidget {
  final DicasData dica;

  const PratosDicasDetalhesUi({@required this.dica});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corBack),
      appBar: BaleiaExtras.appBar(dica.titulo),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: Get.context.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(dica.img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
                options: CarouselOptions(
                  viewportFraction: 1,
                  initialPage: 0,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, bottom: 0),
              child: Text(dica.titulo, style: textBold(22, corBackDark)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Material(
                color: Colors.white,
                shadowColor: Colors.white.withAlpha(50),
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Descrição", style: textSemiBold(16, corBackDark)),
                      SizedBox(height: 10),
                      Container(
                          width: Get.width,
                          child: Text(dica.texto,
                              style: textRegular(16, corGrey))),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Material(
                color: Colors.white,
                shadowColor: Colors.white.withAlpha(50),
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Detalhes de preparo",
                          style: textSemiBold(16, corBackDark)),
                      SizedBox(height: 10),
                      Column(children: [
                        Row(
                          children: [
                            Text("Kcal: ", style: textRegular(16, corBackDark)),
                            Text(dica.kcal.toString(),
                                style: textRegular(16, corGrey)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Tempo de Preparo: ",
                                style: textRegular(16, corBackDark)),
                            Text(dica.tempo.toString() + " min",
                                style: textRegular(16, corGrey)),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
