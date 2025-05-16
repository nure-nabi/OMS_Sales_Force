import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/core/productavailabilityreport/product_availability_report_state.dart';
import 'package:oms_salesforce/theme/colors.dart';
import 'package:provider/provider.dart';

import '../../utils/loading_indicator.dart';
import '../../widgets/container_decoration.dart';
import '../../widgets/list_arrow_widget.dart';
import '../../widgets/no_data_widget.dart';
import 'model/product_avalability_report_model.dart';

class ProductAvailabilityProductQtyScreen extends StatefulWidget {
  final String pDesc;
  const ProductAvailabilityProductQtyScreen({super.key,required this.pDesc});

  @override
  State<ProductAvailabilityProductQtyScreen> createState() => _ProductAvailabilityProductQtyScreenState();
}

class _ProductAvailabilityProductQtyScreenState extends State<ProductAvailabilityProductQtyScreen> {
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
              appBar: AppBar(title:  Text(widget.pDesc)),
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
                        Expanded(child: Text("Qty",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),),
                      ],
                    ),
                  ),
                  Flexible(
                    child: state.productAvailabilityProductQtyList.isNotEmpty
                        ? ListView.builder(
                      itemCount: state.productAvailabilityProductQtyList.length,
                      itemBuilder: (context, index) {
                        ProductAvailabilityReportModel indexData = state.productAvailabilityProductQtyList[index];
                        return Container(
                          decoration: ContainerDecoration.decoration(),
                          margin: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 5.0),
                          child: InkWell(
                            onTap: () async {
                              //state.getSelectedProduct = indexData;
                            //  await state.onSelectedProduct(indexData.glDesc);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  flex:2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    child: Text(indexData.pDesc),
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    child: Text(indexData.pADate),
                                  ),
                                ),
                                Expanded(
                                  flex:1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    child: Text(indexData.qty),
                                  ),
                                ),

                              ],
                            )
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
                          Expanded(child: Text("Total",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
                          Expanded(child: Text(state.totalQty.toStringAsFixed(2),textAlign: TextAlign.right,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
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
