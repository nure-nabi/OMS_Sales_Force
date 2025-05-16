import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/enum/enum.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import 'bill_by_vno_state.dart';

class BillDetailsByVnoScreen extends StatefulWidget {
  final String vNo, name;
  final BillPrintEnum billPrintEnum;

  const BillDetailsByVnoScreen({
    super.key,
    required this.vNo,
    required this.name,
    required this.billPrintEnum,
  });

  @override
  State<BillDetailsByVnoScreen> createState() => _BillDetailsByVnoScreenState();
}

class _BillDetailsByVnoScreenState extends State<BillDetailsByVnoScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BillNoByVnoState>(context, listen: false).getPrintEnum =
        widget.billPrintEnum;
    Provider.of<BillNoByVnoState>(context, listen: false).init(vNo: widget.vNo);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BillNoByVnoState>(
      builder: (context, state, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: Text(widget.vNo), actions: [
                if (state.dataList.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: IconButton(
                      onPressed: () {
                        state.onPrint(name: widget.name);
                      },
                      icon: const Icon(Icons.print, color: Colors.white),
                    ),
                  )
              ]),
              body: Column(children: [
                (state.dataList.isNotEmpty)
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: state.dataList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 2.0),
                                color: (index % 2 == 0)
                                    ? Colors.white
                                    : Colors.blueGrey.shade100,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0),
                                                  child: Text(
                                                      state.dataList[index]
                                                          .dPDesc,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0.0),
                                                  child: Text(
                                                    "Qty : ${state.dataList[index].dQty} (${state.dataList[index].unitCode})",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 0.0),
                                                  child: Text(
                                                    "Rate : ${state.dataList[index].dLocalRate}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 0.0),
                                                  child: Text(
                                                    "Amount : ${state.dataList[index].dBasicAmt}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        // Flexible(
                                        //   child: Container(
                                        //       padding:
                                        //           const EdgeInsets.all(3.0),
                                        //       decoration: BoxDecoration(
                                        //         color: Colors.white,
                                        //         borderRadius:
                                        //             BorderRadius.circular(5.0),
                                        //         border: Border.all(
                                        //             color:
                                        //                 Colors.grey.shade100),
                                        //       ),
                                        //       child: RichText(
                                        //         text: TextSpan(
                                        //           text: 'Amount \n',
                                        //           style: const TextStyle(
                                        //               fontSize: 13.0,
                                        //               color: Colors.blueGrey),
                                        //           children: <TextSpan>[
                                        //             TextSpan(
                                        // text: state
                                        //     .dataList[index]
                                        //     .DBasicAmt,
                                        //               style: const TextStyle(
                                        //                 fontSize: 14.0,
                                        //                 fontWeight:
                                        //                     FontWeight.bold,
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       )),
                                        // ),
                                      ]),
                                ),
                              );
                            }),
                      )
                    : const NoDataWidget()
              ]),
            ),
            if (state.isLoading) LoadingScreen.loadingScreen(),
          ],
        );
      },
    );
  }
}
