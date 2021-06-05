import 'package:superbaleia/data/produto_data.dart';

class CarrinhoData {
  dynamic cartId;
  dynamic cartQtd;
  dynamic cartProdId;
  ProdutoData produtoData;

  CarrinhoData();

  CarrinhoData.fromJson(Map<dynamic, dynamic> json) {
    cartId = json['cart_id'];
    cartQtd = json['cart_qtd'];
    cartProdId = json['cart_prodId'];
    produtoData = ProdutoData.fromJson(json);
  }

  // Map<dynamic, dynamic> toJson() {
  //   final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
  //   data['cart_id'] = this.cartId;
  //   data['cart_qtd'] = this.cartQtd;
  //   data['cart_prodId'] = this.cartProdId;
  //   // data['cart_clienteId'] = this.cartClienteId;
  //   // data['prod_id'] = this.prodId;
  //   // data['prod_titulo'] = this.prodTitulo;
  //   // data['prod_desc'] = this.prodDesc;
  //   // data['prod_img'] = this.prodImg;
  //   // data['prod_imgFit'] = this.prodImgFit;
  //   // data['prod_preco'] = this.prodPreco;
  //   // data['prod_precoDesc'] = this.prodPrecoDesc;
  //   // data['prod_ativo'] = this.prodAtivo;
  //   // data['prod_cat'] = this.prodCat;
  //   // data['prod_peso'] = this.prodPeso;
  //   // data['prod_ml'] = this.prodMl;
  //   // data['prod_marca'] = this.prodMarca;
  //   // data['prod_und'] = this.prodUnd;
  //   return data;
  // }
}
