import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/coverageandproductivity/coverageandproductivity.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

class CoverageProductivityScreen extends StatefulWidget {
  const CoverageProductivityScreen({super.key});

  @override
  State<CoverageProductivityScreen> createState() =>
      _CoverageProductivityScreenState();
}

class _CoverageProductivityScreenState
    extends State<CoverageProductivityScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<CoverageProductivityState>(context, listen: false).getContext =
        context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoverageProductivityState>(
      builder: (context, state, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text("Coverage And Productivity")),
              body: state.reportList.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: state.reportList.length,
                      itemBuilder: (context, index) {
                        CoverageProductivityDataModel indexData =
                            state.reportList[index];

                        return Container(
                          decoration: ContainerDecoration.decoration(),
                          margin: const EdgeInsets.symmetric(vertical: 3.0),
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(children: [
                            _buildData(
                              "Coverage",
                              indexData.coverage,
                            ),
                            _buildData(
                              "Coverage Percentage",
                              indexData.coveragePercentage,
                            ),
                            _buildData(
                              "Productivity",
                              indexData.productivity,
                            ),
                            _buildData(
                              "Productivity Percentage",
                              indexData.productivityPercentage,
                            ),
                            _buildData(
                              "Remaining",
                              indexData.remaining,
                            ),
                            _buildData(
                              "Target",
                              indexData.target,
                            ),
                          ]),
                        );
                        //     // Padding(
                        //     //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                        //     //   child: Row(
                        //     //     children: [
                        //     //       Expanded(
                        //     //         child: Text(
                        //     //           "Total",
                        //     //           style: textFormTitleStyle,
                        //     //           textAlign: TextAlign.center,
                        //     //         ),
                        //     //       ),
                        //     //       Expanded(
                        //     //         child: Text(
                        //     //           state.totalBalance.toStringAsFixed(2),
                        //     //           style: textFormTitleStyle.copyWith(
                        //     //               color: Colors.black),
                        //     //           textAlign: TextAlign.center,
                        //     //         ),
                        //     //       ),
                        //     //     ],
                        //     //   ),
                        //     // ),
                        //   ],
                        // );
                      },
                    )
                  : const NoDataWidget(),
            ),
            if (state.isLoading) LoadingScreen.loadingScreen(),
          ],
        );
      },
    );
  }

  Widget _buildData(title, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: textFormTitleStyle,
            textAlign: TextAlign.start,
          ),
        ),
        const Expanded(child: Text(":", textAlign: TextAlign.center)),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.start,
          ),
        ),
      ]),
    );
  }
}
