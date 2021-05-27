import 'dart:convert';
import 'package:http/http.dart' as http;

String url = 'https://superbaleia.000webhostapp.com/api.php';

Future<String> userLogin(String email, String senha) async {
  var response = await http.post(url,
      body: json.encode({
        'email': email,
        'password': senha,
      }));

  var message = jsonDecode(response.body);

  if (message == 'login ok') {
    return "login ok";
  } else {
    return "login error";
  }
}
