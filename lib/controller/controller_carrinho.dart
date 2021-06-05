import 'package:get/get.dart';

class ControllerCarrinho extends GetxController {
  RxList carrinho = [].obs;

  @override
  void onInit() {
    print("CARRINHO INICIADO ✅");
    super.onInit();
  }
}
