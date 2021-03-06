import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/data/categorias_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/card.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';

class ProdutosUi extends StatelessWidget {
  final CategoriaData cat;

  const ProdutosUi({@required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaleiaExtras.appBar(cat.titulo),
      backgroundColor: Color(corBack),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('produtos')
            .doc(cat.id)
            .collection('itens')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: BaleiaExtras.widgetLoading);
          } else {
            return snapshot.data.docs.length == 0
                ? BaleiaExtras.nenhumProd()
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: ResponsiveGridRow(
                      children: snapshot.data.docs.map((doc) {
                        ProdutoData prod = ProdutoData.fromDocument(doc);
                        return ResponsiveGridCol(
                          xs: 6,
                          sm: 6,
                          lg: 3,
                          md: 4,
                          xl: 2,
                          child: BaleiaCards.cardProd(prod, cat.id),
                        );
                      }).toList(),
                    ),
                  );
          }
        },
      ),
    );
  }
}
