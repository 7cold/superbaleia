class ProdutoData {
  dynamic prodId;
  dynamic prodTitulo;
  dynamic prodDesc;
  dynamic prodImg;
  dynamic prodPreco;
  dynamic prodPrecoDesc;
  dynamic prodAtivo;
  dynamic prodCat;
  dynamic prodPeso;
  dynamic prodMl;
  dynamic prodMarca;
  dynamic prodUnd;
  dynamic prodImgFit;

  ProdutoData({
    this.prodId,
    this.prodTitulo,
    this.prodDesc,
    this.prodImg,
    this.prodPreco,
    this.prodPrecoDesc,
    this.prodAtivo,
    this.prodCat,
    this.prodPeso,
    this.prodMl,
    this.prodMarca,
    this.prodUnd,
    this.prodImgFit,
  });

  ProdutoData.fromJson(Map<dynamic, dynamic> json) {
    prodId = json['prod_id'];
    prodTitulo = json['prod_titulo'];
    prodDesc = json['prod_desc'];
    prodImg = json['prod_img'];
    prodPreco = json['prod_preco'];
    prodPrecoDesc = json['prod_precoDesc'];
    prodAtivo = json['prod_ativo'];
    prodCat = json['prod_cat'];
    prodPeso = json['prod_peso'];
    prodMl = json['prod_ml'];
    prodMarca = json['prod_marca'];
    prodUnd = json['prod_und'];
    prodImgFit = json['prod_imgFit'];
  }

  Map<String, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['prod_id'] = this.prodId;
    data['prod_titulo'] = this.prodTitulo;
    data['prod_desc'] = this.prodDesc;
    data['prod_img'] = this.prodImg;
    data['prod_preco'] = this.prodPreco;
    data['prod_precoDesc'] = this.prodPrecoDesc;
    data['prod_ativo'] = this.prodAtivo;
    data['prod_cat'] = this.prodCat;
    data['prod_peso'] = this.prodPeso;
    data['prod_ml'] = this.prodMl;
    data['prod_marca'] = this.prodMarca;
    data['prod_und'] = this.prodUnd;
    data['prod_imgFit'] = this.prodImgFit;
    return data;
  }
}
