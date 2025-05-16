import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/top_buying/top_buying_state.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../widgets/widgets.dart';

class TopBuyingScreen extends StatefulWidget {
  const TopBuyingScreen({super.key});

  @override
  State<TopBuyingScreen> createState() => _TopBuyingScreenState();
}

class _TopBuyingScreenState extends State<TopBuyingScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TopBuyingState>().context = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TopBuyingState>(
      builder: (BuildContext context, state, Widget? child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text("Top Buying"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Amt"),
                        Switch(
                          activeColor: errorColor,
                          value: state.isOrderbyQTY,
                          onChanged: (value) {
                            state.isOrderbyQTY = !state.isOrderbyQTY;
                            state.filterDataList();
                          },
                        ),
                        const Text("Qty"),
                      ],
                    ),
                  ),
                ],
              ),
              body: state.dataList.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ///
                        Container(
                          decoration: ContainerDecoration.decoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  "The data has been arranged in order of ",
                                ),
                                Text(
                                  state.isOrderbyQTY
                                      ? 'Quantity'
                                      : 'Net Amount',
                                  style: titleTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///
                        TableHeaderWidget(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "S.N.",
                                  style: tableHeaderTextStyle,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Product",
                                  style: tableHeaderTextStyle,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  state.isOrderbyQTY ? "Quantity" : "Amount",
                                  style: tableHeaderTextStyle,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///
                        ///
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.dataList.length,
                            itemBuilder: (context, index) {
                              final indexData = state.dataList[index];
                              return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return TableDataWidget(
                                    onTap: () async {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text("${index + 1}")),
                                          Expanded(
                                            flex: 3,
                                            child: Text(indexData.pDesc),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              state.isOrderbyQTY
                                                  ? "${indexData.qty}"
                                                  : "${indexData.netAmt}",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        ///
                      ],
                    )
                  : const NoDataWidget(),
            ),
            if (state.isLoading) LoadingScreen.loadingScreen(),
          ],
        );
      },
    );
  }
}
