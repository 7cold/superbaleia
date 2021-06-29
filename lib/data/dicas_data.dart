import 'package:cloud_firestore/cloud_firestore.dart';

class DicasData {
  String id;
  String titulo;
  String texto;
  String img;
  num tempo;
  num kcal;

  DicasData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    titulo = document['titulo'];
    texto = document['texto'];
    img = document['img'];
    tempo = document['tempo'];
    kcal = document['kcal'];
  }
}
