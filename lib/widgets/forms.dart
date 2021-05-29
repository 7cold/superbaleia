import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'colors.dart';
import 'texts.dart';

final Controller c = Get.put(Controller());

class BaleiaForms {
  static textFormField(String hint, TextEditingController controller) =>
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            autofocus: false,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: textRegular(15, corGrey),
              contentPadding: EdgeInsets.only(
                left: 15,
              ),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey[200],
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      );

  static textFormFieldPass(String hint, TextEditingController controller) =>
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            autofocus: false,
            obscureText: c.showPassword.value,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  c.funcShowPassword();
                },
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  size: 18,
                  color: Color(corBackDark),
                ),
              ),
              hintText: hint,
              hintStyle: textRegular(15, corGrey),
              contentPadding: EdgeInsets.only(left: 15),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey[200],
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      );
}
