import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superbaleia/widgets/texts.dart';

import 'colors.dart';
import 'fonts.dart';

class BaleiaButtons {
  static Widget buttonPrimary(
    String label,
    double w,
    double h,
    Function func,
  ) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: h,
        width: w,
        child: CupertinoButton(
          color: Color(corPri),
          borderRadius: BorderRadius.circular(5),
          padding: EdgeInsets.all(0),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: fontUltraLight,
            ),
          ),
          onPressed: func,
        ),
      );

  static Widget buttonSecondary(
    String label,
    double w,
    double h,
    Function func,
  ) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: h,
        width: w,
        child: CupertinoButton(
          color: CupertinoColors.quaternarySystemFill,
          borderRadius: BorderRadius.circular(5),
          padding: EdgeInsets.all(0),
          child: Text(
            label,
            style: TextStyle(fontFamily: fontMedium, color: Colors.black),
          ),
          onPressed: func,
        ),
      );

  static Widget buttonText(
    String label,
    Function func,
  ) =>
      TextButton(
        onPressed: func,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            label,
            style: textHeavy(
              12,
              corPri,
            ),
          ),
        ),
      );

  static Widget iconButtonCart() => Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            color: Color(corGreen), borderRadius: BorderRadius.circular(10)),
        child: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          icon: Icon(
            Icons.add_shopping_cart_rounded,
            size: 18,
            color: Colors.white,
          ),
        ),
      );
}
