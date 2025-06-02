import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../orderReportDetails/orderReportDetails.dart';
import '../order_report.dart';

class OrderOutletScreen extends StatelessWidget {
  const OrderOutletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderReportState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(state.selectedDate.vDate),
      ),
      body: Column(
        children: [
          Flexible(
            child: state.outletList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.outletList.length,
                    itemBuilder: (context, index) {
                      OrderReportDataModel indexData = state.outletList[index];
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
                              onTap: () async {
                                // state.getSelectedVno = indexData;
                                // state.onVoucherSelected();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderReportDetailScreen(
                                      vNo: indexData.vNo,
                                      glDesc: indexData.glDesc,
                                      mobile: indexData.mobile,
                                      route: indexData.route,
                                      remarks: indexData.remarks,
                                    ),
                                  ),
                                );
                              },
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
            ),
            Text(
              state.netAmt.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(OrderReportDataModel indexData) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  indexData.glDesc,
                  style: titleTextStyle,
                ),
                verticalSpace(7),
                Container(
                  decoration: ContainerDecoration.decoration(
                    color: Colors.grey.shade50,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "Bill No. ${indexData.vNo}",
                    ),
                  ),
                ),
                verticalSpace(3),
                Text("Date. ${indexData.vDate.split('T').first}"),
              ],
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: ContainerDecoration.decoration(
                  color: Colors.grey.shade50,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: RichText(
                    text: TextSpan(
                      style: hintTextStyle.copyWith(color: primaryColor),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Amount\n',
                        ),
                        TextSpan(
                          text: "Rs.${indexData.netAmt.toString()}",
                          style: subTitleTextStyle.copyWith(fontSize: 14.0),
                        ),
                      ],
                    ),
                    textScaler: const TextScaler.linear(1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
