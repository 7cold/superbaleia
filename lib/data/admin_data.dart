import 'package:cloud_firestore/cloud_firestore.dart';

class AdminData {
  String uid;
  String cpf;
  String email;
  String nivel;
  String nome;

  AdminData({
    this.uid,
    this.cpf,
    this.email,
    this.nivel,
    this.nome,
  });

  AdminData.fromDocument(DocumentSnapshot document) {
    uid = document.id;
    cpf = document['cpf'];
    email = document['email'];
    nome = document['nome'];
    nivel = document['nivel'];
  }

  AdminData.fromMap(Map<dynamic, dynamic> map) {
    uid = this.uid;
    cpf = this.cpf;
    email = this.email;
    nome = this.nome;
    nivel = this.nivel;
  }

  AdminData.fromJson(Map<dynamic, dynamic> json) {
    uid = json['uid'];
    cpf = json['cpf'];
    email = json['email'];
    nome = json['nome'];
    nivel = json['nivel'];
  }
}
