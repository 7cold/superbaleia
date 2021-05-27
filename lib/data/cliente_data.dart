class ClienteData {
  String clienteId;
  String clienteEmail;
  String clienteSenha;

  ClienteData({
    this.clienteId,
    this.clienteEmail,
    this.clienteSenha,
  });

  factory ClienteData.fromJson(Map<dynamic, dynamic> json) {
    return ClienteData(
      clienteId: json['cliente_id'],
      clienteEmail: json['cliente_email'],
      clienteSenha: json['cliente_senha'],
    );
  }
}
