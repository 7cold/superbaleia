import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:superbaleia/adm/controller/controller_adm.dart';
import 'package:superbaleia/data/pedido_data.dart';
import 'package:superbaleia/widgets/extras.dart';

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
                    width: Get.context.width,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text("Nome: " + ped.cliente['nome']),
                          pw.Text("CPF: " + ped.cliente['cpf']),
                          pw.Text("Celular: " + ped.cliente['celular']),
                          pw.Divider(color: PdfColors.grey),
                          pw.Text(
                            "Data: " +
                                DateFormat('dd/MM/yy - HH:mm - EEEE', "pt_BR")
                                    .format(DateTime.fromMicrosecondsSinceEpoch(
                                        ped.data.microsecondsSinceEpoch)),
                          ),
                          pw.Text("Forma de Pag: " + ped.formaPag),
                          pw.Text("Valor Produtos: R\$" +
                              formatter.format(ped.totalProdutos)),
                          pw.Text("Valor Entrega: R\$" +
                              formatter.format(ped.entrega['entregaPreco'])),
                          pw.Text("Valor Total: R\$" +
                              formatter.format(ped.totalPedido)),
                        ]),
                  ),
                ),
                pw.Flexible(
                  flex: 1,
                  child: pw.Container(
                    width: Get.context.width,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text("Dados para Entrega"),
                          pw.Text("Dados para Entrega"),
                        ]),
                  ),
                ),
              ]),
          pw.Padding(padding: const pw.EdgeInsets.only(bottom: 20)),
          // pw.Table(
          //   defaultVerticalAlignment: pw.TableCellVerticalAlignment.full,
          //   columnWidths: {
          //     0: pw.FlexColumnWidth(1),
          //     1: pw.FlexColumnWidth(3.5),
          //     2: pw.FlexColumnWidth(0.9),
          //     3: pw.FlexColumnWidth(0.7),
          //   },
          //   children: [
          //     pw.TableRow(children: [
          //       pw.Column(
          //           mainAxisAlignment: pw.MainAxisAlignment.center,
          //           crossAxisAlignment: pw.CrossAxisAlignment.start,
          //           children: [
          //             pw.Text('Data', style: pw.TextStyle(fontSize: 14.0))
          //           ]),
          //       pw.Column(
          //           mainAxisAlignment: pw.MainAxisAlignment.center,
          //           crossAxisAlignment: pw.CrossAxisAlignment.start,
          //           children: [
          //             pw.Text('Nome', style: pw.TextStyle(fontSize: 14.0))
          //           ]),
          //       pw.Column(
          //           mainAxisAlignment: pw.MainAxisAlignment.center,
          //           crossAxisAlignment: pw.CrossAxisAlignment.start,
          //           children: [
          //             pw.Text('Valor', style: pw.TextStyle(fontSize: 14.0))
          //           ]),
          //       pw.Column(
          //           mainAxisAlignment: pw.MainAxisAlignment.center,
          //           crossAxisAlignment: pw.CrossAxisAlignment.start,
          //           children: [
          //             pw.Text('Status', style: pw.TextStyle(fontSize: 14.0))
          //           ]),
          //     ]),
          //   ],
          // ),
          // pw.Table(
          //     columnWidths: {
          //       0: pw.FlexColumnWidth(1),
          //       1: pw.FlexColumnWidth(3.5),
          //       2: pw.FlexColumnWidth(0.9),
          //       3: pw.FlexColumnWidth(0.7),
          //     },
          //     children: transFiltro.map((res) {
          //       Transactions trans = res;

          //       if (trans.amountCents.isNegative == true) {
          //         despesas += trans.amountCents;
          //       } else {
          //         receitas += trans.amountCents;
          //       }

          //       String categorie = "";

          //       c.categories.forEach((element) {
          //         Categories categories = Categories.fromJson(element);
          //         if (trans.categoryId == categories.id) {
          //           categorie = element['name'];
          //         }
          //       });

          //       return pw.TableRow(children: [
          //         pw.Column(
          //             mainAxisAlignment: pw.MainAxisAlignment.start,
          //             crossAxisAlignment: pw.CrossAxisAlignment.start,
          //             children: [
          //               pw.Divider(color: PdfColors.grey400),
          //               pw.Text(
          //                   DateFormat('dd/MM/yyyy').format(
          //                       DateFormat('yyyy-MM-dd').parse(trans.date)),
          //                   style: pw.TextStyle(
          //                       fontSize: 12, color: PdfColors.grey600))
          //             ]),
          //         pw.Column(
          //             mainAxisAlignment: pw.MainAxisAlignment.start,
          //             crossAxisAlignment: pw.CrossAxisAlignment.start,
          //             children: [
          //               pw.Divider(color: PdfColors.grey400),
          //               pw.Text(
          //                 trans.description,
          //                 style: pw.TextStyle(
          //                     fontSize: 12, color: PdfColors.grey700),
          //               ),
          //               pw.Text(
          //                 categorie,
          //                 style: pw.TextStyle(
          //                     fontSize: 10, color: PdfColors.grey600),
          //               ),
          //               pw.Text(trans.notes,
          //                   style: pw.TextStyle(
          //                       fontSize: 10, color: PdfColors.grey600))
          //             ]),
          //         pw.Column(children: [
          //           pw.Divider(color: PdfColors.grey400),
          //           pw.Text(Money.fromInt(trans.amountCents, c.real).toString(),
          //               style: pw.TextStyle(
          //                   fontSize: 12,
          //                   color: trans.amountCents.isNegative == true
          //                       ? PdfColors.red500
          //                       : PdfColors.green500))
          //         ]),
          //         pw.Column(children: [
          //           pw.Divider(color: PdfColors.grey400),
          //           pw.Text(trans.paid == true ? "Pago" : "Não pago",
          //               style: pw.TextStyle(
          //                   fontSize: 12, color: PdfColors.grey600))
          //         ]),
          //       ]);
          //     }).toList()),
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
      appBar: BaleiaExtras.appBar("Relatório"),
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
