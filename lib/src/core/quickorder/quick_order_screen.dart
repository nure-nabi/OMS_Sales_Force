import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/core/quickorder/model/filter_outlet_model.dart';
import 'package:oms_salesforce/src/core/quickorder/quick_order_state.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/src/service/sharepref/set_all_pref.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

class QuickOrderScreen extends StatefulWidget {
  const QuickOrderScreen({super.key});

  @override
  State<QuickOrderScreen> createState() => _QuickOrderScreenState();
}

class _QuickOrderScreenState extends State<QuickOrderScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<QuickOrderState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickOrderState>(
      builder: (context, state, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text("Quick Order")),
              body: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                physics: const BouncingScrollPhysics(),
                itemCount: state.routeList.length,
                itemBuilder: (context, index) {
                  FilterOutletInfoModel indexData = state.routeList[index];
                  return Container(
                    decoration: ContainerDecoration.decoration(),
                    margin: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 5.0),
                    child: InkWell(
                      onTap: () async {
                        state.getRouteName = indexData.routeDesc;
                        state.getRouteCode = indexData.routeCode;
                        Navigator.pushNamed(context, quickOrderOultetListPath);
                        await state.getOutletListFromDB();
                      },
                      child: Container(
                        color: indexData.routeStatus.isNotEmpty
                            ? productOrderColors
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                          child: ArrowListWidget(
                            child: Text(
                              indexData.routeDesc,
                              style: titleListTextStyle,
                            ),
                          ),
                          // child: Row(
                          //   children: [
                          //     Flexible(
                          //       child: Icon(
                          //         Icons.arrow_forward_ios_sharp,
                          //         size: 18.0,
                          //         color: hintColor,
                          //       ),
                          //     ),
                          //     horizantalSpace(5.0),
                          //     Flexible(
                          //       child: Text(
                          //         indexData.routeDesc,
                          //         style: titleListTextStyle,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            ///
            if (state.isLoading) LoadingScreen.loadingScreen(),
          ],
        );
      },
    );
  }
}
