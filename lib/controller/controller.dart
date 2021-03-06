import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/data/categorias_data.dart';
import 'package:superbaleia/data/dicas_data.dart';
import 'package:superbaleia/telas/home.dart';

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

  RxString tipoEntega = "Entregar a qualquer momento".obs;
  RxInt formaPag = 1.obs;
  Rx<DateTime> diaEntrega = DateTime.now().obs;
  Rx<TimeOfDay> horaEntrega = TimeOfDay.now().obs;

  RxMap clienteData = {}.obs;
  RxBool showPassword = true.obs;
  RxBool carregando = false.obs;

  cadastroCliente({
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

      carregando.value = false;
      onSuccess();
    } catch (e) {
      carregando.value = false;
      onFail();
    }
  }

  void changeShowPass() {
    showPassword.value = !showPassword.value;
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CarrinhoData c in carrinho) {
      if (c.produtoData != null) if (c.produtoData.precoDesc !=
          c.produtoData.preco) {
        price += c.qtd * c.produtoData.precoDesc;
      } else {
        price += c.qtd * c.produtoData.preco;
      }
    }
    return price;
  }

  double getShipPrice() {
    double price = 0.0;
    tipoEntega.value == "Entrega agendada" ? price = 10 : price = 0;
    return price;
  }

  double getTotalPrice() {
    double price = 0.0;
    price = getProductsPrice() + getShipPrice();
    return price;
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
      DicasData dica = DicasData.fromDocument(doc);
      return dica;
    }).toList();
    dicas.value = list;
  }

  _carregarPratos() async {
    QuerySnapshot resFire =
        await FirebaseFirestore.instance.collection('pratos').get();
    List list = resFire.docs.map((DocumentSnapshot doc) {
      DicasData dica = DicasData.fromDocument(doc);
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
    carregando.value = true;
    await _auth.value.signOut();
    clienteData.value = Map();
    firebaseUser.value = null;
    carregando.value = false;

    Get.back();
    Get.offAll(() => HomeUi());
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

  Future<String> finishOrder() async {
    if (carrinho.length == 0) return null;
    carregando.value = true;

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double totalPrice = getTotalPrice();
    String pagamento = "";

    switch (formaPag.value) {
      case 1:
        pagamento = "Cart??o";
        break;
      case 2:
        pagamento = "Dinheiro";
        break;
      case 3:
        pagamento = "Pix";
        break;
      default:
        pagamento = "Dinheiro";
    }

    DocumentReference refOrder =
        await FirebaseFirestore.instance.collection("pedidos").add({
      "clientId": firebaseUser.value.uid,
      "data": Timestamp.now(),
      "formaPag": pagamento,
      "cliente": {
        "nome": clienteData['nome'] + " " + clienteData['sobrenome'],
        "endereco": clienteData['endereco'],
        "num": clienteData['num'],
        "bairro": clienteData['bairro'],
        "cidade": clienteData['cidade'],
        "cpf": clienteData['cpf'],
        "celular": clienteData['celular'],
      },
      "entrega": {
        "entregaPreco": shipPrice,
        "entregaTipo": tipoEntega.value,
        "entregaData": tipoEntega.value == "Entregar a qualquer momento"
            ? null
            : tipoEntega.value == "Retirada no mercado"
                ? null
                : DateTime(
                    diaEntrega.value.year,
                    diaEntrega.value.month,
                    diaEntrega.value.day,
                    horaEntrega.value.hour,
                    horaEntrega.value.minute),
      },
      "produtos": carrinho.map((cartProduct) => cartProduct.toMap()).toList(),
      "produtosPreco": productsPrice,
      "totalPedido": totalPrice,
      "status": 1,
    });

    await FirebaseFirestore.instance
        .collection("clientes")
        .doc(firebaseUser.value.uid)
        .collection("pedidos")
        .doc(refOrder.id)
        .set({
      "pedidoId": refOrder.id,
      "data": Timestamp.now(),
    });

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("clientes")
        .doc(firebaseUser.value.uid)
        .collection("carrinho")
        .get();

    for (DocumentSnapshot doc in query.docs) {
      doc.reference.delete();
    }

    tipoEntega.value = "Entregar a qualquer momento";
    formaPag.value = 1;

    carrinho.clear();
    carregando.value = false;
    update();

    return refOrder.id;
  }

  void redefinicaoSenha(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void login({
    @required String email,
    @required String pass,
  }) async {
    carregando.value = true;

    _auth.value
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((result) {
      firebaseUser.value = result.user;
      carregarUsuarios();

      Get.offAll(() => HomeUi());
    }).catchError((e) {
      carregando.value = false;
      Get.snackbar("Email ou Senha Incorretos ????",
          "Verifique seus dados e tente novamente!",
          backgroundColor: CupertinoColors.systemRed,
          borderRadius: 10,
          margin: EdgeInsets.all(20),
          colorText: Colors.white);
    });
  }

  RxBool verifLogado() {
    if (firebaseUser.value == null || clienteData['nome'] == null) {
      return false.obs;
    } else {
      return true.obs;
    }
  }

  Future<Null> carregarUsuarios() async {
    carregando.value = true;
    if (firebaseUser.value == null)
      firebaseUser.value = _auth.value.currentUser;
    carregarDados();
    carregando.value = false;
    if (firebaseUser.value != null) {
      if (clienteData['nome'] == null) {
        _loadCartItems();
        _carregarDicas();
        _carregarPratos();
        _carregarBanners();
        _carregarCategorias();

        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection('clientes')
            .doc(firebaseUser.value.uid)
            .get();

        clienteData.value = docUser.data();
        carregando.value = false;
      }
    }
  }

  Future<Null> carregarDados() async {
    await _carregarDicas();
    await _carregarPratos();
    await _carregarBanners();
    await _carregarCategorias();
  }
}
