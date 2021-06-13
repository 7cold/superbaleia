// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:superbaleia/data/cliente_data.dart';
// import 'package:superbaleia/widgets/buttons.dart';
// import 'package:superbaleia/widgets/colors.dart';
// import 'package:superbaleia/widgets/forms.dart';
// import 'package:superbaleia/widgets/texts.dart';
// import 'package:superbaleia/widgets/validators.dart';

// class Cadastro extends StatefulWidget {
//   @override
//   _CadastroState createState() => _CadastroState();
// }

// class _CadastroState extends State<Cadastro> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   // final ClienteData clienteData = ClienteData();

//   var _cidades = ['Ouro Fino', 'Jacutinga', 'Borda da Mata'];
//   var cidadeSelecionada = 'Ouro Fino';

//   // ignore: unused_element
//   _erroSenha() {
//     return showDialog(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Erro de Senha',
//             style: TextStyle(color: Colors.blue),
//           ),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('As senhas não coincidem, verifique e tente novamente.')
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Entendi'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Color(corBack),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Container(
//           padding: EdgeInsets.only(top: 70),
//           child: Center(
//             child: Column(
//               children: [
//                 Container(
//                   child: Column(
//                     children: [
//                       Text(
//                         "Cadastro",
//                         style: textHeavy(
//                           36,
//                           corBackDark,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Por favor preencha os campos abaixo",
//                         style: textHeavy(
//                           12,
//                           corGrey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Form(
//                   key: formKey,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 20, right: 20, top: 70, bottom: 15),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(8)),
//                             border: Border.all(
//                               color: Colors.grey[350],
//                               width: 2,
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               SizedBox(width: 10),
//                               Text(
//                                 'Cidade:',
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               dropDown(
//                                   cidadeSelecionada, _cidades, clienteData),
//                             ],
//                           ),
//                         ),
//                       ),
//                       BaleiaForms.textFormFieldCad(
//                         "Nome Completo",
//                         clienteData,
//                         (nome) => clienteData.clienteNome = nome,
//                         valNome,
//                         TextInputType.name,
//                         false,
//                       ),
//                       BaleiaForms.textFormFieldCad(
//                         "Endereço",
//                         clienteData,
//                         (endereco) => clienteData.clienteEnd = endereco,
//                         valEnd,
//                         TextInputType.name,
//                         false,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             width: 120,
//                             child: BaleiaForms.textFormFieldCad(
//                               "N°",
//                               clienteData,
//                               (nume) => clienteData.clienteEndNum = nume,
//                               valNum,
//                               TextInputType.number,
//                               false,
//                             ),
//                           ),
//                           Container(
//                             width: 240,
//                             child: BaleiaForms.textFormFieldCad(
//                               "Complemento",
//                               clienteData,
//                               (comp) => clienteData.clienteObs = comp,
//                               valPadrao,
//                               TextInputType.name,
//                               false,
//                             ),
//                           )
//                         ],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: 20,
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 45,
//                               width: 60,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 image: DecorationImage(
//                                     image:
//                                         AssetImage('assets/images/brasil.png'),
//                                     fit: BoxFit.cover),
//                               ),
//                             ),
//                             Container(
//                               width: 280,
//                               child: BaleiaForms.textFormFieldCad(
//                                 "Telefone (35) 92222-3333",
//                                 clienteData,
//                                 (telefone) => clienteData.clienteCel = telefone,
//                                 valTelefone,
//                                 TextInputType.number,
//                                 false,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       BaleiaForms.textFormFieldCad(
//                         "E-mail",
//                         clienteData,
//                         (email) => clienteData.clienteEmail = email,
//                         valEmail,
//                         TextInputType.emailAddress,
//                         false,
//                       ),
//                       BaleiaForms.textFormFieldCad(
//                         "Senha",
//                         clienteData,
//                         (senha) => clienteData.clienteSenha = senha,
//                         valSenha,
//                         TextInputType.emailAddress,
//                         true,
//                       ),
//                       // BaleiaForms.textFormFieldCad(
//                       //   "Confirmar senha",
//                       //   clienteData,
//                       //   (confirmaSenha) =>
//                       //       clienteData.clienteConfirmaSenha = confirmaSenha,
//                       //   valConfirmSenha,
//                       //   TextInputType.emailAddress,
//                       //   true,
//                       // ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 BaleiaButtons.buttonPrimary(
//                   "Cadastrar",
//                   Get.width,
//                   43,
//                   () async {
//                     // if (formKey.currentState.validate()) {
//                     //   formKey.currentState.save();
//                     //   if (clienteData.clienteSenha.toString() ==
//                     //       clienteData.clienteConfirmaSenha) {
//                     //     //função enviar cadastro para o banco
//                     //     print(clienteData.clienteCidade);
//                     //     print(clienteData.clienteNome);
//                     //     print(clienteData.clienteEnd);
//                     //     print(clienteData.clienteEndNum);
//                     //     print(clienteData.clienteObs);
//                     //     print(clienteData.clienteCel);
//                     //     print(clienteData.clienteEmail);
//                     //     print(clienteData.clienteSenha);
//                     //   } else {
//                     //     _erroSenha();
//                     //   }
//                     // } else {
//                     //   print('erro');
//                     // }
//                   },
//                 ),
//                 SizedBox(height: 50),
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }

//   DropdownButtonHideUnderline dropDown(String cidadeSelecionada,
//       List<String> _cidades, ClienteData clienteData) {
//     return DropdownButtonHideUnderline(
//       child: FormField<String>(
//         builder: (FormFieldState<String> state) {
//           return Expanded(
//             child: DropdownButton(
//               dropdownColor: Color(corBack),
//               style: TextStyle(
//                 fontSize: 17,
//                 color: Colors.black54,
//               ),
//               value: cidadeSelecionada,
//               items: _cidades.map((String dropDrownStringItem) {
//                 return DropdownMenuItem<String>(
//                   value: dropDrownStringItem,
//                   child: Text(dropDrownStringItem),
//                 );
//               }).toList(),
//               onChanged: (String novaCidade) {
//                 cidadeSelecionada = novaCidade;
//                 setState(() {
//                   this.cidadeSelecionada = novaCidade;
//                 });
//               },
//             ),
//           );
//         },
//         onSaved: (cidade) => clienteData.clienteCidade = cidadeSelecionada,
//       ),
//     );
//   }
// }
