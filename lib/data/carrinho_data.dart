import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superbaleia/data/produto_data.dart';

class CarrinhoData {
  String id;
  String categoria;
  String produtoId;
  int qtd;
  Timestamp data;

  ProdutoData productData;

  CarrinhoData();

  CarrinhoData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    categoria = document['categoria'];
    produtoId = document['produtoId'];
    productData = ProdutoData.fromJson(document['produto']);
    qtd = document['qtd'];
    data = document['data'];
  }

  Map<String, dynamic> toMap() {
    return {
      "categoria": categoria,
      "produtoId": produtoId,
      "qtd": qtd,
      "data": data,
      "produto": productData.toResumeMap(),
    };
  }
}
