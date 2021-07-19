import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superbaleia/adm/home_adm.dart';
import 'package:superbaleia/adm/login/login_adm.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/data/produto_data.dart';

class ControllerAdm extends GetxController {
  @override
  void onInit() {
    carregarUsuariosAdm();
    carregarTodos();
    carregarVendas();
    carregarClientes();
    super.onInit();
  }

  RxBool carregando = false.obs;
  RxList produtos = [].obs;
  RxList vendas = [].obs;
  RxList clientes = [].obs;
  RxString url = "".obs;
  RxDouble urlPorcentagem = 0.0.obs;
  PickedFile image;
  Rx<FirebaseAuth> _auth = FirebaseAuth.instance.obs;
  Rx<User> firebaseUser = Rxn<User>();
  RxMap clienteDataAdm = {}.obs;

  getImage() async {
    image = await ImagePicker().getImage(source: ImageSource.gallery);
    uploadImage();
  }

  uploadImage() async {
    urlPorcentagem.value = 0.3;
    Uint8List bytes = await image.readAsBytes();
    urlPorcentagem.value = 0.4;
    Reference ref =
        FirebaseStorage.instance.ref().child('produtos/${DateTime.now()}.png');
    urlPorcentagem.value = 0.5;
    UploadTask uploadTask =
        ref.putData(bytes, SettableMetadata(contentType: 'image/png'));
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(() => urlPorcentagem.value = 1)
        .catchError((error) {
      urlPorcentagem.value = 0;
    });
    url.value = await taskSnapshot.ref.getDownloadURL();
    urlPorcentagem.value = 0;
  }

  Future<Null> salvarProduto(
      String categoria, Map<String, dynamic> prod) async {
    await FirebaseFirestore.instance
        .collection('produtos')
        .doc(categoria)
        .collection('itens')
        .doc()
        .set(prod);

    ProdutoData produtoData = ProdutoData.fromJson(prod);
    produtos.add(produtoData);
  }

  loginAdmin({
    @required String email,
    @required String pass,
  }) async {
    carregando.value = true;

    _auth.value
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((result) {
      firebaseUser.value = result.user;
      carregarUsuariosAdm();

      Get.snackbar("Login Realizado com Sucesso 😕", "Carregando dados!",
          backgroundColor: CupertinoColors.activeGreen,
          borderRadius: 10,
          margin: EdgeInsets.all(20),
          colorText: Colors.white);
      Get.to(() => HomeAdm());
    }).catchError((e) {
      carregando.value = false;
      Get.snackbar("Email ou Senha Incorretos 😕",
          "Verifique seus dados e tente novamente!",
          backgroundColor: CupertinoColors.systemRed,
          borderRadius: 10,
          margin: EdgeInsets.all(20),
          colorText: Colors.white);
    });
  }

  Future<Null> carregarUsuariosAdm() async {
    carregando.value = true;
    if (firebaseUser.value == null)
      firebaseUser.value = _auth.value.currentUser;

    carregando.value = false;
    if (firebaseUser.value != null) {
      if (clienteDataAdm['nome'] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection('painel_adm')
            .doc("login")
            .collection('logins')
            .doc(firebaseUser.value.uid)
            .get();

        clienteDataAdm.value = docUser.data();
        carregando.value = false;
      }
    }
  }

  sairAdm() async {
    carregando.value = true;
    await _auth.value.signOut();
    clienteDataAdm.value = Map();
    firebaseUser.value = null;
    carregando.value = false;

    Get.back();
    Get.offAll(() => LoginAdm());
  }

  carregarTodos() async {
    carregando.value = true;
    produtos.value = [];
    await _carregarCatBebidas();
    await _carregarCatBebidasAlcoolicas();
    await _carregarCatCarnesePeixaria();
    await _carregarCatCongelados();
    await _carregarCatHigiene();
    await _carregarCatHortifruti();
    await _carregarCatInfantil();
    await _carregarCatLaticinios();
    await _carregarCatLimpeza();
    await _carregarCatMercearia();
    await _carregarCatPadaria();
    await _carregarCatPet();
    await _carregarCatUtilidades();
    carregando.value = false;
  }

  carregarClientes() async {
    carregando.value = true;
    clientes.value = [];
    QuerySnapshot resFire =
        await FirebaseFirestore.instance.collection('clientes').get();
    resFire.docs.map((DocumentSnapshot doc) {
      ClienteData clienteData = ClienteData.fromDocument(doc);
      return clientes.add(clienteData);
    }).toList();
    carregando.value = false;
  }

  carregarVendas() async {
    carregando.value = true;
    vendas.value = [];
    QuerySnapshot resFire =
        await FirebaseFirestore.instance.collection('pedidos').get();
    resFire.docs.map((DocumentSnapshot doc) {
      PedidoData pedidos = PedidoData.fromDocument(doc);
      return vendas.add(pedidos);
    }).toList();
    carregando.value = false;
  }

  double getVendasTotal() {
    double price = 0.0;
    for (PedidoData c in vendas) {
      price += c.totalPedido;
    }
    return price;
  }

  String getNivelUser() {
    String nivel;
    nivel = clienteDataAdm['nivel'];
    return nivel;
  }

  _carregarCatBebidas() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('bebidas')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatBebidasAlcoolicas() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('bebidas alcoolicas')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatCarnesePeixaria() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('carnes e peixaria')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatCongelados() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('congelados')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatHigiene() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('higiene')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatHortifruti() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('hortifruti')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatInfantil() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('infantil')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatLaticinios() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('laticinios')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatLimpeza() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('limpeza')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatMercearia() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('mercearia')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatPadaria() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('padaria')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatPet() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('pet')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  _carregarCatUtilidades() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .doc('utilidades')
        .collection('itens')
        .get();
    resFire.docs.map((DocumentSnapshot doc) {
      ProdutoData prod = ProdutoData.fromDocument(doc);
      return produtos.add(prod);
    }).toList();
  }

  Future<Null> deleteProduto(ProdutoData prod) async {
    await FirebaseFirestore.instance
        .collection("produtos")
        .doc(prod.categoria)
        .collection("itens")
        .doc(prod.id)
        .delete();
  }
}
