import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriaData {
  String id;
  String icone;
  num pos;
  String titulo;
  String color;

  CategoriaData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    icone = document['icone'];
    pos = document['pos'];
    titulo = document['titulo'];
    color = document['color'];
  }
}
