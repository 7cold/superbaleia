import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:superbaleia/controller/controller.dart';
import 'package:superbaleia/controller/controller_carrinho.dart';
import 'package:superbaleia/data/carrinho_data.dart';

String url = 'https://superbaleia.000webhostapp.com/api.php';
String urlClientes = 'https://superbaleia.000webhostapp.com/api_clientes.php';

final Controller c = Get.find();

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

carregarDicas() async {
  var response = await http
      .post(Uri.parse(urlClientes), body: {'action': 'carregarDicas'});
  var res = json.decode(response.body);
  c.dicas.value = res;
}

carregarBanners() async {
  var response = await http
      .post(Uri.parse(urlClientes), body: {'action': 'carregarBanners'});
  var res = json.decode(response.body);
  c.banners.value = res;
}

Future carregarProdutos(String catId) async {
  var response = await http.post(Uri.parse(urlClientes),
      body: {'action': 'carregarProdutos', 'cat_id': catId});
  return response;
}

carregarCarrinho(String clienteId) async {
  var response = await http.post(Uri.parse(urlClientes),
      body: {'action': 'carregarCarrinho', 'cliente_id': clienteId});
  Iterable res = json.decode(response.body);
  List list = res.map((e) => CarrinhoData.fromJson(e)).toList();

  ControllerCarrinho.to.totalCompra.value = 0.0;

  for (CarrinhoData c in list) {
    if (c.produtoData.prodPreco != null) {
      if (c.produtoData.prodPrecoDesc != null) {
        ControllerCarrinho.to.totalCompra.value +=
            int.parse(c.cartQtd) * double.parse(c.produtoData.prodPrecoDesc);
      } else {
        ControllerCarrinho.to.totalCompra.value +=
            int.parse(c.cartQtd) * double.parse(c.produtoData.prodPreco);
      }
    }
  }

  ControllerCarrinho.to.carrinho.addAll(list);
}

Future<String> addProdCarrinho(String clienteId, String prodId) async {
  var response = await http.post(Uri.parse(urlClientes), body: {
    'action': 'addProdCarrinho',
    'cliente_id': clienteId,
    'prod_id': prodId
  });
  if (response.body == "ok") {
    return "ok";
  } else {
    return "error";
  }
}

Future<String> delProdCarrinho(String cartId) async {
  c.carregando.value = true;
  var response = await http.post(Uri.parse(urlClientes),
      body: {'action': 'delProdCarrinho', 'cart_id': cartId});
  if (response.body == "ok") {
    c.carregando.value = false;
    return "ok";
  } else {
    c.carregando.value = false;
    return "error";
  }
}

Future<String> addQtdCarrinho(String cartId, String cartQtd) async {
  c.carregando.value = true;
  var response = await http.post(Uri.parse(urlClientes), body: {
    'action': 'addQtdCarrinho',
    'cart_id': cartId,
    'cart_qtd': cartQtd
  });
  c.carregando.value = false;
  if (response.body == "ok") {
    return "ok";
  } else {
    return "error";
  }
}

Future<String> remQtdCarrinho(String cartId, String cartQtd) async {
  c.carregando.value = true;
  var response = await http.post(Uri.parse(urlClientes), body: {
    'action': 'remQtdCarrinho',
    'cart_id': cartId,
    'cart_qtd': cartQtd
  });
  c.carregando.value = false;
  if (response.body == "ok") {
    return "ok";
  } else {
    return "error";
  }
}
