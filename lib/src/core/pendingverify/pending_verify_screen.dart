import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/pendingverify/pending_verify_state.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'model/pending_verify_model.dart';

class PendingVerifyScreen extends StatefulWidget {
  const PendingVerifyScreen({super.key});

  @override
  State<PendingVerifyScreen> createState() => _PendingVerifyScreenState();
}

class _PendingVerifyScreenState extends State<PendingVerifyScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PendingVerifyState>(context, listen: false).getContext =
        context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PendingVerifyState>(
      builder: (context, state, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text("Pending Verify")),
              body: Column(
                children: [
                  Expanded(
                    child: state.outletList.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.outletList.length,
                            itemBuilder: (context, index) {
                              PendingVerifyDataModel indexData =
                                  state.outletList[index];

                              // return TableDataWidget(
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         flex: 3,
                              //         child: Text(
                              //           "${indexData.itemName}\n( ${indexData.glDesc} )",
                              //         ),
                              //       ),
                              //       // Expanded(
                              //       //   flex: 3,
                              //       //   child: Text(indexData.itemName),
                              //       // ),
                              //       Expanded(
                              //         child: Text(
                              //           indexData.qty,
                              //           textAlign: TextAlign.end,
                              //         ),
                              //       ),
                              //       Expanded(
                              //         flex: 2,
                              //         child: Text(
                              //           indexData.rate,
                              //           textAlign: TextAlign.end,
                              //         ),
                              //       ),
                              //       Expanded(
                              //         flex: 2,
                              //         child: Text(
                              //           indexData.netAmt,
                              //           textAlign: TextAlign.end,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // );

                              return Container(
                                decoration: ContainerDecoration.decoration(),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 5.0),
                                child: InkWell(
                                  onTap: () async {
                                    state.getSelectedOutlet = indexData;
                                    await state.onOutletSelected();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    child: ArrowListWidget(
                                      child: Text(indexData.glDesc),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const NoDataWidget(),
                  ),
                ],
              ),
            ),
            if (state.isLoading) LoadingScreen.loadingScreen(),
          ],
        );
      },
    );
  }
}
