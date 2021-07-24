import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/data/carrinho_data.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/data/produto_data.dart';
import 'package:superbaleia/widgets/extras.dart';

final formatter = new NumberFormat("#,##0.00", "pt_BR");

// ignore: must_be_immutable
class PedidoAdmImpressao extends StatelessWidget {
  final ControllerAdm c = Get.put(ControllerAdm());

  final PedidoData ped;

  PedidoAdmImpressao({@required this.ped});

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData(
          tableCell: pw.TextStyle(color: PdfColors.grey700),
        ),
        pageFormat: PdfPageFormat.a4,
        build: (context) => <pw.Widget>[
          pw.Header(
            level: 0,
            title: '',
            textStyle: pw.TextStyle(fontSize: 18),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Text('PEDIDO - #' + ped.id.substring(0, 6),
                    textScaleFactor: 1.5),
                pw.Text(
                    DateFormat('dd/MM/yy - HH:mm - EEEE', "pt_BR").format(
                        DateTime.fromMicrosecondsSinceEpoch(
                            ped.data.microsecondsSinceEpoch)),
                    textScaleFactor: 1,
                    style: pw.TextStyle(color: PdfColors.grey700)),
              ],
            ),
          ),
          pw.Flex(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              direction: pw.Axis.horizontal,
              children: [
                pw.Flexible(
                  flex: 1,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(10),
                    margin: pw.EdgeInsets.only(right: 5),
                    decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: PdfColors.grey, width: 0.5),
                        borderRadius: pw.BorderRadius.circular(6)),
                    width: Get.context.width,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text("Dados",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Padding(padding: pw.EdgeInsets.only(bottom: 10)),
                          pw.Text(
                            "Nome: " + ped.cliente['nome'],
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                          pw.Text(
                            "CPF: " + ped.cliente['cpf'],
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                          pw.Text(
                            "Celular: " + ped.cliente['celular'],
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                          pw.Divider(color: PdfColors.grey),
                          pw.Text(
                            "Forma de Pag: " + ped.formaPag,
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                          pw.Text(
                            "Valor Produtos: R\$" +
                                formatter.format(ped.totalProdutos),
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                          pw.Text(
                            "Valor Entrega: R\$" +
                                formatter.format(ped.entrega['entregaPreco']),
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                          pw.Text(
                            "Valor Total: R\$" +
                                formatter.format(ped.totalPedido),
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                        ]),
                  ),
                ),
                pw.Flexible(
                  flex: 1,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(10),
                    margin: pw.EdgeInsets.only(left: 5),
                    decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: PdfColors.grey, width: 0.5),
                        borderRadius: pw.BorderRadius.circular(6)),
                    width: Get.context.width,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text("Entrega",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Padding(padding: pw.EdgeInsets.only(bottom: 10)),
                          pw.Text(
                            ped.cliente['endereco'] + ", " + ped.cliente['num'],
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                          pw.Text(
                            ped.cliente['bairro'],
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                          pw.Text(
                            ped.cliente['cidade'],
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                          pw.Text(
                            ped.entrega['entregaTipo'],
                            style: pw.TextStyle(color: PdfColors.grey700),
                          ),
                          ped.entrega['entregaTipo'] == "Entrega agendada"
                              ? pw.Text(
                                  DateFormat('dd/MM/yy - HH:mm - EE', "pt_BR")
                                      .format(
                                          DateTime.fromMicrosecondsSinceEpoch(
                                              ped.entrega['entregaData']
                                                  .microsecondsSinceEpoch))
                                      .capitalize,
                                  style: pw.TextStyle(color: PdfColors.grey700),
                                )
                              : pw.SizedBox(),
                        ]),
                  ),
                ),
              ]),
          pw.Padding(padding: const pw.EdgeInsets.only(bottom: 20)),
          pw.Text("Produtos",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Table(
            defaultVerticalAlignment: pw.TableCellVerticalAlignment.full,
            columnWidths: {
              0: pw.FlexColumnWidth(2.6),
              1: pw.FlexColumnWidth(7.5),
              2: pw.FlexColumnWidth(3),
              3: pw.FlexColumnWidth(2),
              4: pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('#ID', style: pw.TextStyle(fontSize: 11.0))
                    ]),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Produto', style: pw.TextStyle(fontSize: 11.0))
                    ]),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Qtd.', style: pw.TextStyle(fontSize: 11.0))
                    ]),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Preço', style: pw.TextStyle(fontSize: 11.0))
                    ]),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Preço Total',
                          style: pw.TextStyle(fontSize: 11.0))
                    ]),
              ]),
            ],
          ),
          pw.Table(
              columnWidths: {
                0: pw.FlexColumnWidth(1.5),
                1: pw.FlexColumnWidth(3.5),
                2: pw.FlexColumnWidth(1.8),
                3: pw.FlexColumnWidth(1.8),
              },
              children: ped.produtos.map((res) {
                CarrinhoData pedCart = CarrinhoData.fromMap(res);
                ProdutoData prod = pedCart.produtoData;

                return pw.TableRow(children: [
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Divider(color: PdfColors.grey400),
                        pw.Text("#" + pedCart.produtoId.substring(0, 6),
                            style: pw.TextStyle(
                                fontSize: 12, color: PdfColors.grey600))
                      ]),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Divider(color: PdfColors.grey400),
                        pw.Text(
                          prod.titulo,
                          style: pw.TextStyle(fontSize: 12),
                        ),
                        pw.Text(
                          pedCart.categoria.capitalizeFirst,
                          style: pw.TextStyle(
                              fontSize: 10, color: PdfColors.grey600),
                        ),
                      ]),
                  pw.Column(children: [
                    pw.Divider(color: PdfColors.grey400),
                    pw.Text(pedCart.qtd.toString(),
                        style: pw.TextStyle(
                          fontSize: 12,
                        ))
                  ]),
                  pw.Column(children: [
                    pw.Divider(color: PdfColors.grey400),
                    prod.preco != prod.precoDesc
                        ? pw.Text("R\$" + formatter.format(prod.precoDesc),
                            style: pw.TextStyle(
                              fontSize: 12,
                            ))
                        : pw.Text("R\$" + formatter.format(prod.preco),
                            style: pw.TextStyle(
                              fontSize: 12,
                            ))
                  ]),
                  pw.Column(children: [
                    pw.Divider(color: PdfColors.grey400),
                    prod.preco != prod.precoDesc
                        ? pw.Text(
                            "R\$" +
                                formatter.format(prod.precoDesc * pedCart.qtd),
                            style: pw.TextStyle(
                              fontSize: 12,
                            ))
                        : pw.Text(
                            "R\$" + formatter.format(prod.preco * pedCart.qtd),
                            style: pw.TextStyle(
                              fontSize: 12,
                            ))
                  ]),
                ]);
              }).toList()),
        ],
        footer: (pw.Context context) {
          return pw.Column(children: [
            pw.Divider(color: PdfColors.grey400),
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(
                            DateFormat('yyyy-MM-dd HH:mm')
                                .parse(DateTime.now().toString())),
                        style: pw.TextStyle(
                            fontSize: 11, color: PdfColors.grey600)),
                    pw.Text("Pag. ${context.pageNumber}/ ${context.pagesCount}",
                        style: pw.TextStyle(
                            fontSize: 11, color: PdfColors.grey600))
                  ]),
            )
          ]);
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaleiaExtras.appBar("Impressão de Pedido"),
      body: Theme(
        data: ThemeData(
          primaryColor: CupertinoColors.activeGreen,
          accentColor: CupertinoColors.activeBlue,
        ),
        child: PdfPreview(
          canChangePageFormat: false,
          maxPageWidth: context.width / 2,
          canChangeOrientation: false,
          dynamicLayout: false,
          onPrinted: (context) => Get.back(),
          onShared: (context) => Get.back(),
          actions: [
            PdfPreviewAction(
              icon: Icon(Icons.exit_to_app),
              onPressed: (context, build, pageFormat) => Get.back(),
            )
          ],
          build: (format) => _generatePdf(),
        ),
      ),
    );
  }
}
