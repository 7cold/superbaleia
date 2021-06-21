//------------ Validators ------------------------

String valNome(nome) {
  if (nome.isEmpty) {
    return 'Campo Obrigatório';
  } else if (nome.trim().split(' ').length <= 1) {
    return 'Preencha nome completo';
  } else {
    return null;
  }
}

String valEnd(endereco) {
  if (endereco.isEmpty) {
    return 'Campo Obrigatório';
  } else if (endereco.trim().split(' ').length <= 1) {
    return 'Preencha o endereço completo';
  } else {
    return null;
  }
}

String valNum(nume) {
  if (nume.isEmpty) {
    return 'Campo Obrigatório';
  } else {
    return null;
  }
}

String valPadrao(comp) {
  return null;
}

String valTelefone(telefone) {
  if (telefone.isEmpty) {
    return 'Campo Obrigatório';
  } else if (telefone.length != 15) {
    return 'Telefone inválido';
  } else {
    return null;
  }
}

String valCpf(telefone) {
  if (telefone.isEmpty) {
    return 'Campo Obrigatório';
  } else if (telefone.length != 14) {
    return 'CPF inválido';
  } else {
    return null;
  }
}

bool emailValidacao(String email) {
  RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{ 1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[A-zA-Z]{2,}))$");
  return regex.hasMatch(email);
}

String valEmail(email) {
  if (!emailValidacao(email)) return 'E-mail inválido';
  return null;
}

String valSenha(senha) {
  if (senha.isEmpty || senha.length < 6) return 'Senha de no mínimo 6 dígitos';
  return null;
}

String valConfirmSenha(confirmaSenha) {
  if (confirmaSenha.isEmpty || confirmaSenha.length < 6)
    return 'Senha de no mínimo 6 dígitos';
  return null;
}
