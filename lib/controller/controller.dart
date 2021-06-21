import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/data/categorias_data.dart';
import 'package:superbaleia/data/dicas_data.dart';
import 'package:superbaleia/telas/login.dart';

class Controller extends GetxController {
  @override
  onInit() {
    carregarUsuarios();
    super.onInit();
  }

  Rx<FirebaseAuth> _auth = FirebaseAuth.instance.obs;
  Rx<User> firebaseUser = Rxn<User>();
  RxList categorias = [].obs;
  RxList banners = [].obs;
  RxList dicas = [].obs;
  RxList pratos = [].obs;
  RxList carrinho = [].obs;
  RxMap clienteData = {}.obs;
  RxBool showPassword = true.obs;
  RxBool carregando = false.obs;

  cadastrar({
    Map<String, dynamic> clienteData,
    String email,
    String pass,
    VoidCallback onSuccess,
    VoidCallback onFail,
  }) async {
    carregando.value = true;
    try {
      final UserCredential result = await _auth.value
          .createUserWithEmailAndPassword(
              email: clienteData['email'], password: pass);

      await FirebaseFirestore.instance
          .collection('clientes')
          .doc(result.user.uid)
          .set(clienteData);

      login(
        email: clienteData['email'],
        pass: pass,
        onSuccess: onSuccess,
        onFail: onFail,
      );
    } catch (e) {
      print('falha cadastro');
    }
    carregando.value = false;
  }

  _carregarCategorias() async {
    QuerySnapshot resFire = await FirebaseFirestore.instance
        .collection('produtos')
        .orderBy("pos", descending: false)
        .get();
    List list = resFire.docs.map((DocumentSnapshot doc) {
      CategoriaData cat = CategoriaData.fromDocument(doc);
      return cat;
    }).toList();
    categorias.value = list;
  }

  _carregarDicas() async {
    QuerySnapshot resFire =
        await FirebaseFirestore.instance.collection('dicas').get();
    List list = resFire.docs.map((DocumentSnapshot doc) {
      DicaData dica = DicaData.fromDocument(doc);
      return dica;
    }).toList();
    dicas.value = list;
  }

  _carregarPratos() async {
    QuerySnapshot resFire =
        await FirebaseFirestore.instance.collection('pratos').get();
    List list = resFire.docs.map((DocumentSnapshot doc) {
      DicaData dica = DicaData.fromDocument(doc);
      return dica;
    }).toList();
    pratos.value = list;
  }

  _carregarBanners() async {
    QuerySnapshot resFire =
        await FirebaseFirestore.instance.collection('banners').get();
    List list = resFire.docs.map((DocumentSnapshot doc) {
      return doc;
    }).toList();
    banners.value = list;
  }

  sair() async {
    await _auth.value.signOut();
    clienteData.value = Map();
    firebaseUser.value = null;
    Get.offAll(() => LoginUi());
  }

  void addCartItem(CarrinhoData carrinhoData) {
    carrinho.add(carrinhoData);

    FirebaseFirestore.instance
        .collection("clientes")
        .doc(firebaseUser.value.uid)
        .collection("carrinho")
        .add(carrinhoData.toMap())
        .then((doc) {
      carrinhoData.id = doc.id;
    });
  }

  void removeCartItem(CarrinhoData carrinhoData) {
    FirebaseFirestore.instance
        .collection("clientes")
        .doc(firebaseUser.value.uid)
        .collection("carrinho")
        .doc(carrinhoData.id)
        .delete();

    carrinho.remove(carrinhoData);
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CarrinhoData c in carrinho) {
      if (c.productData != null) price += c.qtd * c.productData.preco;
    }
    return price;
  }

  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("clientes")
        .doc(firebaseUser.value.uid)
        .collection("carrinho")
        .get();

    carrinho.value =
        query.docs.map((doc) => CarrinhoData.fromDocument(doc)).toList();
  }

  void incProduct(CarrinhoData carrinhoData) {
    carrinhoData.qtd++;
    carrinho.refresh();
    FirebaseFirestore.instance
        .collection("clientes")
        .doc(firebaseUser.value.uid)
        .collection("carrinho")
        .doc(carrinhoData.id)
        .update(carrinhoData.toMap());
  }

  void decProduct(CarrinhoData carrinhoData) {
    carrinhoData.qtd--;
    carrinho.refresh();
    FirebaseFirestore.instance
        .collection("clientes")
        .doc(firebaseUser.value.uid)
        .collection("carrinho")
        .doc(carrinhoData.id)
        .update(carrinhoData.toMap());
  }

  void login({
    @required String email,
    @required String pass,
    @required VoidCallback onSuccess,
    @required VoidCallback onFail,
  }) async {
    carregando.value = true;
    _auth.value
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((result) async {
      firebaseUser.value = result.user;
      await carregarUsuarios();
      onSuccess();
      carregando.value = false;
    }).catchError((e) {
      onFail();
      carregando.value = false;
    });
  }

  RxBool verifLogado() {
    if (firebaseUser.value == null) {
      return false.obs;
    } else {
      return true.obs;
    }
  }

  Future<Null> carregarUsuarios() async {
    carregando.value = true;
    if (firebaseUser.value == null)
      firebaseUser.value = _auth.value.currentUser;
    carregando.value = false;
    if (firebaseUser.value != null) {
      if (clienteData['nome'] == null) {
        await _loadCartItems();
        _carregarDicas();
        _carregarPratos();
        _carregarBanners();
        _carregarCategorias();

        print(carrinho);

        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection('clientes')
            .doc(firebaseUser.value.uid)
            .get();

        clienteData.value = docUser.data();
        carregando.value = false;
      }
    }
  }
}
