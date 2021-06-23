import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/data/categorias_data.dart';
import 'package:superbaleia/widgets/card.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class TodasCategoriasUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();
    return Scaffold(
      appBar: BaleiaExtras.appBar("Categorias"),
      backgroundColor: Color(corBack),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            c.categorias.length == 0
                ? SizedBox(
                    width: context.width,
                    child: BaleiaExtras.widgetLoading,
                  )
                : Column(
                    children: c.categorias.map((doc) {
                      CategoriaData cat = doc;
                      return BaleiaCards.cardTodasCat(cat);
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
