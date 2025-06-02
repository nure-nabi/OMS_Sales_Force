import 'dart:io';
import 'dart:typed_data';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:oms_salesforce/src/utils/text_formatter.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../../../utils/date_formater.dart';
import '../../../utils/number_to_words.dart';
import '../../login/company_model.dart';
import '../model/orderReportDetailsModel.dart';

double myCellHeight = 20;

Future<Uint8List> generateOrderProductListPDF({
  List<OrderReportDetailDataModel>? orderProductList,
  required CompanyDetailsModel companyDataDetails,
  required String glDesc,
  required String vNo,
  required String mobile,
  required String route,
  required String remarks,
  bool showEnglishDate = false,
}) async {
  final invoice = Invoice(
    orderProductList: orderProductList ?? [],
    baseColor: PdfColors.orangeAccent,
    accentColor: PdfColors.blueGrey900,
    companyDataDetails: companyDataDetails,
    glDesc: glDesc,
    mobile: mobile,
    route: route,
    remarks: remarks,
    vNo: vNo,
    fileName: 'Order Report',
    showEnglishDate: showEnglishDate,
  );

  return await invoice.buildPdf(PdfPageFormat.a4);
}

class Invoice {
  Invoice({
    required this.orderProductList,
    required this.baseColor,
    required this.accentColor,
    required this.companyDataDetails,
    required this.glDesc,
    required this.route,
    required this.remarks,
    required this.mobile,
    required this.vNo,
    required this.fileName,
    required this.showEnglishDate,
  });

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    for (var orderList in orderProductList) {
      totalAmount += double.parse(orderList.dNetAmt.toString());
    }
    return totalAmount;
  }

  final List<OrderReportDetailDataModel> orderProductList;

  ///
  late CompanyDetailsModel companyDataDetails;
  late String? fileName, glDesc, vNo, mobile, route,remarks;
  final PdfColor baseColor;
  final PdfColor accentColor;
  final bool showEnglishDate;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    final doc = Document();

    doc.addPage(
      MultiPage(
        footer: _buildFooter,
        build: (context) => [
          _buildHeader(
            context,
          ),

          ///
          _contentTrialTable(context, showEnglishDate),

          _contentBalanceFooter(context),
          SizedBox(height: 25.0),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            RichText(
              text: TextSpan(
                  text: 'Remarks: ',
                  style: const TextStyle(),
                  children: [
                    TextSpan(
                        text: remarks,
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ]),
            ),RichText(
              text: TextSpan(
                  text: 'Agent: ',
                  style: const TextStyle(),
                  children: [
                    TextSpan(
                        text: companyDataDetails.userName,
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: 'Print Date and Time : ',
                  style: const TextStyle(),
                  children: [
                    TextSpan(
                        text:
                            " ${NepaliDateTime.now().format("yyyy/MM/dd h:mm a").toUpperCase()}",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ]),
            ),
          ]),
        ],
      ),
    );

    var bytes = doc.save();

    Directory directory = (await getApplicationDocumentsDirectory());
    String path = directory.path;
    File file = File('$path/$fileName.pdf');
    await file.writeAsBytes(List.from(await bytes), flush: true);

    OpenFilex.open('$path/$fileName.pdf');
    // Share.shareFiles(["$path/$fileName.pdf"], text: "Ledger");

    return doc.save();
  }

  Widget _buildFooter(Context context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child: Text("Copyright ©.All Rights Reserved to Global Tech"),
        ),
        Text(
          '${context.pageNumber}/${context.pagesCount}',
          style: const TextStyle(
            fontSize: 12,
            color: PdfColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(Context context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20.0),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    companyDataDetails.companyName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PdfColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Phone No: ${companyDataDetails.loginName}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PdfColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "Pan No: ${companyDataDetails.panNo}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PdfColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 10.0),
            //   width: double.infinity,
            //   height: 0.5,
            //   color: PdfColors.grey.shade(0.2),
            // ),
            Divider(),
            Center(
                child: Text(
              'Order Bill',
              style: TextStyle(
                // color: PdfColors.orangeAccent,
                fontWeight: FontWeight.bold,
                // fontSize: 16,
              ),
            )),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Voucher No: $vNo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: PdfColors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            // fontSize: 16,
                          ),
                        ),
                        Text(
                          'Customer: $glDesc',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: PdfColors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            // fontSize: 16,
                          ),
                        ),
                        Text(
                          'Mobile: $mobile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: PdfColors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            // fontSize: 16,
                          ),
                        ),
                        Text(
                          'Route: $route',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: PdfColors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            // fontSize: 16,
                          ),
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Day : ${MyDate.getWeekName(weekId: "${NepaliDateTime.now().weekday}")}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: PdfColors.black,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Date : ${NepaliDateTime.now().toString().substring(0, 10).replaceAll("-", "/")}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: PdfColors.black,
                            fontSize: 13,
                          ),
                        ),
                      ]),
                ]),
            SizedBox(height: 10.0),
          ],
        ),
      ],
    );
  }

  Widget _contentBalanceFooter(Context context) {
    double totalAmount = calculateTotalAmount();
    double vatAmount = totalAmount * 0.13;
    double netAmount = vatAmount + totalAmount;
    int netAmountWord = int.parse(netAmount.toString().split(".").first);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PdfColor.fromHex("#000000")),
      ),
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'In Word: ',
                      style: const TextStyle(),
                      children: [
                        TextSpan(
                          text:
                              "${NumberToWordsEnglish.convert(netAmountWord).toFirstLetterCapital()} only.",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 5.0),
          Container(
            height: 50.0,
            width: 1.0,
            color: PdfColor.fromHex("#000000"),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                      child: Text(
                        'Gross Amount: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      totalAmount.toStringAsFixed(2),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  Row(children: [
                    Expanded(
                      child: Text(
                        'VAT 13%: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      vatAmount.toStringAsFixed(2),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  Row(children: [
                    Expanded(
                      child: Text(
                        'Net Amount: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      netAmount.toStringAsFixed(2),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentTrialTable(
    Context context,
    bool showEnglishDate,
  ) {
    final tableHeaders = [
      'Particular',
      'Unit',
      'Alt.Qty',
      'Qty',
      'Rate',
      'Amount',
    ];
    return TableHelper.fromTextArray(
      headers: ['S.N'] + tableHeaders,
      cellAlignment: Alignment.centerLeft,
      headerDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        color: PdfColors.grey300,
      ),
      headerHeight: 25,
      cellHeight: myCellHeight,
      columnWidths: {
        0: const FlexColumnWidth(0.2),
        1: const FlexColumnWidth(1.2),
        2: const FlexColumnWidth(0.4),
        3: const FlexColumnWidth(0.4),
        4: const FlexColumnWidth(0.4),
        5: const FlexColumnWidth(0.5),
        6: const FlexColumnWidth(0.6),
      },
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.centerLeft,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.centerRight,
      },
      headerStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      border: TableBorder.symmetric(
        inside: const BorderSide(width: 1),
        outside: const BorderSide(width: 1),
      ),
      cellStyle: const TextStyle(
        fontSize: 10,
      ),
      rowDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      data: List<List<String>>.generate(
        orderProductList.length,
        (row) {
          List<String> rowData = List<String>.generate(
            tableHeaders.length,
            (col) => orderProductList[row].getIndex(col, showEnglishDate),
          );
          rowData.insert(0, '${row + 1}');
          return rowData;
        },
      )
          .where((rowData) => rowData.skip(1).any((value) => value != "0.0"))
          .toList(),
    );
  }
}
