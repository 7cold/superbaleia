import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:superbaleia/controller/controller.dart';

String url = 'https://superbaleia.000webhostapp.com/api.php';
String urlClientes = 'https://superbaleia.000webhostapp.com/api_clientes.php';

final Controller c = Get.put(Controller());

Future<String> login(String email, String senha) async {
  var response = await http.post(url,
      body: json.encode({
        'email': email,
        'password': senha,
      }));
  var result = jsonDecode(response.body);
  if (result[0] == 'ok') {
    c.dadosCliente.addAll(result[1]);
    c.salvarClienteId(c.dadosCliente['cliente_id']);
    return "ok";
  } else {
    return "error";
  }
}

carregarClienteAtual(String clienteId) async {
  if (c.clienteId.value != "") {
    var response = await http.post(urlClientes, body: {
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

// Future<String> cadastroCliente() async {
//   final response = await http.post(url, body: {
//     'action': 'ADD_PRODLIST',
//     'lista_userId': '1',
//     'lista_prodId': productData.prodId.toString(),
//   });

//   if (200 == response.statusCode) {
//     return response.body;
//   } else {
//     return "erro";
//   }
// }
