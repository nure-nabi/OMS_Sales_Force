import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'sales_return_list_screen.dart';
import 'sales_return_product_order_screen.dart';
import 'sales_return_state.dart';

class SalesReturnProductScreen extends StatelessWidget {
  const SalesReturnProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SalesReturnState>();
    return Scaffold(
      appBar: AppBar(title: Text(state.selectedGroup.grpDesc)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: const SalesReturnListSection(),
            ),
          );
        },
        child: const Icon(Icons.done_all),
      ),
      body: Column(
        children: [
          ///
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.productList.length,
              itemBuilder: (context, index) {
                FilterProductModel productModel = state.productList[index];

                return StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return TableDataWidget(
                      color: productModel.tempPCode.isNotEmpty ||
                              productModel.orderPCode.isNotEmpty
                          ? productOrderColor
                          : null,
                      onTap: () async {
                        await showAlert(context, index, state: state);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            productModel.alias,
                            style: productTitleTextStyle,
                          ),
                          verticalSpace(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  decoration: ContainerDecoration.decoration(
                                    color: successColor,
                                    bColor: successColor,
                                    borderRadius: BorderRadius.circular(0.0),
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
                                flex: 2,
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
            ),
          ),
        ],
      ),
    );
  }

  showAlert(context, index, {required SalesReturnState state}) {
    state.getProductDetails = state.productList[index];

    ///
    ShowAlert(context).alert(child: const SalesReturnProductOrderScreen());
  }
}
