import 'package:get/get.dart';
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/services/services.dart';

class ControllerCarrinho extends GetxController {
  RxList carrinho = [].obs;

  static ControllerCarrinho get to =>
      Get.put(ControllerCarrinho(), permanent: false);

  @override
  void onInit() {
    carrinho.clear();
    if (Controller.to.clienteId.value != "")
      carregarCarrinho(Controller.to.clienteId.value);
    super.onInit();
  }
}
