import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme.dart';
import '../../../widgets/widgets.dart';
import '../../productavailabilityreport/product_availability_group.dart';
import '../../products/products.dart';
import 'components/save_product_availability_list_screen.dart';
import 'save_product_availability.dart';

class SaveProductAvailabilityScreen extends StatefulWidget {
  const SaveProductAvailabilityScreen({super.key});

  @override
  State<SaveProductAvailabilityScreen> createState() =>
      _SaveProductAvailabilityScreenState();
}

class _SaveProductAvailabilityScreenState
    extends State<SaveProductAvailabilityScreen> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    context.read<SaveProductAvailabilityState>().context = context;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SaveProductAvailabilityState>(
      builder: (BuildContext context, state, Widget? child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text("Product Availability"),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProductAvailabilityGroupScreen()),
                      );
                    },
                    icon: const Icon(Icons.info_outline),
                  ),
                ],
              ),
              bottomSheet: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    if (state.saveProductList.isNotEmpty) ...[
                      Expanded(
                        child: FloatingActionButton.extended(
                          backgroundColor: successColor,
                          heroTag: "LIST",
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SaveProductAvailabilityListScreen(),
                              ),
                            );
                          },
                          label: const Text("View Products"),
                          icon: const Icon(Icons.list),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                    ],
                    Expanded(
                      child: FloatingActionButton.extended(
                        heroTag: "ADD",
                        onPressed: () async {
                          await state.addProduct();
                        },
                        label: const Text("Add Product"),
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: state.productList.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.productList.length,
                            itemBuilder: (BuildContext context, int index) {
                              FilterProductModel productModel =
                                  state.productList[index];
                              return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return _buildListInfo(
                                      state, productModel, index);
                                },
                              );
                            },
                          )
                        : const NoDataWidget(),
                  ),
                  const SizedBox(height: 70.0),
                ],
              ),
            ),
            if (state.isLoading) LoadingScreen.loadingScreen(),
          ],
        );
      },
    );
  }

  Widget _buildListInfo(
    SaveProductAvailabilityState state,
    FilterProductModel productModel,
    int index,
  ) {
    return FutureBuilder(
      future: state.checkAlreadyExist(productModel.pCode),
      builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
        Color color = snapshot.data == true ? Colors.orange : Colors.white;
        return TableDataWidget(
          onTap: null,
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      productModel.alias,
                      style: productTitleTextStyle,
                    ),
                    Text(
                      "MRP => ${productModel.mrp}",
                      textAlign: TextAlign.end,
                      style: titleListTextStyle,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: _buildTextFormField(
                  state,
                  productModel,
                  index,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextFormField(
    SaveProductAvailabilityState state,
    FilterProductModel productModel,
    int index,
  ) {
    return FutureBuilder<String>(
      future: state.getQtyByPCode(productModel.pCode),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        return snapshot.data == null
            ? TextFormField(
                controller: state.controller[index],
                keyboardType: TextInputType.number,
                decoration: TextFormDecoration.decoration(
                  hintText: "QTY",
                ),
              )
            : Column(
                children: [
                  Text(
                    "Added QTY ",
                    style: subTitleTextStyle.copyWith(color: Colors.white),
                  ),
                  Text(
                    "${snapshot.data}",
                    style: titleTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
