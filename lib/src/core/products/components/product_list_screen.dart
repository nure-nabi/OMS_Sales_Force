import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/core/productorder/productorder.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/core/quickorder/model/filter_outlet_model.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/colors.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../table/product_table_screen.dart';
import '../../../service/router/route_name.dart';
import '../../quickorder/quick_order_state.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductState>();
    final statee = context.watch<ProductOrderState>();
    Provider.of<ProductOrderState>(context, listen: false)
        .getAllTempProductOrderList();
    return Scaffold(
      appBar: AppBar(title: Text(state.selectedGroup.grpDesc)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (statee.allTempOrderList.isNotEmpty) {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                // child: const ProductInTable(),
                child: const OrderListSection(),
              ),
            );
          }else{
            Fluttertoast.showToast(msg: "No available any order");
          }
        },
        child: const Icon(Icons.done_all),
      ),
      body: Column(
        children: [
          StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onChanged: (value) {
                    state.filterProduct = value;
                    setState(() {});
                  },
                  decoration: TextFormDecoration.decoration(
                    hintText: "Search Product",
                    hintStyle: hintTextStyle,
                    prefixIcon: Icons.search,
                  ),
                ),
              );
            },
          ),
          // ///
          // TableHeaderWidget(
          //   child: Row(children: [
          //     Expanded(
          //       child: Text("Name", style: tableHeaderTextStyle),
          //     ),
          //     Expanded(
          //       child: Text("Quantity",
          //           style: tableHeaderTextStyle, textAlign: TextAlign.end),
          //     ),
          //     Expanded(
          //       child: Text("Price",
          //           style: tableHeaderTextStyle, textAlign: TextAlign.end),
          //     ),
          //   ]),
          // ),

          ///
          Flexible(
            child: state.filterProductList.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              itemCount: state.filterProductList.length,
              itemBuilder: (context, index) {
                FilterProductModel productModel =
                state.filterProductList[index];
                return StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return TableDataWidget(
                      color: productModel.tempPCode.isNotEmpty ||
                          productModel.orderPCode.isNotEmpty
                          ? productOrderColor
                          : null,
                      onTap: () async {
                        await showAlert(context, index);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            productModel.pDesc,
                            style: productTitleTextStyle,
                          ),
                          verticalSpace(8.0),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // decoration:
                                  // ContainerDecoration.decoration(
                                  //   color: successColor,
                                  //   bColor: successColor,
                                  //   borderRadius:
                                  //   BorderRadius.circular(0.0),
                                  // ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      productModel.pShortName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  decoration:
                                  ContainerDecoration.decoration(
                                    color: successColor,
                                    bColor: successColor,
                                    borderRadius:
                                    BorderRadius.circular(0.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      productModel.stockBalance,
                                      textAlign: TextAlign.end,
                                      style: whiteTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Price =>",
                                  textAlign: TextAlign.end,
                                  style: titleListTextStyle,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  productModel.mrp,
                                  textAlign: TextAlign.end,
                                  style: titleListTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            )
                : const NoDataWidget(),
          ),

          // Container(
          //   color: successColor,
          //   height: 2.0,
          //   margin: const EdgeInsets.symmetric(vertical: 5.0),
          // ),

          ///
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: state.orderList.length,
          //     itemBuilder: (context, index) {
          //       // bool isAvailable =
          //       // state.checkProduct(state.filterProductList[index].pCode);
          //       return TableDataWidget(
          //         onTap: () async {
          //           // await showAlert(context, index);
          //         },
          //         // color:
          //         //     isAvailable ? successColor.withOpacity(0.5) : errorColor,
          //         child: Row(
          //           children: [
          //             Expanded(
          //               child: Text(
          //                 state.orderList[index].alias,
          //               ),
          //             ),
          //             Expanded(
          //               child: Text(
          //                 state.orderList[index].quantity,
          //                 textAlign: TextAlign.end,
          //               ),
          //             ),
          //             Expanded(
          //               child: Text(
          //                 state.orderList[index].rate,
          //                 textAlign: TextAlign.end,
          //               ),
          //             ),
          //             Expanded(
          //               child: Text(
          //                 state.orderList[index].totalAmount,
          //                 textAlign: TextAlign.end,
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  showAlert(context, index) {
    final state = Provider.of<ProductState>(context, listen: false);
    final orderState = Provider.of<ProductOrderState>(context, listen: false);

    orderState.clear();

    orderState.getProductDetails = state.filterProductList[index];
    orderState.getSalesRate = state.filterProductList[index].salesRate;
    orderState.getTotalVat = 0.00;
    orderState.getTotalAlt = (double.parse(state.filterProductList[index].qty) * double.parse(state.filterProductList[index].altQty));
    orderState.getTotalPriceWithVat = 0.00;
    ///
    ShowAlert(context).alert(child: const ProductOrderScreen());
  }
}
