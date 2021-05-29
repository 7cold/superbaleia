import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:superbaleia/services/services.dart';
import 'package:superbaleia/telas/home.dart';
import 'package:superbaleia/telas/login.dart';

class Controller extends GetxController {
  @override
  onInit() async {
    await carregarClienteId();
    await carregarClienteAtual(clienteId.value);
    super.onInit();
  }

  RxMap dadosCliente = {}.obs;
  RxString clienteId = "".obs;
  RxBool showPassword = true.obs;
  final getStorage = GetStorage().obs;

  funcShowPassword() {
    showPassword.value = !showPassword.value;
  }

  salvarClienteId(String clienteId) {
    getStorage.value.write("cliente_id", clienteId);
    Get.offAll(() => HomeUi());
  }

  carregarClienteId() {
    clienteId.value = getStorage.value.read('cliente_id') ?? "";
  }

  logoutCliente() {
    getStorage.value.remove('cliente_id');
    dadosCliente.value = {};
    Get.offAll(() => LoginUi());
  }
}