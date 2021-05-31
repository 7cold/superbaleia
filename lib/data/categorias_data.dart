class CategoriasData {
  dynamic catId;
  dynamic catNome;
  dynamic catCor;
  dynamic catImagem;

  CategoriasData({this.catId, this.catNome, this.catCor, this.catImagem});

  CategoriasData.fromJson(Map<dynamic, dynamic> json) {
    catId = json['cat_id'];
    catNome = json['cat_nome'];
    catCor = int.parse(json['cat_cor']);
    catImagem = json['cat_imagem'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_nome'] = this.catNome;
    data['cat_cor'] = this.catCor;
    data['cat_imagem'] = this.catImagem;
    return data;
  }
}
