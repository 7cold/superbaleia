import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superbaleia/data/produto_data.dart';

class ControllerAdm extends GetxController {
  @override
  void onInit() {
    _carregarCatBebidas();
    _carregarCatBebidasAlcoolicas();
    super.onInit();
  }

  RxList produtos = [].obs;
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
    produtos.value = [];
    await _carregarCatBebidas();
    await _carregarCatBebidasAlcoolicas();
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
}
