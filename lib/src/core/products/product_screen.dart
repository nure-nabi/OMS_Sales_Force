import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/core/quickorder/quickorder.dart';
import 'package:oms_salesforce/src/service/sharepref/get_all_pref.dart';
import 'package:oms_salesforce/src/utils/custom_log.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../productorder/components/order_list_section.dart';
import '../productorder/db/temp_product_order_db.dart';
import '../productorder/product_order_state.dart';
import 'components/product_bottom_navigation_section.dart';

class ProductScreen extends StatefulWidget {
  final FilterOutletInfoModel outletDetails;
  const ProductScreen({super.key, required this.outletDetails});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    outletNameShow();
    Provider.of<ProductState>(context, listen: false).getContext = context;
    Provider.of<ProductState>(context, listen: false).getOutletDetail = widget.outletDetails;
    Provider.of<ProductOrderState>(context, listen: false).getAllTempProductOrderList();
  }

  String outletName = "";

  outletNameShow() async{
    outletName = await GetAllPref.getOutLetName();
  }


  Future<bool> onBackFromTempList() async {
    return await ShowAlert(context).alert(
      child: ConfirmationWidget(
        title: "PLEASE CONFIRM YOUR ORDER ?",
        description: "Otherwise order will get cleared.",
        onCancel: () async {
          await TempProductOrderDatabase.instance.deleteData().whenComplete(() {
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   homePagePath,
            //       (route) => true,
            // );
            Navigator.of(context).pop(true);
          });
        },
        onConfirm: () {
          //  Navigator.popAndPushNamed(context, orderConfirmPath);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderListSection(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statee = context.watch<ProductOrderState>();
    Provider.of<ProductOrderState>(context, listen: false)
        .getAllTempProductOrderList();
    return Consumer<ProductState>(builder: (context, state, child) {
      return Stack(children: [
        WillPopScope(
          onWillPop: (statee.allTempOrderList.isNotEmpty)
              ? () {
            return onBackFromTempList();
          }
              : null,
          child: Scaffold(
            appBar: AppBar(
                title: Text(outletName),
              actions: [
                IconButton(
                  onPressed: () {
                    state.deleteData();
                    state.init();
                  },
                  icon: const Icon(Icons.sync),
                ),
              ],
            ),
            //
            bottomNavigationBar: const ProductBottomNavigationSection(),
            // ///
            body: Column(
              children: [
                verticalSpace(10.0),
                Text("Product Brand", style: titleListTextStyle),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onChanged: (value) {
                      state.filterProductGroup = value;
                      setState(() {});
                    },
                    decoration: TextFormDecoration.decoration(
                      hintText: "Search Product Groups",
                      hintStyle: hintTextStyle,
                      prefixIcon: Icons.search,
                    ),
                  ),
                ),
                Expanded(
                  child: state.filterGroupList.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.filterGroupList.length,
                          itemBuilder: (context, index) {
                            FilterProductModel indexData =
                                state.filterGroupList[index];
                            return Container(
                              decoration: ContainerDecoration.decoration(),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 5.0),
                              child: InkWell(
                                onTap: () async {
                                  CustomLog.actionLog(
                                    value: "Index Tapped => ${indexData.grpDesc}",
                                  );
                                  state.getSelectedGroup = indexData;
                                  await state.groupSelected();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 12.0),
                                  child: ArrowListWidget(
                                    child: Text(
                                      indexData.grpDesc,
                                      style: titleListTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const NoDataWidget(),
                )
              ],
            ),
          ),
        ),
        if (state.isLoading) LoadingScreen.loadingScreen(),
      ]);
    });
  }
}
