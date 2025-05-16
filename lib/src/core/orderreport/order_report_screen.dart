import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/colors.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:provider/provider.dart';

import '../../service/sharepref/set_all_pref.dart';
import 'model/order_report_model.dart';
import 'order_report_state.dart';

class OrderReportScreen extends StatefulWidget {
  const OrderReportScreen({super.key});

  @override
  State<OrderReportScreen> createState() => _OrderReportScreenState();
}

class _OrderReportScreenState extends State<OrderReportScreen> {
  int _expandedIndex = -1;
  double percentage = 0.0;
  int second = 1;
  @override
  void initState() {
    //ontext.read<OrderReportState>().context = context;
    Provider.of<OrderReportState>(context, listen: false).context = context;
    Timer.periodic( const Duration(seconds: 1), (timer) {
      setState(() {
        percentage += 0.1; // Update percentage value here
        if (percentage > 1.0) {
          percentage = 0.0;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<OrderReportState>(
      builder: (BuildContext context, state, Widget? child) {
      //  _expandedIndex = -1;
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title:  const Text("All Order Report"),
                actions: [
                  IconButton(
                    onPressed: () async {
                      await SetAllPref.setWhenHaveListDbPending(value: false);
                      await state.init();
                      _expandedIndex=-1;
                      percentage=0.0;
                      Timer.periodic( const Duration(seconds: 1), (timer) {
                        setState(() {
                          percentage += 0.1; // Update percentage value here
                          if (percentage > 1.0) {
                            percentage = 0.0;
                          }
                        });
                      });
                    },
                    icon: const Icon(Icons.upload_outlined),
                  ),
                  horizantalSpace(5),
                  IconButton(
                    onPressed: () {
                      ShowAlert(context).alert(
                        child: DatePickerWidget(
                          onConfirm: () async {
                            await state.onDatePickerConfirm();
                            state.setDateValue = true;
                            _expandedIndex=-1;
                           // state.getDateWiseReport();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),

              ///
              body: state.orderList.isNotEmpty ? ListView.builder(
                itemCount: state.orderList.length,
                itemBuilder: (context, index) {

                  final order = state.orderList[index];
                  return Card(
                    child: ExpansionTile(
                      clipBehavior: Clip.antiAlias,
                     // childrenPadding: const EdgeInsets.all(10.0),
                      backgroundColor: Colors.grey[200],
                      collapsedBackgroundColor: Colors.white,
                      textColor: Colors.blue,
                      initiallyExpanded:   index == _expandedIndex,
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _expandedIndex = expanded ? index : -1;
                        });
                      },
                      key: Key('$index-${_expandedIndex == index}'),
                      title: Text(order.glDesc,style: const TextStyle(fontWeight: FontWeight.bold),),
                      children: [
                       _buildOrderReport(state,state.orderList,index)
                      ],
                    ),
                  );
                },
                // Header List value
              // GroupedListView<OrderReportDataModel, String>(
              //   elements: state.orderList,
              //   groupBy: (element) => element.glcode,
              //   floatingHeader: true,
              //   groupHeaderBuilder: (OrderReportDataModel element) {
              //     return Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         decoration: ContainerDecoration.decoration(
              //           color: primaryColor,
              //           bColor: primaryColor,
              //         ),
              //         padding: const EdgeInsets.all(10.0),
              //         child: Text(element.glDesc, style: tableHeaderTextStyle),
              //       ),
              //     );
              //   },
              //   itemBuilder: (context, OrderReportDataModel element) {
              //     return _buildOrderReport(state, element);
              //   },
              // ),
            ) : const Center(child: Text("No data found"),)
            ),
            if (state.isLoading) LoadingScreen.loadingScreenPending(context,percentage),
          ],
        );
      },
    );
  }

  // Header List value
  // Widget _buildOrderReport(OrderReportState state, OrderReportDataModel element) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
  //     child: Container(
  //       decoration: ContainerDecoration.decoration(
  //         bColor: borderColor,
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(element.vDate.split("T").first, style: titleTextStyle),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 10.0,
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   _titleValue("Order No", element.vNo),
  //                   _titleValue("Salesman", element.salesman),
  //                   _titleValue("Agent", "element.agent"),
  //                   _titleValue("Mobile", element.mobile),
  //                   _titleValue("Route", element.route),
  //                   _titleValue("Net Amt", "${element.netAmt}"),
  //                   _titleValue("Current Balance", "${element.currentBalance}"),
  //                   _titleValue("Credit Limit", "${element.creditLimite}"),
  //                   _titleValue("Over Limit", "${element.overLimit}"),
  //                   _titleValue("Credit Days", "${element.creditDay}"),
  //                   _titleValue("Over Days", "${element.overdays}"),
  //                   _titleValue("Age Of Order", "${element.ageOfOrder}"),
  //                   _titleValue("Remarks", element.remarks),
  //
  //                   ///
  //                   // verticalSpace(10.0),
  //                   // Align(
  //                   //   alignment: Alignment.bottomRight,
  //                   //   child: Container(
  //                   //     decoration: ContainerDecoration.decoration(),
  //                   //     child: InkWell(
  //                   //       onTap: () async {
  //                   //         await state.updatePendingVerifyList(
  //                   //           vNo: element.vNo,
  //                   //         );
  //                   //       },
  //                   //       child: Padding(
  //                   //         padding: const EdgeInsets.all(10.0),
  //                   //         child: Text("Approved", style: titleTextStyle),
  //                   //       ),
  //                   //     ),
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildOrderReport(OrderReportState state, List<OrderReportDataModel> element,int index) {
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
              //Text(element[index].vDate.split("T").first, style: titleTextStyle),
              Text(element[index].vDate, style: titleTextStyle),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _titleValue("Order No", element[index].vNo),
                    _titleValue("Salesman", element[index].salesman),
                    _titleValue("Agent", "element.agent"),
                    _titleValue("Mobile", element[index].mobile),
                    _titleValue("Route", element[index].route),
                    _titleValue("Net Amt", element[index].netAmt),
                    _titleValue("Current Balance", element[index].currentBalance),
                    _titleValue("Credit Limit", element[index].creditLimite),
                    _titleValue("Over Limit", element[index].overLimit),
                    _titleValue("Credit Days", element[index].creditDay),
                    _titleValue("Over Days", element[index].overdays),
                    _titleValue("Age Of Order", element[index].ageOfOrder),
                    _titleValue("Remarks", element[index].remarks),

                    ///
                    // verticalSpace(10.0),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: Container(
                    //     decoration: ContainerDecoration.decoration(),
                    //     child: InkWell(
                    //       onTap: () async {
                    //         await state.updatePendingVerifyList(
                    //           vNo: element.vNo,
                    //         );
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Text("Approved", style: titleTextStyle),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
