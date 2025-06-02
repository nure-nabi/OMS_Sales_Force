import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../enum/enum.dart';
import '../../bill_by_vno/bill_by_vno.dart';
import '../deliveryreport.dart';

class DeliveryOutletCustomerSection extends StatelessWidget {
  const DeliveryOutletCustomerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DeliveryCustomerState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Outlet List")),
      body: Column(
        children: [
          Expanded(
            child: state.outletList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.outletList.length,
                    itemBuilder: (context, index) {
                      DeliveryReportCustomerDataModel indexData =
                          state.outletList[index];
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BillDetailsByVnoScreen(
                                      vNo: indexData.vNo,
                                      name: state
                                          .productState.outletDetail.glDesc,
                                      billPrintEnum: BillPrintEnum.none,
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
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1,color: Colors.black12))
            ),
           padding: EdgeInsets.all(10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 const Text("Total",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text(state.netAmt.toStringAsFixed(2),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(DeliveryReportCustomerDataModel indexData) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 12.0,
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
                verticalSpace(5),

                Text("Date. ${indexData.vDate}"),
                Text("Miti. ${indexData.vMiti}"),

                ///
                verticalSpace(10),
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
                          text: "Rs.${indexData.netAmount}",
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
