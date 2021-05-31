class DicasData {
  dynamic dicasId;
  dynamic dicasTitulo;
  dynamic dicasTexto;
  dynamic dicasImg;
  dynamic dicasTempo;
  dynamic dicasKcal;

  DicasData(
      {this.dicasId,
      this.dicasTitulo,
      this.dicasTexto,
      this.dicasImg,
      this.dicasTempo,
      this.dicasKcal});

  DicasData.fromJson(Map<dynamic, dynamic> json) {
    dicasId = json['dicas_id'];
    dicasTitulo = json['dicas_titulo'];
    dicasTexto = json['dicas_texto'];
    dicasImg = json['dicas_img'];
    dicasTempo = json['dicas_tempo'];
    dicasKcal = json['dicas_kcal'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['dicas_id'] = this.dicasId;
    data['dicas_titulo'] = this.dicasTitulo;
    data['dicas_texto'] = this.dicasTexto;
    data['dicas_img'] = this.dicasImg;
    data['dicas_tempo'] = this.dicasTempo;
    data['dicas_kcal'] = this.dicasKcal;
    return data;
  }
}
