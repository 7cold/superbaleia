import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoData {
  String id;
  String clienteId;
  Map cliente;
  Timestamp data;
  Map entrega;
  String formaPag;
  List produtos;
  num totalProdutos;
  num totalPedido;
  num status;

  PedidoData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    clienteId = document['clientId'];
    cliente = document['cliente'];
    data = document['data'];
    entrega = document['entrega'];
    formaPag = document['formaPag'];
    produtos = document['produtos'];
    totalPedido = document['totalPedido'];
    totalProdutos = document['produtosPreco'];
    status = document['status'];
  }
}
