import 'dart:convert';
import 'package:get/get.dart';
import 'package:superbaleia/services/services.dart';

class ControllerProd extends GetxController {
  RxList produtos = [].obs;

  @override
  void onInit() async {
    c.carregando.value = true;
    await carregarProdutos(c.idCat.value).then((response) {
      refresh();
      return produtos.value = json.decode(response.body);
    });
    c.carregando.value = false;
    super.onInit();
  }
}
