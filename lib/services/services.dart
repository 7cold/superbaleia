import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:superbaleia/controller/controller.dart';

String url = 'https://superbaleia.000webhostapp.com/api.php';
String urlClientes = 'https://superbaleia.000webhostapp.com/api_clientes.php';

final Controller c = Get.put(Controller());

Future<String> login(String email, String senha) async {
  c.carregando.value = true;
  var response = await http.post(Uri.parse(url),
      body: json.encode({
        'email': email,
        'password': senha,
      }));
  var result = jsonDecode(response.body);
  if (result[0] == 'ok') {
    c.dadosCliente.addAll(result[1]);
    c.salvarClienteId(c.dadosCliente['cliente_id']);
    c.carregando.value = false;
    return "ok";
  } else {
    c.carregando.value = false;
    return "error";
  }
}

carregarClienteAtual(String clienteId) async {
  if (c.clienteId.value != "") {
    var response = await http.post(Uri.parse(urlClientes), body: {
      'action': 'carregarClienteAtual',
      'cliente_id': clienteId ?? '',
    });
    var result = jsonDecode(response.body);
    c.dadosCliente.addAll(result[0]);
    print("usuario logado: " + c.dadosCliente['cliente_email']);
  } else {
    print("nenhum cliente logado!");
  }
}

carregarCategorias() async {
  var response = await http
      .post(Uri.parse(urlClientes), body: {'action': 'carregarCategorias'});
  var res = json.decode(response.body);
  c.categorias.value = res;
}

carregarBanners() async {
  var response = await http
      .post(Uri.parse(urlClientes), body: {'action': 'carregarBanners'});
  var res = json.decode(response.body);
  c.banners.value = res;
}

carregarDicas() async {
  var response = await http
      .post(Uri.parse(urlClientes), body: {'action': 'carregarDicas'});
  var res = json.decode(response.body);
  c.dicas.value = res;
}

Future carregarProdutos(String catId) async {
  var response = await http.post(Uri.parse(urlClientes),
      body: {'action': 'carregarProdutos', 'cat_id': catId});
  return response;
}
