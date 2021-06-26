import 'package:cloud_firestore/cloud_firestore.dart';

class ClienteData {
  String id;
  String bairro;
  String celular;
  String cidade;
  String complemento;
  String cpf;
  String email;
  String endereco;
  String nome;
  String sobrenome;
  String numero;
  Timestamp dataCadastro;

  ClienteData({
    this.id,
    this.bairro,
    this.celular,
    this.cidade,
    this.complemento,
    this.cpf,
    this.email,
    this.endereco,
    this.nome,
    this.sobrenome,
    this.numero,
    this.dataCadastro,
  });

  ClienteData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    bairro = document['bairro'];
    celular = document['celular'];
    cidade = document['cidade'];
    complemento = document['complemento'];
    cpf = document['cpf'];
    email = document['email'];
    endereco = document['endereco'];
    nome = document['nome'];
    sobrenome = document['sobrenome'];
    numero = document['num'];
    dataCadastro = document['data_cadastro'];
  }

  ClienteData.fromMap(Map<dynamic, dynamic> map) {
    id = this.id;
    bairro = this.bairro;
    celular = this.celular;
    cidade = this.cidade;
    complemento = this.complemento;
    cpf = this.cpf;
    email = this.email;
    endereco = this.endereco;
    nome = this.nome;
    numero = this.numero;
    dataCadastro = this.dataCadastro;
  }

  ClienteData.fromJson(Map<dynamic, dynamic> json) {
    bairro = json['bairro'];
    celular = json['celular'];
    cidade = json['cidade'];
    complemento = json['complemento'];
    cpf = json['cpf'];
    email = json['email'];
    endereco = json['endereco'];
    nome = json['nome'];
    sobrenome = json['sobrenome'];
    numero = json['num'];
    dataCadastro = json['data_cadastro'];
  }
}
