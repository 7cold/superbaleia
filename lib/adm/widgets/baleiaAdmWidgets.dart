import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/adm/pedidos/pedidos_detalhes_adm.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/data/cliente_data.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/colors.dart';
import 'package:superbaleia/widgets/extras.dart';
import 'package:superbaleia/widgets/texts.dart';
import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,##0.00", "pt_BR");
final ControllerAdm c = Get.find();

class BaleiaAdm {
  static Widget produtosItens(ProdutoData prod) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          hoverColor: Color(corPri).withAlpha(50),
          highlightColor: Color(corBack).withAlpha(10),
          splashColor: Colors.transparent,
          onTap: () {
            Get.defaultDialog(
              title: "Resumo",
              radius: 8,
              titleStyle: textBold(16, corBackDark),
              content: Container(child: prodDetalhesAlert(prod)),
              middleText: "",
            );
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            width: Get.context.width,
            child: ResponsiveGridRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveGridCol(
                  lg: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "#" + prod.id.substring(0, 6),
                      style: textLight(16, corGrey),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  lg: c.getNivelUser() == "func" ? 3 : 2,
                  child: Text(
                    prod.titulo,
                    style: textRegular(16, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                  lg: c.getNivelUser() == "func" ? 3 : 2,
                  child: Text(
                    prod.marca,
                    style: textRegular(16, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                    lg: 1, child: returnCategoria(prod.categoria)),
                ResponsiveGridCol(
                  lg: 1,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: prod.ativo == true
                            ? CupertinoColors.activeGreen
                            : CupertinoColors.systemRed,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Text(
                        prod.ativo == true ? "Ativo" : "Desabilitado",
                        style: textRegular(14, corBack),
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 1,
                  child: Center(
                    child: Text(
                      "R\$ " + formatter.format(prod.preco),
                      style: textRegular(16, corGreen),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 1,
                  child: prod.precoDesc != prod.preco
                      ? Text(
                          "R\$ " + formatter.format(prod.precoDesc),
                          style: textRegular(16, corOrange),
                        )
                      : Text(
                          "-",
                          style: textRegular(16, corOrange),
                        ),
                ),
                c.getNivelUser() == "func"
                    ? ResponsiveGridCol(child: SizedBox())
                    : ResponsiveGridCol(
                        lg: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Deseja Remover",
                                  middleText: "",
                                  confirm: CupertinoButton(
                                      color: CupertinoColors.systemRed,
                                      child: Text("Sim"),
                                      onPressed: () {
                                        c.deleteProduto(prod);
                                        c.produtos.remove(prod);
                                        Get.back();
                                      }),
                                  cancel: CupertinoButton(
                                    child: Text(
                                      "Não",
                                      style: TextStyle(
                                          color: CupertinoColors.systemGrey),
                                    ),
                                    onPressed: () => Get.back(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.delete_outline_rounded,
                                  color: Color(corGrey)),
                            ),
                            SizedBox(width: 15),
                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Resumo",
                                  radius: 8,
                                  titleStyle: textBold(16, corBackDark),
                                  content:
                                      Container(child: prodDetalhesAlert(prod)),
                                  middleText: "",
                                );
                              },
                              icon: Icon(Icons.remove_red_eye_outlined,
                                  color: Color(corGrey)),
                            ),
                            SizedBox(width: 15),
                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  radius: 8,
                                  title: "Editar",
                                  titleStyle: textBold(20, corBackDark),
                                  content: Container(
                                      width: 400, child: prodEditarAlert(prod)),
                                  middleText: "",
                                );
                              },
                              icon: Icon(Icons.edit_outlined,
                                  color: Color(corGrey)),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget prodEditarAlert(ProdutoData prod) {
    TextEditingController tituloEdit = TextEditingController();
    TextEditingController marcaEdit = TextEditingController();
    TextEditingController precoEdit = TextEditingController();
    TextEditingController precoDescEdit = TextEditingController();
    RxString unidadeMedEdit = "".obs;
    RxList especEdit = [].obs;
    List<Map> especBackEdit = [];
    RxBool ativoEdit = false.obs;
    RxBool descontoEdit = false.obs;

    tituloEdit.text = prod.titulo;
    marcaEdit.text = prod.marca;
    precoEdit.text = formatter.format(prod.preco);
    precoDescEdit.text = formatter.format(prod.precoDesc);
    unidadeMedEdit.value = prod.unidadeMed;
    especEdit.value = prod.espec;
    ativoEdit.value = prod.ativo;
    prod.preco == prod.precoDesc
        ? descontoEdit.value = false
        : descontoEdit.value = true;

    prod.espec.forEach((e) => especBackEdit.add(e));

    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Título", style: textLight(14, corGrey)),
              CupertinoTextField(controller: tituloEdit),
              SizedBox(height: 10),
              Text("Marca", style: textLight(14, corGrey)),
              CupertinoTextField(controller: marcaEdit),
              SizedBox(height: 10),
              Text("Unidade de Medida", style: textLight(14, corGrey)),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    height: 30,
                    child: CupertinoButton(
                        disabledColor: Color(corPri),
                        color: CupertinoColors.systemGrey3,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Unit.", style: textRegular(14, corBack)),
                        onPressed: unidadeMedEdit.value == "unitario"
                            ? null
                            : () {
                                unidadeMedEdit.value = "unitario";
                              }),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 30,
                    child: CupertinoButton(
                        disabledColor: Color(corPri),
                        color: CupertinoColors.systemGrey3,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child:
                            Text("Por Peso", style: textRegular(14, corBack)),
                        onPressed: unidadeMedEdit.value == "por peso"
                            ? null
                            : () {
                                unidadeMedEdit.value = "por peso";
                              }),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 30,
                    child: CupertinoButton(
                        disabledColor: Color(corPri),
                        color: CupertinoColors.systemGrey3,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child:
                            Text("Por Capac.", style: textRegular(14, corBack)),
                        onPressed: unidadeMedEdit.value == "por capacidade"
                            ? null
                            : () {
                                unidadeMedEdit.value = "por capacidade";
                              }),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ResponsiveGridRow(
                children: [
                  ResponsiveGridCol(
                    xl: 5,
                    lg: 5,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Preço", style: textLight(14, corGrey)),
                          CupertinoTextField(
                            controller: precoEdit,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              RealInputFormatter(centavos: true, moeda: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xl: 2,
                    lg: 2,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Desc.", style: textLight(14, corGrey)),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                                activeColor: Color(corPri),
                                value: descontoEdit.value,
                                onChanged: (_) {
                                  descontoEdit.value = _;
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xl: 5,
                    lg: 5,
                    child: descontoEdit.value == false
                        ? SizedBox()
                        : Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Preço Desconto",
                                    style: textLight(14, corGrey)),
                                CupertinoTextField(
                                  controller: precoDescEdit,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    RealInputFormatter(
                                        centavos: true, moeda: true),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text("Especificação", style: textLight(14, corGrey)),
              SizedBox(height: 10),
              SizedBox(
                height: 30,
                child: CupertinoButton(
                    color: Color(corPri),
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline_rounded,
                            color: Color(corBack)),
                        SizedBox(width: 10),
                        Text("Adicionar", style: textRegular(14, corBack)),
                      ],
                    ),
                    onPressed: () {
                      especEdit.add({"espec": "", "valor": ""});
                    }),
              ),
              SizedBox(height: 10),
              Column(
                children: especEdit.map((e) {
                  ProdEscpec espec = ProdEscpec.fromList(e);
                  return ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(
                        xl: 6,
                        lg: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: CupertinoTextField(
                            controller:
                                TextEditingController(text: espec.espec),
                            onChanged: (_) {
                              e['espec'] = _.capitalize;
                            },
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        xl: 4,
                        lg: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: CupertinoTextField(
                            controller:
                                TextEditingController(text: espec.valor),
                            onChanged: (_) {
                              e['valor'] = _.capitalize;
                            },
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        xl: 2,
                        lg: 2,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5, top: 5),
                            child: IconButton(
                                color: CupertinoColors.systemGrey,
                                onPressed: () {
                                  especEdit.remove(e);
                                },
                                icon:
                                    Icon(Icons.remove_circle_outline_rounded))),
                      ),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Text("Ativo", style: textLight(14, corGrey)),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                    activeColor: Color(corPri),
                    value: ativoEdit.value,
                    onChanged: (_) {
                      ativoEdit.value = _;
                    }),
              ),
              SizedBox(height: 30),
              ResponsiveGridRow(children: [
                ResponsiveGridCol(
                  lg: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      height: 35,
                      child: CupertinoButton(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          color: CupertinoColors.systemGrey3,
                          child: Text(
                            "Cancelar",
                            style: textRegular(14, corBack),
                          ),
                          onPressed: () {
                            Get.back();
                            especEdit.value = especBackEdit;
                            prod.espec = especBackEdit;
                            unidadeMedEdit.value = prod.unidadeMed;
                            ativoEdit.value = prod.ativo;
                          }),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 35,
                      child: CupertinoButton(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          color: CupertinoColors.activeGreen,
                          child: Text(
                            "Salvar",
                            style: textRegular(14, corBack),
                          ),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("produtos")
                                .doc(prod.categoria)
                                .collection("itens")
                                .doc(prod.id)
                                .update({
                              "marca": marcaEdit.text.capitalize,
                              "titulo": tituloEdit.text.capitalize,
                              "preco": double.parse(precoEdit.text
                                  .replaceAll("R\$ ", "")
                                  .replaceAll(",", ".")),
                              "precoDesc": descontoEdit.value == true
                                  ? double.parse(precoDescEdit.text
                                      .replaceAll("R\$ ", "")
                                      .replaceAll(",", "."))
                                  : double.parse(precoEdit.text
                                      .replaceAll("R\$ ", "")
                                      .replaceAll(",", ".")),
                              "ativo": ativoEdit.value,
                              "unidadeMed": unidadeMedEdit.value,
                              "espec": especEdit,
                            });
                            prod.ativo = ativoEdit.value;
                            prod.titulo = tituloEdit.text.capitalize;
                            prod.marca = marcaEdit.text.capitalize;
                            prod.preco = double.parse(
                                UtilBrasilFields.removerSimboloMoeda(precoEdit
                                    .text
                                    .replaceAll("R\$ ", "")
                                    .replaceAll(",", ".")));

                            descontoEdit.value == true
                                ? prod.precoDesc = double.parse(
                                    UtilBrasilFields.removerSimboloMoeda(
                                        precoDescEdit.text
                                            .replaceAll("R\$ ", "")
                                            .replaceAll(",", ".")))
                                : prod.precoDesc = double.parse(
                                    UtilBrasilFields.removerSimboloMoeda(
                                        precoEdit.text
                                            .replaceAll("R\$ ", "")
                                            .replaceAll(",", ".")));
                            prod.unidadeMed = unidadeMedEdit.value;
                            prod.espec = especEdit;
                            c.produtos.refresh();
                            Get.back();
                          }),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  static Widget pedidoProdDetalhes(ProdutoData prod, CarrinhoData ped) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(10),
          shadowColor: Colors.white.withAlpha(50),
          color: Colors.white,
          elevation: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            hoverColor: Color(corPri).withAlpha(20),
            highlightColor: Color(corBack).withAlpha(10),
            splashColor: Colors.transparent,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: Get.context.width,
              child: ResponsiveGridRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ResponsiveGridCol(
                  //   lg: 1,
                  //   child: Container(
                  //     height: 30,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //       image: DecorationImage(
                  //         image: NetworkImage(prod.img),
                  //         fit: BoxFit.contain,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  ResponsiveGridCol(
                    lg: 2,
                    child: Text(
                      "#" + ped.produtoId.substring(0, 6),
                      style: textRegular(16, corBackDark),
                    ),
                  ),

                  ResponsiveGridCol(
                    lg: 3,
                    child: Text(
                      prod.titulo,
                      style: textRegular(16, corBackDark),
                    ),
                  ),
                  ResponsiveGridCol(
                    lg: 2,
                    child: Text(
                      prod.marca,
                      style: textRegular(16, corBackDark),
                    ),
                  ),
                  ResponsiveGridCol(
                    lg: 2,
                    child: Text(
                      ped.categoria.capitalize,
                      style: textRegular(16, corBackDark),
                    ),
                  ),
                  ResponsiveGridCol(
                      lg: 1,
                      child: Center(
                        child: Text(
                          "R\$ " +
                              formatter.format(prod.precoDesc != prod.preco
                                  ? prod.precoDesc
                                  : prod.preco),
                          style: textRegular(16, corBackDark),
                        ),
                      )),
                  ResponsiveGridCol(
                    lg: 1,
                    child: Text(
                      ped.qtd.toString() + "x",
                      style: textRegular(16, corBackDark),
                    ),
                  ),
                  ResponsiveGridCol(
                    lg: 1,
                    child: Center(
                      child: Text(
                        "R\$ " +
                            formatter.format(prod.precoDesc != prod.preco
                                ? prod.precoDesc * ped.qtd
                                : prod.preco * ped.qtd),
                        style: textRegular(16, corBackDark),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider()
      ],
    );
  }

  static Widget prodDetalhesAlert(ProdutoData prod) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 90,
                  child: Image.network(prod.img))),
          SizedBox(height: 10),
          Text("Título", style: textLight(14, corGrey)),
          Text(prod.titulo, style: textBold(16, corBackDark)),
          SizedBox(height: 10),
          Text("Marca", style: textLight(14, corGrey)),
          Text(prod.marca, style: textBold(16, corBackDark)),
          SizedBox(height: 10),
          Text("Unidade de Medida", style: textLight(14, corGrey)),
          Text(
              prod.unidadeMed == "unitario"
                  ? "Unitário"
                  : prod.unidadeMed == "por peso"
                      ? "Por peso"
                      : "Por capacidade",
              style: textBold(16, corBackDark)),
          SizedBox(height: 10),
          Text("Especificação", style: textLight(14, corGrey)),
          Column(
            children: prod.espec.map((e) {
              ProdEscpec espec = ProdEscpec.fromList(e);
              return Row(
                children: [
                  Text(espec.espec.toString() + ": ",
                      style: textSemiBold(16, corBackDark)),
                  Text(espec.valor.toString(),
                      style: textRegular(16, corBackDark)),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Text("Ativo", style: textLight(14, corGrey)),
          Text(prod.ativo == true ? "Sim" : "Não",
              style: textBold(16, corBackDark)),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  static Widget appBar(String title, List<Widget> actions) => AppBar(
        elevation: 5,
        shadowColor: Colors.white.withOpacity(0.2),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: actions,
        title: Text(
          title.toString(),
          style: textSemiBold(20, corBackDark),
        ),
        iconTheme: IconThemeData(
          color: Color(corBackDark),
        ),
      );

  static Widget vendasItens(PedidoData ped) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          hoverColor: Color(corPri).withAlpha(30),
          highlightColor: Color(corBack).withAlpha(10),
          splashColor: Colors.transparent,
          onTap: () {
            Get.to(() => PedidosDetalhesAdm(
                  ped: ped,
                ));
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            width: Get.context.width,
            child: ResponsiveGridRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveGridCol(
                  lg: 1,
                  child: Center(
                    child: Text(
                      "#" + ped.id.substring(0, 6),
                      style: textRegular(14, corGrey),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 3,
                  child: Tooltip(
                    padding: EdgeInsets.all(8),
                    message: ped.cliente['endereco'] +
                        " - " +
                        ped.cliente['num'] +
                        "\n" +
                        ped.cliente['bairro'] +
                        " - " +
                        ped.cliente['cidade'],
                    child: Text(
                      ped.cliente['nome'],
                      style: textRegular(14, corBackDark),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 2,
                  child: Text(
                    ped.produtos.length == 1
                        ? ped.produtos.length.toString() + " Item"
                        : ped.produtos.length.toString() + " Itens",
                    style: textRegular(14, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 2,
                  child: Text(
                    DateFormat('dd/MM/yy - HH:mm - EEE', "pt_BR").format(
                        DateTime.fromMicrosecondsSinceEpoch(
                            ped.data.microsecondsSinceEpoch)),
                    style: textRegular(14, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 1,
                  child: Row(
                    children: [
                      Icon(
                        ped.formaPag == "Cartão"
                            ? Icons.credit_card_rounded
                            : ped.formaPag == "Pix"
                                ? Icons.transform_rounded
                                : Icons.monetization_on_outlined,
                        size: 16,
                        color: ped.formaPag == "Cartão"
                            ? Colors.orange[800]
                            : ped.formaPag == "Pix"
                                ? Colors.blue
                                : Colors.green[600],
                      ),
                      SizedBox(width: 10),
                      Text(
                        ped.formaPag,
                        style: textRegular(14, corBackDark),
                      ),
                    ],
                  ),
                ),
                ResponsiveGridCol(
                  lg: 2,
                  child: Center(
                    child: Text(
                      "R\$ " + formatter.format(ped.totalPedido),
                      style: textRegular(14, corGreen),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 1,
                  child:
                      Center(child: BaleiaExtras.widgetEntrega(ped.status, 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget clienteItens(ClienteData cliente) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.white.withAlpha(50),
        color: Colors.white,
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          hoverColor: Color(corPri).withAlpha(50),
          highlightColor: Color(corBack).withAlpha(10),
          splashColor: Colors.transparent,
          onTap: () {
            // Get.to(() => PedidosDetalhesAdm(
            //       ped: ped,
            //     ));
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            width: Get.context.width,
            child: ResponsiveGridRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveGridCol(
                  lg: 1,
                  child: Text(
                    "#" + cliente.id.substring(0, 6),
                    style: textRegular(14, corGrey),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 2,
                  child: Text(
                    cliente.nome + " " + cliente.sobrenome,
                    style: textRegular(14, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 2,
                  child: Text(
                    cliente.cpf,
                    style: textRegular(14, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 2,
                  child: Text(
                    cliente.celular,
                    style: textRegular(14, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 2,
                  child: Text(
                    cliente.email,
                    style: textRegular(14, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 1,
                  child: Text(
                    cliente.cidade,
                    style: textRegular(14, corBackDark),
                  ),
                ),
                ResponsiveGridCol(
                  lg: 2,
                  child: Text(
                    cliente.endereco +
                        ", " +
                        cliente.numero.toString() +
                        " - " +
                        cliente.bairro,
                    style: textRegular(14, corBackDark),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget returnCategoria(String categoria) {
    Widget itemCategoria(cat, color) {
      return Container(
        margin: EdgeInsets.only(right: 25),
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Color(color)),
        child: Center(
          child: Text(
            categoria.capitalizeFirst,
            style: textRegular(14, corBack),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    switch (categoria) {
      case "bebidas":
        return itemCategoria(categoria, 0XFF0d47a1);
        break;
      case "bebidas alcoolicas":
        return itemCategoria(categoria, 0XFF0277bd);
        break;
      case "carnes e peixaria":
        return itemCategoria(categoria, 0XFFef5350);
        break;
      case "carnes e peixaria":
        return itemCategoria(categoria, 0XFFef5350);
        break;
      case "congelados":
        return itemCategoria(categoria, 0XFFf57c00);
        break;
      case "higiene":
        return itemCategoria(categoria, 0XFF8ab3cf);
        break;
      case "hortifruti":
        return itemCategoria(categoria, 0XFF43a047);
        break;
      case "infantil":
        return itemCategoria(categoria, 0XFF64A9DE);
        break;
      case "laticinios":
        return itemCategoria(categoria, 0XFFffab00);
        break;
      case "limpeza":
        return itemCategoria(categoria, 0XFF308EE6);
        break;
      case "mercearia":
        return itemCategoria(categoria, 0XFFb71c1c);
        break;
      case "padaria":
        return itemCategoria(categoria, 0XFFBCBAB3);
        break;
      case "pet":
        return itemCategoria(categoria, 0XFF5d4037);
        break;
      case "utilidades":
        return itemCategoria(categoria, 0XFF7d8597);
        break;
      default:
        return Container(
          color: Colors.black,
        );
    }
  }
}
