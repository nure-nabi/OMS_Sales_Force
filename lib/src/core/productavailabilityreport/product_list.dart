import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/core/productavailabilityreport/product_availability_product_screen.dart';
import 'package:oms_salesforce/src/core/productorder/productorder.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/core/quickorder/model/filter_outlet_model.dart';
import 'package:oms_salesforce/src/service/sharepref/set_all_pref.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/colors.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../table/product_table_screen.dart';


class ProductListAvailabilityScreen extends StatefulWidget {
  const ProductListAvailabilityScreen({super.key});

  @override
  State<ProductListAvailabilityScreen> createState() => _ProductListAvailabilityScreenState();
}

class _ProductListAvailabilityScreenState extends State<ProductListAvailabilityScreen> {


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
                    hintText: "Search Products",
                    hintStyle: hintTextStyle,
                    prefixIcon: Icons.search,
                  ),
                ),
              );
            },
          ),
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                           await SetAllPref.setProductName(value: productModel.pDesc);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductAvailabilityProductScreen()),
                            );

                         },
                          child: Container(
                            padding: EdgeInsets.all(10),
                           // mainAxisAlignment: MainAxisAlignment.start,
                            child:
                              Text(
                                productModel.pDesc,
                                style: productTitleTextStyle,
                              ),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                );
              },
            )
                : const NoDataWidget(),
          ),

        ],
      ),
    );
  }

}
