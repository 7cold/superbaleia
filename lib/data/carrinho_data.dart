import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superbaleia/data/produto_data.dart';

class CarrinhoData {
  String id;
  String categoria;
  String produtoId;
  int qtd;
  Timestamp data;

  ProdutoData produtoData;

  CarrinhoData();

  CarrinhoData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    categoria = document['categoria'];
    produtoId = document['produtoId'];
    produtoData = ProdutoData.fromJson(document['produto']);
    qtd = document['qtd'];
    data = document['data'];
  }

  CarrinhoData.fromMap(Map<dynamic, dynamic> map) {
    categoria = map['categoria'];
    produtoId = map['produtoId'];
    produtoData = ProdutoData.fromJson(map['produto']);
    qtd = map['qtd'];
    data = map['data'];
  }

  Map<String, dynamic> toMap() {
    return {
      "categoria": categoria,
      "produtoId": produtoId,
      "qtd": qtd,
      "data": data,
      "produto": produtoData.toResumeMap(),
    };
  }
}
