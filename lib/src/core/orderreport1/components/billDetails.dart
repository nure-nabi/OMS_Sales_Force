import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/colors.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:provider/provider.dart';
import '../model/order_report_model.dart';
import '../order_report.dart';

class OrderBillScreen extends StatelessWidget {
  const OrderBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderReportState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bill Details"),
      ),
      body: Column(
        children: [
          Flexible(
            child: state.outletList1.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.outletList1.length,
              itemBuilder: (context, index) {
                OrderReportDataModel indexData = state.outletList1[index];
                return StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return Container(
                      decoration: ContainerDecoration.decoration(
                        color: index % 2 == 0
                            ? Colors.white
                            : Colors.blueGrey.shade100,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 5.0,
                      ),
                      child: InkWell(
                        onTap: () async {},
                        child: _buildList(indexData),
                      ),
                    );
                  },
                );
              },
            )
                : const NoDataWidget(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await state.onPrint();
        },
        tooltip: 'Print Report',
        child: const Icon(Icons.print),
      ),
    );
  }

  Widget _buildList(OrderReportDataModel indexData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      child: Container(
        decoration: ContainerDecoration.decoration(
          bColor: borderColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _titleValue("Bill No.", indexData.vNo),
                    _titleValue("Miti", indexData.vTime.split('T').first),
                    verticalSpace(10),
                    _titleValue("Salesman", indexData.salesman),
                    verticalSpace(5),
                    _titleValue("Party", indexData.glDesc),
                    verticalSpace(5),
                    _titleValue("Mobile", indexData.mobile),
                    _titleValue("Route", indexData.route),
                    _titleValue("Net Amt", indexData.netAmt),
                    _titleValue(
                        "Current Balance", "${indexData.currentBalance}"),
                    _titleValue("Credit Limit", "${indexData.creditLimite}"),
                    _titleValue("Over Limit", "${indexData.overLimit}"),
                    _titleValue("Credit Days", "${indexData.creditDay}"),
                    _titleValue("Over Days", "${indexData.overdays}"),
                    _titleValue("Age Of Order", "${indexData.ageOfOrder}"),
                    _titleValue("Remarks", indexData.remarks),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleValue(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: subTitleTextStyle,
            ),
          ),
          const Flexible(child: Text(":")),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: subTitleTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
