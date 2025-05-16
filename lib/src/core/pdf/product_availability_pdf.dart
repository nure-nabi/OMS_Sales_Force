import 'dart:io';

import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../allreports/save_product_availability/model/save_product_availability_model.dart';
import 'bill_pdf.dart';

class ProductAvailabilityPDFApi {
  static double myCellHeight = 20;

  static Future<File> generate({
    required CompanyDetailsModel companyDetails,
    required List<SaveProductAvailabilityModel> dataList,
  }) async {
    final pdf = Document();

    /// ================================================
    /// ================================================

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
              companyPanNo: "",
              address: "",
              companyName: companyDetails.companyName,
            ),
            SizedBox(height: 10.0),
            Divider(),
            _contentTrialTable(context, dataList),

            ///
          ];
        },
      ),
    );

    return FileHandleApi.saveDocument(
      name: 'product_availability.pdf',
      pdf: pdf,
    );
  }

  static Widget _contentTrialTable(
    Context context,
    List<SaveProductAvailabilityModel> dataList,
  ) {
    final tableHeaders = ['Product', 'Quantity', 'Price'];

    return TableHelper.fromTextArray(
      border: null,
      cellAlignment: Alignment.centerLeft,
      headerDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        color: PdfColors.orangeAccent,
      ),
      headerHeight: 25,
      cellHeight: myCellHeight,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
      },
      headerStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      cellStyle: const TextStyle(
        fontSize: 10,
      ),
      rowDecoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: PdfColors.blueGrey900,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        dataList.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => dataList[row].getIndex(col),
        ),
      ),
    );
  }
}
