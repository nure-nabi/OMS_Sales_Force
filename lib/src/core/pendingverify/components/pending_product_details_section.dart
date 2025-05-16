import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/pendingverify/pendingverify.dart';
import 'package:oms_salesforce/src/widgets/custom_divider.dart';
import 'package:oms_salesforce/src/widgets/tablewidgets/data_table.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:provider/provider.dart';

class PendingProductDetailsSection extends StatelessWidget {
  const PendingProductDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PendingVerifyState>();
    return Scaffold(
      appBar: AppBar(title: Text(state.selectedOutlet.glDesc)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.selectedOutlet.glDesc,
                      style: productTitleTextStyle),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Text("${state.productList.length} SKUS"),
                          ),
                          Flexible(child: Text("${state.brandCount} Brands")),
                          Expanded(child: Text("Total: ${state.totalBalance}")),
                        ]),
                  ),
                ]),
            const CustomDottedDivider(color: Colors.black),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.productList.length,
                itemBuilder: (context, index) {
                  PendingVerifyDataModel indexData = state.productList[index];
                  return TableDataWidget(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: Text(
                                indexData.itemName,
                                style: hintTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Qty: ${indexData.qty}",
                                  style: hintTextStyle,
                                ),
                                Text(
                                  "Rs: ${indexData.rate}",
                                  style: hintTextStyle,
                                ),
                              ],
                            ),
                          )
                        ]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
