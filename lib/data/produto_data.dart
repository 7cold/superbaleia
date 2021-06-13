import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoData {
  String id;
  String titulo;
  String desc;
  String img;
  num preco;
  num precoDesc;
  bool ativo;
  num peso;
  num ml;
  String marca;
  String unidadeMed;
  String imgFit;

  ProdutoData({
    this.id,
    this.titulo,
    this.desc,
    this.img,
    this.preco,
    this.precoDesc,
    this.ativo,
    this.peso,
    this.ml,
    this.marca,
    this.unidadeMed,
    this.imgFit,
  });

  ProdutoData.fromJson(Map<dynamic, dynamic> json) {
    id = json['prod_id'];
    titulo = json['titulo'];
    desc = json['desc'];
    img = json['img'];
    preco = json['preco'];
    precoDesc = json['precoDesc'];
    ativo = json['ativo'];
    peso = json['peso'];
    ml = json['ml'];
    marca = json['marca'];
    unidadeMed = json['unidadeMed'];
    imgFit = json['imgFit'];
  }

  ProdutoData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    titulo = document['titulo'];
    desc = document['desc'];
    img = document['img'];
    preco = document['preco'];
    precoDesc = document['precoDesc'];
    ativo = document['ativo'];
    peso = document['peso'];
    ml = document['ml'];
    marca = document['marca'];
    unidadeMed = document['unidadeMed'];
    imgFit = document['imgFit'];
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "titulo": titulo,
      "desc": desc,
      "img": img,
      "preco": preco,
      "precoDesc": precoDesc,
      "ativo": ativo,
      "peso": peso,
      "ml": ml,
      "marca": marca,
      "unidMedida": unidadeMed,
      "imgFit": imgFit
    };
  }
}
