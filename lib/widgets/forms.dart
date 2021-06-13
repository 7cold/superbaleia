import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'colors.dart';
import 'texts.dart';

final Controller c = Get.find();

class BaleiaForms {
  static textFormField(String hint, TextEditingController controller) =>
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.name,
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
            autofocus: true,
            // obscureText: c.showPassword.value,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  FocusScope.of(Get.context).unfocus();
                  // c.funcShowPassword();
                },
                icon: Icon(
                  c.showPassword.value
                      ? Icons.remove_red_eye_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: Color(corGrey),
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

  static textFormFielSearch(String hint, TextEditingController controller) =>
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
          height: 45,
          child: TextField(
            controller: controller,
            autofocus: false,
            obscureText: false,
            decoration: InputDecoration(
              suffixIcon: Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(corPri),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 18,
                    color: Color(corBack),
                  ),
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

  static textFormFieldCad(
          String hint, user, campo, valid, teclado, obscureText) =>
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: TextFormField(
          keyboardType: teclado,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: hint,
            fillColor: Colors.blue,
            hintStyle: textRegular(15, corGrey),
            contentPadding: EdgeInsets.only(
              left: 15,
            ),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey[350],
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey[300],
                width: 2,
              ),
            ),
          ),
          validator: valid,
          onSaved: campo,
        ),
      );
}
