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
  List espec;

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
    this.espec,
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
    espec = json['espec'];
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
    espec = document['espec'];
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
      "espec": espec
    };
  }
}

class ProdEscpec {
  String espec;
  dynamic valor;

  ProdEscpec.fromList(Map<String, dynamic> res) {
    espec = res['espec'];
    valor = res['valor'];
  }
}
