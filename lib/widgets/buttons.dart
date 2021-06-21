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
              fontFamily: fontLight,
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
            style: TextStyle(
              fontFamily: fontLight,
              color: Colors.black,
            ),
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
            style: textSemiBold(
              16,
              corPri,
            ),
          ),
        ),
      );

  static Widget iconButtonCart(Function func) => Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            color: Color(corGreen), borderRadius: BorderRadius.circular(10)),
        child: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: func,
          icon: Icon(
            Icons.add_shopping_cart_rounded,
            size: 18,
            color: Colors.white,
          ),
        ),
      );

  static Widget iconCartRemove(Function func) => Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(
              color: Color(func == null ? corGrey : corPri), width: 1.2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: func == null ? null : func,
          icon: Icon(
            Icons.remove,
            size: 18,
            color: Color(func == null ? corGrey : corPri),
          ),
        ),
      );

  static Widget iconCartAdd(Function func) => Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(color: Color(corPri), width: 1.2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: func,
          icon: Icon(
            Icons.add,
            size: 18,
            color: Color(corPri),
          ),
        ),
      );
}
