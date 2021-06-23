import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoData {
  String id;
  String titulo;
  String desc;
  String img;
  num preco;
  num precoDesc;
  bool ativo;

  String marca;
  String unidadeMed;
  String imgFit;
  Map<String, dynamic> medida;

  ProdutoData({
    this.id,
    this.titulo,
    this.desc,
    this.img,
    this.preco,
    this.precoDesc,
    this.ativo,
    this.marca,
    this.unidadeMed,
    this.imgFit,
    this.medida,
  });

  ProdutoData.fromJson(Map<dynamic, dynamic> json) {
    id = json['prod_id'];
    titulo = json['titulo'];
    desc = json['desc'];
    img = json['img'];
    preco = json['preco'];
    precoDesc = json['precoDesc'];
    ativo = json['ativo'];
    marca = json['marca'];
    unidadeMed = json['unidadeMed'];
    imgFit = json['imgFit'];
    medida = json['medida'];
  }

  ProdutoData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    titulo = document['titulo'];
    desc = document['desc'];
    img = document['img'];
    preco = document['preco'];
    precoDesc = document['precoDesc'];
    ativo = document['ativo'];
    marca = document['marca'];
    unidadeMed = document['unidadeMed'];
    imgFit = document['imgFit'];
    medida = document['medida'];
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "titulo": titulo,
      "desc": desc,
      "img": img,
      "preco": preco,
      "precoDesc": precoDesc,
      "ativo": ativo,
      "marca": marca,
      "unidMedida": unidadeMed,
      "imgFit": imgFit,
      "medida": medida
    };
  }
}
