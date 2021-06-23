import 'package:flutter/material.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class AjudaUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corBack),
      appBar: BaleiaExtras.appBar("Ajuda"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [BaleiaExtras.ajudaCard()],
            )),
      ),
    );
  }
}
