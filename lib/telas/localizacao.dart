import 'package:flutter/material.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class LocalizacaoUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corBack),
      appBar: BaleiaExtras.appBar("Localização"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              BaleiaExtras.localizacao("Ouro Fino",
                  "Avenida Delfim Moreira, 280 - Centro", "(35) 3441-2191"),
              SizedBox(height: 25),
              BaleiaExtras.localizacao(
                  "Jacutinga", "R. São Paulo, 362 - Centro", "(35) 3443-4995"),
              SizedBox(height: 25),
              BaleiaExtras.localizacao("Borda da Mata",
                  "R. Cel José Inácio, 15 - Centro", "(35) 3445-1292"),
              SizedBox(height: 25)
            ],
          ),
        ),
      ),
    );
  }
}
