import 'dart:convert';
import 'package:http/http.dart' as http;

String url = 'https://superbaleia.000webhostapp.com/api.php';

Future<String> login(String email, String senha) async {
  var response = await http.post(url,
      body: json.encode({
        'email': email,
        'password': senha,
      }));

  var message = jsonDecode(response.body);

  if (message[0] == 'ok') {
    return "ok";
  } else {
    return "error";
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
