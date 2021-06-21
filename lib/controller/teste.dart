import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cidadeSelecionada = 'Ouro Fino';
    return Scaffold(
      appBar: AppBar(title: Text("counter")),
      body: Center(
        child: Expanded(
          child: DropdownButtonFormField(
            elevation: 0,
            onChanged: (String valor) {
              cidadeSelecionada = valor;
            },
            value: cidadeSelecionada,
            items: <String>['Ouro Fino', 'Jacutinga', 'Borda da Mata']
                .map((String dropDrownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDrownStringItem,
                child: Text(dropDrownStringItem),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
