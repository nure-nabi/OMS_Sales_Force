import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/allreports/salesreturn/sales_return_state.dart';
import 'package:oms_salesforce/src/core/products/products.dart';
import 'package:oms_salesforce/src/utils/utils.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

class SalesReturnScreen extends StatefulWidget {
  const SalesReturnScreen({super.key});

  @override
  State<SalesReturnScreen> createState() => _SalesReturnScreenState();
}

class _SalesReturnScreenState extends State<SalesReturnScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<SalesReturnState>(context, listen: false).getContext = context;
  }




  @override
  Widget build(BuildContext context) {
    return Consumer<SalesReturnState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Sales Return")),
          // ///
          body: Column(
            children: [
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
        );
      },
    );
  }
}
