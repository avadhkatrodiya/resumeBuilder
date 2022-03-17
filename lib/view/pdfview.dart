import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:taskpractice/main.dart';
import 'package:taskpractice/model/data.dart';

Future<void> generateAndPrintArabicPdf() async {
  String? name;
  String? designation;
  String? city;
  String? img;
  String? email;
  String? phone;
  String? linkedInId;
  String? university;
  String? website;
  String? course;
  String? startDate;
  String? endDate;
  print('data is${pref!.getString('completedRoomList')}');
  String? demoDAta = await pref!.getString('completedRoomList');
  log('decode:::${jsonDecode(demoDAta!)}');
  MyCompletedData listMyData =
      MyCompletedData.fromJson(jsonDecode(demoDAta.toString()));

  log('name is ${listMyData.name}');
  name = listMyData.name;
  designation = listMyData.designation;
  city = listMyData.city;
  img = listMyData.img;
  email = listMyData.email;
  phone = listMyData.phone;
  linkedInId = listMyData.linkedInId;
  university = listMyData.university;
  website = listMyData.website;
  course = listMyData.course;
  startDate = listMyData.startDate;
  endDate = listMyData.endDate;
  final Document pdf = Document();
  List<MyCompletedData> myCompleteList = [];
  // final List data = orderData.ordersInventory!;
  // Uri myUri = Uri.parse(img!);

  pdf.addPage(pw.Page(
      margin: pw.EdgeInsets.zero,
      pageFormat: PdfPageFormat.a4,
      build: (Context context) {
        return pw.Container(
            child: pw.Column(children: [
          pw.Container(
              height: Get.size.height / 5,
              color: const PdfColor.fromInt(0xff212129),
              padding: const pw.EdgeInsets.fromLTRB(17, 15, 17, 10),
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Row(children: [
                      pw.Container(
                          child: pw.Text("$name",
                              style: pw.TextStyle(
                                  fontSize: 35,
                                  color: const PdfColor.fromInt(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2))),
                    ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text("$email",
                              style: const pw.TextStyle(
                                  fontSize: 17,
                                  color: PdfColor.fromInt(0xFFFFFFFF),
                                  letterSpacing: 1.2)),
                          pw.SizedBox(height: 15),
                          pw.Text("$phone",
                              style: const pw.TextStyle(
                                  fontSize: 17,
                                  color: PdfColor.fromInt(0xFFFFFFFF),
                                  letterSpacing: 1.2))
                        ])
                  ])),
          pw.Container(
              padding: const pw.EdgeInsets.fromLTRB(17, 15, 17, 10),
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Designation :",
                              style: pw.TextStyle(
                                  fontSize: 22,
                                  color: const PdfColor.fromInt(0xff959595),
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold)),
                          pw.Text('$designation',
                              style: const pw.TextStyle(
                                  fontSize: 18,
                                  color: PdfColor.fromInt(0xFF000000),
                                  letterSpacing: 1.2)),
                          pw.SizedBox(height: 15),
                          pw.Text("university: ",
                              style: pw.TextStyle(
                                  fontSize: 22,
                                  color: const PdfColor.fromInt(0xff959595),
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold)),
                          pw.Text("$university \n($startDate to $endDate)",
                              style: const pw.TextStyle(
                                  fontSize: 18,
                                  color: PdfColor.fromInt(0xFF000000),
                                  letterSpacing: 1.2)),
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("linkedInId: ",
                              style: pw.TextStyle(
                                  fontSize: 22,
                                  color: const PdfColor.fromInt(0xff959595),
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold)),
                          pw.Text("$linkedInId",
                              style: pw.TextStyle(
                                  fontSize: 18,
                                  color: const PdfColor.fromInt(0xFF000000),
                                  letterSpacing: 1.2)),
                          pw.SizedBox(height: 15),
                          pw.Text("website: ",
                              style: pw.TextStyle(
                                  fontSize: 22,
                                  color: const PdfColor.fromInt(0xff959595),
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold)),
                          pw.Text("$website",
                              style: const pw.TextStyle(
                                  fontSize: 27,
                                  color: PdfColor.fromInt(0xFF000000),
                                  letterSpacing: 1.2)),
                        ]),
                  ])),
          pw.Container(
              padding: const pw.EdgeInsets.fromLTRB(17, 15, 17, 10),
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Courses: ",
                              style: pw.TextStyle(
                                  fontSize: 22,
                                  color: const PdfColor.fromInt(0xff959595),
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold)),
                          pw.Text('$course',
                              style: const pw.TextStyle(
                                  fontSize: 18,
                                  color: PdfColor.fromInt(0xFF000000),
                                  letterSpacing: 1.2)),
                          pw.SizedBox(height: 15),
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("city: ",
                              style: pw.TextStyle(
                                  fontSize: 22,
                                  color: const PdfColor.fromInt(0xff959595),
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold)),
                          pw.Text("$city",
                              style: const pw.TextStyle(
                                  fontSize: 18,
                                  color: PdfColor.fromInt(0xFF000000),
                                  letterSpacing: 1.2)),
                          pw.SizedBox(height: 15),
                        ]),
                  ])),
          // pw.Container(
          //   padding: const pw.EdgeInsets.fromLTRB(17, 15, 17, 10),
          //   child: pw.Table(
          //     border: pw.TableBorder.symmetric(
          //       outside: const pw.BorderSide(
          //         width: 1,
          //         style: pw.BorderStyle.solid,
          //         color: PdfColor.fromInt(0xff212129),
          //       ),
          //       inside: const pw.BorderSide(
          //         width: 1,
          //         style: pw.BorderStyle.solid,
          //         color: PdfColor.fromInt(0xff212129),
          //       ),
          //     ),
          //     children: [
          //       pw.TableRow(
          //         decoration: const pw.BoxDecoration(
          //           color: PdfColor.fromInt(0xff212129),
          //         ),
          //         children: [
          //           pw.Container(
          //             alignment: pw.Alignment.topLeft,
          //             margin: const pw.EdgeInsets.symmetric(
          //                 vertical: 5, horizontal: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "Product Name",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "Price",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "Qty",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "Total",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       // for(gom.OrdersInventory i in data)
          //       pw.TableRow(
          //         decoration: const pw.BoxDecoration(
          //           color: PdfColor.fromInt(0xffFFFFFF),
          //         ),
          //         children: [
          //           pw.Container(
          //             alignment: pw.Alignment.topLeft,
          //             margin: const pw.EdgeInsets.symmetric(
          //                 vertical: 5, horizontal: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   'hello',
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xff000000)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 12),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   'how are',
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xff000000)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 12),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   'you',
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xff000000)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 12),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   'majama',
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xff000000)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Divider(color: const PdfColor.fromInt(0xff000000))
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // pw.Expanded(child: pw.Container()),
          // pw.Container(
          //   padding: const pw.EdgeInsets.fromLTRB(17, 15, 17, 10),
          //   child: pw.Table(
          //     border: pw.TableBorder.symmetric(
          //       outside: const pw.BorderSide(
          //         width: 1,
          //         style: pw.BorderStyle.solid,
          //         color: PdfColor.fromInt(0xff212129),
          //       ),
          //       inside: const pw.BorderSide(
          //         width: 1,
          //         style: pw.BorderStyle.solid,
          //         color: PdfColor.fromInt(0xff212129),
          //       ),
          //     ),
          //     children: [
          //       pw.TableRow(
          //         decoration: const pw.BoxDecoration(
          //             color: PdfColor.fromInt(0xff212129),
          //             border: pw.Border(
          //                 bottom: BorderSide(
          //                     color: PdfColor.fromInt(0xffFFFFFF),
          //                     width: 1.5))),
          //         children: [
          //           pw.Container(
          //             alignment: pw.Alignment.topLeft,
          //             margin: const pw.EdgeInsets.symmetric(
          //                 vertical: 5, horizontal: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "Sub Total:",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "\$ {orderData.summ!.toStringAsFixed(2)}",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       pw.TableRow(
          //         decoration: const pw.BoxDecoration(
          //             color: PdfColor.fromInt(0xff212129),
          //             border: pw.Border(
          //                 bottom: BorderSide(
          //                     color: PdfColor.fromInt(0xffFFFFFF),
          //                     width: 1.5))),
          //         children: [
          //           pw.Container(
          //             alignment: pw.Alignment.topLeft,
          //             margin: const pw.EdgeInsets.symmetric(
          //                 vertical: 5, horizontal: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "Discount",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "0%",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       pw.TableRow(
          //         decoration: const pw.BoxDecoration(
          //           color: PdfColor.fromInt(0xff212129),
          //         ),
          //         children: [
          //           pw.Container(
          //             alignment: pw.Alignment.topLeft,
          //             margin: const pw.EdgeInsets.symmetric(
          //                 vertical: 5, horizontal: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "Total: ",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           pw.Container(
          //             margin: const pw.EdgeInsets.symmetric(vertical: 5),
          //             child: pw.Column(
          //               children: [
          //                 pw.Text(
          //                   "\$ {orderData.summ!.toStringAsFixed(2)}",
          //                   style: const pw.TextStyle(
          //                       fontSize: 15,
          //                       color: PdfColor.fromInt(0xFFFFFFFF)),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ]));
      }));
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/1.pdf';
  final File file = File(path);
  // await file.writeAsBytes(pdf.save());
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
