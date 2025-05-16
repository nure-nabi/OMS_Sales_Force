import 'dart:io';

import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../productorder/model/product_order_model.dart';
import '../quickorder/quickorder.dart';
import 'bill_pdf.dart';

class OrderProductPdfApi {
  static Future<File> generate({
    required CompanyDetailsModel companyDetails,
    required FilterOutletInfoModel outletDetails,
    required List<ProductOrderModel> productList,
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
                " $value",
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
        // Image(MemoryImage(iconImage), height: 50, width: 50),
        Column(children: [
          Text(companyName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          Text(address,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              )),
          Text(companyPanNo,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              )),
        ]),
      ]);
    }

    Widget buildFooter(Context context) {
      return Row(
        mainAxisAlignment: context.pageNumber == context.pagesCount
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (context.pageNumber == context.pagesCount)
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

    Widget buildTableHeader() {
      return Container(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                "S.N.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                "Qty",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Rate",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Amount",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      );
    }

    // Calculate total balance
    double totalBalance = productList.fold(
        0,
        (sum, item) =>
            sum + double.parse(item.quantity) * double.parse(item.rate));

    pdf.addPage(
      MultiPage(
        footer: (context) => buildFooter(context),
        build: (context) {
          return [
            buildHeader(
              companyPanNo: companyDetails.panNo,
              address: "",
              companyName: companyDetails.companyName,
            ),
            SizedBox(height: 10.0),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          outletDetails.glDesc,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "${outletDetails.address}, ${outletDetails.phoneNo}"),
                        if (outletDetails.panno.isNotEmpty)
                          Text("Pan No.: ${outletDetails.panno}"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Date: ',
                        style: const TextStyle(),
                        children: [
                          TextSpan(
                            text: "${DateTime.now()}".substring(0, 10),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),

            Divider(),
            // Container(
            //   padding: const EdgeInsets.all(5.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Expanded(
            //         child: Text(
            //           "S.N.",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 4,
            //         child: Text(
            //           "Name",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       Expanded(
            //         child: Text(
            //           "Qty",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.end,
            //         ),
            //       ),
            //       Expanded(
            //         flex: 2,
            //         child: Text(
            //           "Rate",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.end,
            //         ),
            //       ),
            //       Expanded(
            //         flex: 3,
            //         child: Text(
            //           "Amount",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.end,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            buildTableHeader(),

            ListView.builder(
              itemCount: productList.length,
              itemBuilder: (_, index) {
                var productInfo = productList[index];
                return Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: Text("${index + 1}")),
                      Expanded(flex: 4, child: Text(productInfo.alias)),
                      Expanded(
                        child: Text(
                          productInfo.quantity,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          productInfo.rate,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          double.parse(
                            "${double.parse(productInfo.quantity) * double.parse(productInfo.rate)}",
                          ).toStringAsFixed(2),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 10.0),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                ),
                Text(
                  totalBalance.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
            Divider(),
            // RichText(
            //   text: TextSpan(
            //     text: 'Print Date and Time : ',
            //     style: const TextStyle(),
            //     children: [
            //       TextSpan(
            //         text:
            //             " ${NepaliDateTime.now().format("yyyy/MM/dd h:mm a").toUpperCase()}",
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       )
            //     ],
            //   ),
            // ),
          ];
        },
      ),
    );

    return FileHandleApi.saveDocument(name: 'product_order.pdf', pdf: pdf);
  }
}
