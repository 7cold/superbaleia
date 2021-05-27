import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          color: Color(corSec),
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

  static Widget iconButton() => Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            color: Color(corGreen), borderRadius: BorderRadius.circular(8)),
        child: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          icon: Icon(
            Icons.shopping_cart_outlined,
            size: 15,
            color: Colors.white,
          ),
        ),
      );
}
