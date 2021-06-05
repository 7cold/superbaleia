import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:superbaleia/services/services.dart';
import 'package:superbaleia/telas/home.dart';
import 'package:superbaleia/telas/login.dart';

class Controller extends GetxController {
  @override
  onInit() async {
    await carregarCategorias();
    await carregarDicas();
    await carregarBanners();
    await carregarClienteId();
    await carregarClienteAtual(clienteId.value);
    if (clienteId.value != "") await carregarCarrinho(clienteId.value);
    super.onInit();
  }

  RxString idCat = "".obs;
  RxMap dadosCliente = {}.obs;
  RxList categorias = [].obs;
  RxList banners = [].obs;
  RxList dicas = [].obs;
  RxString clienteId = "".obs;
  RxBool showPassword = true.obs;
  RxBool carregando = false.obs;
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
    cart.carrinho.clear();
    Get.offAll(() => LoginUi());
  }
}
