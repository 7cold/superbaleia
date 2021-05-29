class ClienteData {
  String clienteId;
  String clienteEmail;
  String clienteSenha;
  String clienteNome;
  String clienteCel;
  String clienteEnd;
  String clienteEndNum;
  String clienteObs;

  ClienteData(
      {this.clienteId,
      this.clienteEmail,
      this.clienteSenha,
      this.clienteNome,
      this.clienteCel,
      this.clienteEnd,
      this.clienteEndNum,
      this.clienteObs});

  ClienteData.fromJson(Map<dynamic, dynamic> json) {
    clienteId = json['cliente_id'];
    clienteEmail = json['cliente_email'];
    clienteSenha = json['cliente_senha'];
    clienteNome = json['cliente_nome'];
    clienteCel = json['cliente_cel'];
    clienteEnd = json['cliente_end'];
    clienteEndNum = json['cliente_endNum'];
    clienteObs = json['cliente_obs'];
  }

  Map<String, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['cliente_id'] = this.clienteId;
    data['cliente_email'] = this.clienteEmail;
    data['cliente_senha'] = this.clienteSenha;
    data['cliente_nome'] = this.clienteNome;
    data['cliente_cel'] = this.clienteCel;
    data['cliente_end'] = this.clienteEnd;
    data['cliente_endNum'] = this.clienteEndNum;
    data['cliente_obs'] = this.clienteObs;
    return data;
  }
}
