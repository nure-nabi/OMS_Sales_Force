import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/quickorder/quick_order_state.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/src/service/sharepref/set_all_pref.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../model/filter_outlet_model.dart';

class OutletListScreen extends StatelessWidget {
  const OutletListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuickOrderState>();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              state.isAreaShow ? "Smart Order" : state.selectedRouteName,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              ///
              await state.clearFieldToAddNewOutlet().whenComplete(() {
                Navigator.pushNamed(context, addOutletPath);
              });
            },
            child: const Icon(Icons.add),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              StatefulBuilder(
                builder: (context, setState) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        state.filterOutletGroup = value;
                        setState(() {});
                      },
                      decoration: TextFormDecoration.decoration(
                        hintText: "Search Outlets",
                        hintStyle: hintTextStyle,
                        prefixIcon: Icons.search,
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: ListView.builder(
                  // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  itemCount: state.filterOutletList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    FilterOutletInfoModel indexData =
                        state.filterOutletList[index];
                    return (indexData.glCode.isNotEmpty &&
                            indexData.glDesc.isNotEmpty)
                        ? Container(
                            decoration: ContainerDecoration.decoration(
                              color: indexData.outletStatus.isNotEmpty
                                  ? productOrderColors
                                  : null,
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 5.0,
                            ),
                            child: InkWell(
                              onTap: () async{
                                Navigator.pushNamed(
                                  context,
                                  productGroupListPath,
                                  arguments: indexData,);
                              await  SetAllPref.setOutLetName(value: indexData.outletDesc);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(indexData.outletDesc),
                                    verticalSpace(10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  indexData.outletPerson,
                                                  style: hintTextStyle.copyWith(
                                                      fontSize: 12.0),
                                                ),
                                              ),
                                              horizantalSpace(5.0),
                                              Flexible(
                                                child: Text(
                                                  " (${indexData.mobileNo})",
                                                  style: hintTextStyle.copyWith(
                                                      fontSize: 12.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (indexData.balance.isNotEmpty)
                                          Expanded(
                                            child: Text(
                                              indexData.balance,
                                              style: titleListTextStyle,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        // : const NoDataWidget(
                        //     text: "No outlet has been created.",
                        //   );
                        : const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
        if (state.isLoading) LoadingScreen.loadingScreen(),
      ],
    );
  }
}
