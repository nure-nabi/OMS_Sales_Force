import 'dart:io';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:oms_salesforce/src/core/login/company_model.dart';
import 'package:oms_salesforce/src/core/pdf/bill_pdf.dart';
import 'package:oms_salesforce/src/utils/number_to_words.dart';
import 'package:oms_salesforce/src/utils/text_formatter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class OrderReportPdf{
  static Future<File> generate({
    required CompanyDetailsModel companyDetails,
    required String vNo,
    required String date,
    required String salesman,
    required String glDesc,
    required String route,
    required String mobile,
    required String netAmt,
    required double currentBalance,
    required double creditLimit,
    required double overLimit,
    required double creditDays,
    required double overDays,
    required double ageOfOrder,
    required String remarks,
    required String reconcileBy,
  }) async {
    final pdf = Document();

    /// ================================================
    /// ================================================

    Widget dataValue({
      required String title,
      required String value,
      bool? isBold = false,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "$title ",
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight:
                  isBold == true ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Flexible(child: Text(":")),
            Expanded(
              flex: 3,
              child: Text(
                "$value",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight:
                  isBold == true ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildHeader({
      required String companyName,
      required String address,
      required String companyPanNo,
    }) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //Image(MemoryImage(iconImage), height: 50, width: 50),
        Column(children: [
          Text(companyName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          Text("Address: $address",
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              )),
          Text("Pan No: $companyPanNo",
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              )),
        ]),
      ]);
    }

    Widget buildFooter(Context context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            child: Text("Copyright ©.All Rights Reserved to Global Tech"),
          ),
          Text(
            'Page No.:${context.pageNumber}/${context.pagesCount}',
            style: const TextStyle(
              fontSize: 12,
              color: PdfColors.black,
            ),
          ),
        ],
      );
    }

    pdf.addPage(
      MultiPage(
        footer: (context) => buildFooter(context),
        build: (context) {
          return [
            buildHeader(
              companyPanNo:companyDetails.panNo,
              address: companyDetails.panNo,
              companyName: companyDetails.companyName,
            ),
            SizedBox(height: 10.0),
            Divider(),
            Center(child: Text("Order Report")),
            Divider(),

            ///
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: PdfColor.fromHex("#000000")),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  dataValue(title: "Voucher No", value: " $vNo"),
                  dataValue(title: "Date", value: " $date"),
                  dataValue(title: "Salesman", value: " $salesman",isBold: true),
                  dataValue(title: "Party", value: " $glDesc"),
                  dataValue(title: "Mobile", value: " $mobile"),
                  dataValue(title: "Route", value: " $route"),
                  SizedBox(height: 15.0),
                  if (netAmt != 0.00) ...[
                    dataValue(
                      title: "Net Amount",
                      value: " $netAmt",
                      isBold: true,
                    ),
                  ],
                  if (netAmt != 0.00) ...[
                    dataValue(
                      title: "Current Balance",
                      value: " $currentBalance",
                      isBold: true,
                    ),
                  ],

                  if (netAmt != 0.00) ...[
                    dataValue(
                      title: "Credit Limit",
                      value: " $creditLimit",
                      isBold: true,
                    ),
                    dataValue(
                      title: "In Words",
                      value:
                      "${NumberToWordsEnglish.convert(creditLimit.toInt()).toFirstLetterCapital()} only.",
                    ),
                  ],
                  if (netAmt != 0.00) ...[
                    dataValue(
                      title: "Over Limit",
                      value: " $overLimit",
                      isBold: true,
                    ),
                  ],
                  if (netAmt != 0.00) ...[
                    dataValue(
                      title: "Credit Days",
                      value: " $creditDays",
                      isBold: true,
                    ),
                  ],
                  if (netAmt != 0.00) ...[
                    dataValue(
                      title: "Over Days",
                      value: " $overDays",
                      isBold: true,
                    ),
                  ],
                  if (netAmt != 0.00) ...[
                    dataValue(
                      title: "Age of Order",
                      value: " $ageOfOrder",
                      isBold: true,
                    ),
                  ],
                  dataValue(title: "Remarks", value: " $remarks"),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            ////
            RichText(
              text: TextSpan(
                text: 'Print Date and Time : ',
                style: const TextStyle(),
                children: [
                  TextSpan(
                    text:
                    " ${NepaliDateTime.now().format("yyyy/MM/dd h:mm a").toUpperCase()}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ];
        },
      ),
    );
    return FileHandleApi.saveDocument(name: 'order_report.pdf', pdf: pdf);
  }
}
