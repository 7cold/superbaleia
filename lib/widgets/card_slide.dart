import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'buttons.dart';
import 'colors.dart';
import 'texts.dart';

class BaleiaCards {
  static Widget cardSlide(
    double w,
    double h,
    List<Widget> list,
  ) =>
      Material(
        shadowColor: CupertinoColors.tertiaryLabel,
        borderRadius: BorderRadius.circular(10),
        elevation: 10,
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CarouselSlider(
            items: list,
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              pageSnapping: false,
              disableCenter: false,
              initialPage: 0,
              enableInfiniteScroll: true,
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
      );

  static Widget cardSlideItem(String url) => Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill,
          ),
        ),
      );

  static Widget cardTips() => Padding(
        padding: EdgeInsets.only(left: 10, bottom: 24),
        child: Material(
          elevation: 5,
          shadowColor: Colors.white.withOpacity(0.5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 150,
            width: 120,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://www.receiteria.com.br/wp-content/uploads/receitas-de-pao-com-ovo-8-1-1200x738.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lanche Natural",
                              style: textBold(13, corBackDark),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "10 min",
                                  style: textMedium(12, corGrey),
                                ),
                                Text(
                                  "268 kcal",
                                  style: textMedium(12, corGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      );

  static Widget cardProd() => Padding(
        padding: EdgeInsets.only(left: 10, bottom: 24),
        child: Material(
          elevation: 5,
          shadowColor: Colors.white.withOpacity(0.5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 220,
            width: 150,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://minutosaudavel.com.br/wp-content/uploads/2019/11/banana-minuto-saudavel.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Banana",
                                style: textBold(16, corBackDark),
                              ),
                              Text(
                                "Preço por Kg",
                                style: textRegular(14, corGrey),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          left: 8,
                          child: Text(
                            "R\$ 15,00",
                            style: textHeavy(14, corGreen),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: BaleiaButtons.iconButton(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
