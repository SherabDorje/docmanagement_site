import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../ui/utils/constants.dart';

class PdfController extends GetxController {
  static get to => Get.find<PdfController>();

  Rx<pw.Document> pdf = pw.Document().obs;
  var tableRows = <pw.TableRow>[];

  Future<pw.Document> generatePdf(
      {PdfPageFormat? format = PdfPageFormat.a4,
      Map<String, dynamic>? data}) async {
    intitTableEquipments();
    if (data != null) {
      for (var i = 0;
          i < (data[MagicStrings.equipment.name] as List).length;
          i++) {
        if ((data[MagicStrings.equipment.name]
                        [i] as TextEditingController)
                    .text !=
                '' &&
            (data[MagicStrings.ton.name][i] as TextEditingController).text !=
                '' &&
            (data[MagicStrings.seer.name][i] as TextEditingController).text !=
                '' &&
            (data[MagicStrings.hspf.name][i] as TextEditingController).text !=
                '' &&
            (data[MagicStrings.elecHeat.name][i] as TextEditingController)
                    .text !=
                '') {
          fillTableEquipments({
            MagicStrings.equipment.name: data[MagicStrings.equipment.name][i],
            MagicStrings.ton.name: data[MagicStrings.ton.name][i],
            MagicStrings.seer.name: data[MagicStrings.seer.name][i],
            MagicStrings.hspf.name: data[MagicStrings.hspf.name][i],
            MagicStrings.elecHeat.name: data[MagicStrings.elecHeat.name][i],
          });
        }
      }
    }

    format ??= PdfPageFormat.a4;
    final imgDefault = await imageFromAssetBundle('assets/images/logo.png');

    pdf = pw.Document().obs;

    pdf.value.addPage(pw.MultiPage(
      pageTheme: pw.PageTheme(
        orientation: pw.PageOrientation.portrait,
        margin: pw.EdgeInsets.symmetric(horizontal: Get.width * 0.02),
        pageFormat: format,
      ),
      build: (context) => [
        _blok1(data![MagicStrings.imgLogo], imgDefault),
        _blok2(),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _blok3Info(context, data),
                _blok4Equipment(context, data),
                _blok5ContratPrice(data),
                _blok6PriceIncludes(data),
                _blok7PriceExcludes(),
                _blok8Warranty(),
                _blok9Terms(),
                _blok10Hereby(),
                _blok11Parts(data),
              ]),
        ),
      ],
    ));
    return pdf.value;
  }

  _blok1(File? imgLogo, imgDefault) {
    late pw.ImageProvider logo;

    if (imgLogo != null && imgLogo.path != '') {
      logo = pw.MemoryImage(
        imgLogo.readAsBytesSync(),
      );
    }

    return pw.Table(children: [
      pw.TableRow(children: [
        pw.SizedBox(
          height: Get.height * 0.12,
          child: imgLogo != null && imgLogo.path != ''
              ? pw.Image(logo)
              : pw.Image(imgDefault),
        ),
        pw.Column(children: [
          pw.Padding(
            padding: pw.EdgeInsets.only(top: Get.height * 0.02),
            child: pw.Container(
              height: Get.height * 0.025,
              width: Get.width * 0.3,
              color: PdfColor.fromHex('#F7F7F7'),
              // child: pw.Padding(
              //   padding: pw.EdgeInsets.only(right: Get.width * 0.05),
              child: pw.Text(
                'FROZEN AIR COOLING AND HEATING INC',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#424242')),
                textAlign: pw.TextAlign.center,
              ),
              // ),
            ),
          ),
          pw.SizedBox(height: Get.height * 0.05),
        ]),
        pw.SizedBox(
            width: Get.width * 0.13,
            child: pw.Padding(
              padding: pw.EdgeInsets.only(top: Get.height * 0.05),
              child: pw.Text(
                'Sta License #CAC1822564',
                style: const pw.TextStyle(fontSize: 10),
              ),
            )),
      ]),
      pw.TableRow(children: [
        pw.SizedBox.shrink(),
        pw.Column(children: [
          pw.Container(
            color: PdfColor.fromHex('#F7F7F7'),
            child: pw.Text(
              '613 CAMDEN RD ALTAMONTE',
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#424242')),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.SizedBox(height: 1),
          pw.Container(
            color: PdfColor.fromHex('#F7F7F7'),
            child: pw.Text(
              'SPRINGS Florida 32714',
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#424242')),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ]),
      ])
    ]);
  }

  _blok2() {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: Get.width * 0.015),
      child: pw.Column(
        children: [
          pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
              '689-275-3663',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Padding(
                padding: pw.EdgeInsets.only(top: Get.height * 0.01),
                child: pw.Container(
                  height: Get.height * 0.04,
                  width: Get.width * 0.12,
                  color: PdfColors.black,
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'PROPOSAL',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  _blok3Info(pw.Context context, Map<String, dynamic>? data) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(top: Get.height * 0.02),
      child: pw.Table(children: [
        pw.TableRow(children: [
          pw.Text('DATE:'),
          pw.SizedBox(
              width: Get.width * 0.13,
              height: Get.height * 0.025,
              child: pw.Text(DateFormat.yMd().format(data!['date']))),
          pw.Text('CUSTOMER:'),
          pw.Text(data[MagicStrings.customer.name] != null &&
                  data[MagicStrings.customer.name] != ''
              ? data[MagicStrings.customer.name]
              : '<LLENAR>')
        ]),
        pw.TableRow(children: [
          pw.SizedBox(
              height: Get.height * 0.025, child: pw.Text('PROJECT NAME:')),
          pw.Text(data[MagicStrings.projectName.name] != null &&
                  data[MagicStrings.projectName.name] != ''
              ? data[MagicStrings.projectName.name]
              : '<LLENAR>'),
          pw.Text('ATTN:'),
          pw.Text(data[MagicStrings.attn.name] != null &&
                  data[MagicStrings.attn.name] != ''
              ? data[MagicStrings.attn.name]
              : '<LLENAR>')
        ]),
        pw.TableRow(children: [
          pw.SizedBox(
              height: Get.height * 0.025, child: pw.Text('MODEL/PLAN:')),
          pw.Text(data[MagicStrings.modelPlan.name] != null &&
                  data[MagicStrings.modelPlan.name] != ''
              ? data[MagicStrings.modelPlan.name]
              : '<LLENAR>'),
          pw.Text('PHONE:'),
          pw.Text(data[MagicStrings.phone.name] != null &&
                  data[MagicStrings.phone.name] != ''
              ? data[MagicStrings.phone.name]
              : '<LLENAR>')
        ]),
        pw.TableRow(children: [
          pw.SizedBox(
              height: Get.height * 0.025, child: pw.Text('JOB ADDRESS:')),
          pw.Text(data[MagicStrings.jobAddress.name] != null &&
                  data[MagicStrings.jobAddress.name] != ''
              ? data[MagicStrings.jobAddress.name]
              : '<LLENAR>')
        ]),
        pw.TableRow(children: [
          pw.SizedBox(height: Get.height * 0.025, child: pw.Text('CITY:')),
          pw.Text(data[MagicStrings.city.name] != null &&
                  data[MagicStrings.city.name] != ''
              ? data[MagicStrings.city.name]
              : '<LLENAR>')
        ]),
        pw.TableRow(children: [
          pw.SizedBox(height: Get.height * 0.025, child: pw.Text('BID PLAN:')),
          pw.Text(data[MagicStrings.bidPlan.name] != null &&
                  data[MagicStrings.bidPlan.name] != ''
              ? data[MagicStrings.bidPlan.name]
              : '<LLENAR>')
        ]),
      ]),
    );
  }

  _blok4Equipment(pw.Context context, Map<String, dynamic>? data) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(top: Get.height * 0.02),
      child: pw.Table(children: tableRows),
    );
  }

  _blok4EquipmentItem(String label, {bool isHeader = false}) {
    var auxlabel = label.split('\n');
    auxlabel.removeWhere((element) => element == '');
    label = '';
    auxlabel.map((e) => label = '$label$e\n').toList();
    label = label.substring(0, label.length - 1);

    return pw.Padding(
        padding: const pw.EdgeInsets.all(3),
        child: pw.Text(label,
            style: pw.TextStyle(
                fontWeight:
                    isHeader ? pw.FontWeight.bold : pw.FontWeight.normal)));
  }

  _blok5ContratPrice(Map<String, dynamic>? data) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
            'TOTAL BASE CONTRACT PRICE (TAX INCLUDED) ............................',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            )),
        pw.Text(
            '\$ ${data != null && data[MagicStrings.price.name] != null && data[MagicStrings.price.name] != '' ? data[MagicStrings.price.name] : '<LLENAR>'}',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ))
      ],
    );
  }

  _blok6PriceIncludes(Map<String, dynamic>? data) {
    return pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: Get.height * 0.01),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Price Includes:',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 11,
                )),
            pw.Text(
                'One (1) functional air distribution system include 13 Supply vents and 4 returns, 1 Dryer, 3 bath fans, all labor and material necessary to complete installation in a timely and workmanship-like manner.',
                style: const pw.TextStyle(fontSize: 11))
          ],
        ));
  }

  _blok7PriceExcludes() {
    return pw.Padding(
        padding: pw.EdgeInsets.symmetric(vertical: Get.height * 0.01),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Price Excludes:',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                )),
            pw.Text(
                'Any structural penetrations and patching, painting, line voltage wiring, or services disconnects underground chase pipes, air handler platforms, condenser pads, demolition and any other items note on plans to be done by others.',
                style: const pw.TextStyle(fontSize: 11))
          ],
        ));
  }

  _blok8Warranty() {
    return pw.Padding(
        padding: pw.EdgeInsets.only(top: Get.height * 0.01),
        child: pw.RichText(
          text: pw.TextSpan(
            children: [
              pw.TextSpan(
                text: 'Warranty:',
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              const pw.TextSpan(
                text:
                    ' One warranty Offer to Customer (Equipment parts and components per manufacturer limited warranty)',
                style: pw.TextStyle(
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ));
  }

  _blok9Terms() {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: 'Terms:',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          const pw.TextSpan(
            text: ' 50% deposit, 50% due upon completion of job.',
            style: pw.TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  _blok10Hereby() {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: pw.Text(
          'I hereby accept the terms and conditions as set forth in this proposal and I order the installation of the above-described system. This quote is firm and guaranteed for 90 days.',
          style: pw.TextStyle(
            fontSize: 8.5,
            fontWeight: pw.FontWeight.bold,
          )),
    );
  }

  _blok11Parts(Map<String, dynamic>? data) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: pw.Table(children: [
        pw.TableRow(children: [
          pw.Container(
            color: PdfColor.fromHex('#F7F7F7'),
            alignment: pw.Alignment.centerLeft,
            width: 200,
            child: pw.Text(
              'FROZEN AIR COOLING AND HEATING INC.',
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#424242')),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: 100,
            alignment: pw.Alignment.center,
            child: pw.Text(
              'CUSTOMER',
              style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ]),
        pw.TableRow(children: [
          pw.Padding(
              padding: pw.EdgeInsets.only(right: 180, top: Get.height * 0.025),
              child: pw.Divider()),
          pw.Padding(
              padding: pw.EdgeInsets.only(top: Get.height * 0.025),
              child: pw.Divider()),
        ]),
        pw.TableRow(children: [
          pw.Text(
            'SIGNATURE',
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'SIGNATURE',
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
          ),
        ]),
        pw.TableRow(children: [
          pw.Text(
            'Omar Hernandez/ PRESIDENT',
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
          ),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Padding(
                padding: pw.EdgeInsets.only(top: Get.height * 0.01),
                child: pw.Divider()),
            pw.Text(
              'PRINT NAME/TITLE',
              style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
            ),
          ])
        ]),
        pw.TableRow(children: [
          pw.Row(children: [
            pw.Padding(
              padding: pw.EdgeInsets.only(top: Get.height * 0.01),
              child: pw.Text(
                'DATE: ${DateFormat.yMd().format(data!['date'])}',
                style:
                    pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
              ),
            ),
          ]),
          pw.Row(children: [
            pw.Padding(
              padding: pw.EdgeInsets.only(top: Get.height * 0.01),
              child: pw.Text(
                'DATE: ',
                style:
                    pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
              ),
            ),
          ]),
        ]),
      ]),
    );
  }

  savePDF() async {
    var savedFile = await pdf.value.save();
    List<int> fileInts = List.from(savedFile);

    if (kIsWeb) {
      html.AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
        ..setAttribute(
            "download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
        ..click();
    } else {
      final file = File("${DateTime.now().millisecondsSinceEpoch}.pdf");
      await file.writeAsBytes(await pdf.value.save());
    }
  }

  void intitTableEquipments() {
    tableRows = [
      pw.TableRow(
        decoration: pw.BoxDecoration(
          border: const pw.TableBorder(
            left: pw.BorderSide(color: PdfColors.black, width: 1.0),
            right: pw.BorderSide(color: PdfColors.black, width: 1.0),
            top: pw.BorderSide(color: PdfColors.black, width: 1.0),
            bottom: pw.BorderSide(color: PdfColors.black, width: 1.0),
          ),
          color: PdfColor.fromHex('#DBDBDB'),
        ),
        children: [
          _blok4EquipmentItem(
              '....................Equipment....................',
              isHeader: true),
          _blok4EquipmentItem('TONNAGE', isHeader: true),
          _blok4EquipmentItem('S.E.E.R', isHeader: true),
          _blok4EquipmentItem('H.S.P.F', isHeader: true),
          _blok4EquipmentItem('ELEC. HEAT', isHeader: true),
        ],
      ),
    ];
  }

  void fillTableEquipments(Map<String, dynamic> data) {
    tableRows.add(
      pw.TableRow(
        decoration: const pw.BoxDecoration(
          border: pw.TableBorder(
            left: pw.BorderSide(color: PdfColors.black, width: 1.0),
            right: pw.BorderSide(color: PdfColors.black, width: 1.0),
            top: pw.BorderSide(color: PdfColors.black, width: 1.0),
            bottom: pw.BorderSide(color: PdfColors.black, width: 1.0),
          ),
        ),
        children: [
          _blok4EquipmentItem(
              (data[MagicStrings.equipment.name] as TextEditingController)
                          .text !=
                      ''
                  ? data[MagicStrings.equipment.name].text
                  : '<LLENAR>'),
          _blok4EquipmentItem(
              (data[MagicStrings.ton.name] as TextEditingController).text != ''
                  ? data[MagicStrings.ton.name].text
                  : '<LLENAR>'),
          _blok4EquipmentItem(
              (data[MagicStrings.seer.name] as TextEditingController).text != ''
                  ? data[MagicStrings.seer.name].text
                  : '<LLENAR>'),
          _blok4EquipmentItem(
              (data[MagicStrings.hspf.name] as TextEditingController).text != ''
                  ? data[MagicStrings.hspf.name].text
                  : '<LLENAR>'),
          _blok4EquipmentItem(
              (data[MagicStrings.elecHeat.name] as TextEditingController)
                          .text !=
                      ''
                  ? data[MagicStrings.elecHeat.name].text
                  : '<LLENAR>'),
        ],
      ),
    );
  }
}
