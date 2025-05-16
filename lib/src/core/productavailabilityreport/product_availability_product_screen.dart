import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/core/productavailabilityreport/product_availability_report_state.dart';
import 'package:provider/provider.dart';

import '../../utils/loading_indicator.dart';
import '../../widgets/container_decoration.dart';
import '../../widgets/list_arrow_widget.dart';
import '../../widgets/no_data_widget.dart';
import 'model/product_avalability_report_model.dart';

class ProductAvailabilityProductScreen extends StatefulWidget {
  const ProductAvailabilityProductScreen({super.key});

  @override
  State<ProductAvailabilityProductScreen> createState() => _ProductAvailabilityProductScreenState();
}

class _ProductAvailabilityProductScreenState extends State<ProductAvailabilityProductScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductAvailabilityReportState>(context, listen: false).getContext = context;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductAvailabilityReportState>(
      builder: (context, state, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text("Customer Name")),
              body: Column(
                children: [
                  Expanded(
                    child: state.glDescList.isNotEmpty
                        ? ListView.builder(
                      itemCount: state.glDescList.length,
                      itemBuilder: (context, index) {
                        ProductAvailabilityReportModel indexData = state.glDescList[index];

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
                              state.getSelectedGlDesc = indexData;
                              await state.onSelectedGlDesc(indexData.glDesc);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15.0),
                                  child: ArrowListWidget(
                                    child: Text(indexData.glDesc),
                                  ),
                                ),

                              ],
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
