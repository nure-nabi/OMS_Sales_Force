import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/core/productavailabilityreport/product_availability_report_state.dart';
import 'package:provider/provider.dart';

import '../../../theme/colors.dart';
import '../../utils/loading_indicator.dart';
import '../../widgets/container_decoration.dart';
import '../../widgets/list_arrow_widget.dart';
import '../../widgets/no_data_widget.dart';
import 'model/product_avalability_report_model.dart';

class ProductAvailabilityDetailsScreen extends StatefulWidget {
  final String glDesc;
  const ProductAvailabilityDetailsScreen({super.key,required this.glDesc});

  @override
  State<ProductAvailabilityDetailsScreen> createState() => _ProductAvailabilityDetailsScreenState();
}

class _ProductAvailabilityDetailsScreenState extends State<ProductAvailabilityDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductAvailabilityReportState>(
      builder: (context, state, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title:  Text(widget.glDesc)),
              body: Column(

                children: [
                  Container(
                    margin:EdgeInsets.all(5),
                    padding: EdgeInsets.all(8),
                    color : Colors.blue,
                    child: const Row(
                      children: [
                        Expanded(child: Text("Item",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                        Expanded(child: Text("Date",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),),
                        Expanded(child: Text("Pre",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),),
                        Expanded(child: Text("Last",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),),
                        Expanded(child: Text("Bal",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: state.productAvailabilityReportList.isNotEmpty
                        ? ListView.builder(
                      itemCount: state.productAvailabilityReportList.length,
                      itemBuilder: (context, index) {
                        ProductAvailabilityReportModel indexData = state.productAvailabilityReportList[index];

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
                            //  state.getSelectedProduct = indexData;
                             // await state.onSelectedProduct(indexData.pDesc);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 0),
                                    child: Text(indexData.pDesc,style: const TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    child: Text(indexData.pADate),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    child: Text(indexData.qty),
                                  ),
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    child: Text("0.0"),
                                  ),
                                ),
                                 Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    child: Text(indexData.qty),
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
                  Container(
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text("Total",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                            Expanded(child: Text((state.qty1 - state.qty2).toStringAsFixed(2),textAlign: TextAlign.right,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                          ],
                        ),),
                    ),
                  )
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
