import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/data/produto_data.dart';

class ControllerAdm extends GetxController {
  @override
  void onInit() {
    carregarTodos();
    carregarVendas();
    carregarClientes();
    super.onInit();
  }

  RxBool carregando = false.obs;
  RxList produtos = [].obs;
  RxList pedidos = [].obs;
  RxList clientes = [].obs;
  RxString url = "".obs;
  RxDouble urlPorcentagem = 0.0.obs;
  PickedFile image;

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

  carregarVendas() async {
    QuerySnapshot resFire =
        await FirebaseFirestore.instance.collection('pedidos').get();
    resFire.docs.map((DocumentSnapshot doc) {
      PedidoData ped = PedidoData.fromDocument(doc);
      return pedidos.add(ped);
    }).toList();
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
