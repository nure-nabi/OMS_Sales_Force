import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import 'model/pending_sync_model.dart';
import 'pending_sync_state.dart';

class PendingSyncScreen extends StatefulWidget {
  const PendingSyncScreen({super.key});

  @override
  State<PendingSyncScreen> createState() => _PendingSyncScreenState();
}

class _PendingSyncScreenState extends State<PendingSyncScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PendingSyncState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PendingSyncState>(
      builder: (context, state, child) {
        return Stack(children: [
          Scaffold(
            appBar: AppBar(title: const Text("Pending Sync")),
            body: Column(
              children: [
                TableHeaderWidget(
                  child: Row(children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Product Name",
                        style: tableHeaderTextStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Qty",
                        style: tableHeaderTextStyle,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Rate",
                        style: tableHeaderTextStyle,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Balance",
                        style: tableHeaderTextStyle,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: state.productList.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.productList.length,
                          itemBuilder: (context, index) {
                            ProductPendingSync indexData =
                                state.productList[index];
                            return TableDataWidget(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "${indexData.alias}\n( ${indexData.outletDesc} )",
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      indexData.quantity,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      indexData.rate,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      indexData.totalAmount,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const NoDataWidget(),
                ),
              ],
            ),
          ),
        ]);
      },
    );
  }
}
