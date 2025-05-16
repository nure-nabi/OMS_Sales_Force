import 'package:flutter/material.dart';
import 'package:oms_salesforce/theme/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/fonts_style.dart';
import '../../../../widgets/widgets.dart';
import '../model/save_product_availability_model.dart';
import '../save_product_availability.dart';
import 'edit_qty_section.dart';

class SaveProductAvailabilityListScreen extends StatelessWidget {
  const SaveProductAvailabilityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SaveProductAvailabilityState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Availability Details"),
        actions: [
          IconButton(
            onPressed: () async {
              await state.shareInPFD();
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: FloatingActionButton.extended(
                heroTag: "SAVE",
                onPressed: () async {
                  await state.onUpdateButtonSave();
                },
                label: const Text("SAVE"),
                icon: const Icon(Icons.save),
              ),
            ),
            const SizedBox(width: 10.0),
            Flexible(
              child: FloatingActionButton.extended(
                heroTag: "SAVE_AND_SHARE",
                backgroundColor: successColor,
                onPressed: () async {
                  await state.onUpdateButtonSave(isPrint: true);
                },
                label: const Text("SAVE AND SHARE"),
                icon: const Icon(Icons.send_and_archive_sharp),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: state.saveProductList.length,
        itemBuilder: (BuildContext context, int index) {
          SaveProductAvailabilityModel productModel =
              state.saveProductList[index];
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return _buildListInfo(context, state, productModel);
            },
          );
        },
      ),
    );
  }

  Widget _buildListInfo(
    BuildContext context,
    SaveProductAvailabilityState state,
    SaveProductAvailabilityModel productModel,
  ) {
    return TableDataWidget(
      onTap: () async {
        await ShowAlert(context).alert(
          child: EditProductQtySection(productModel: productModel),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  productModel.productName,
                  style: productTitleTextStyle,
                ),
                Text(
                  "MRP => ${productModel.price}",
                  textAlign: TextAlign.end,
                  style: hintTextStyle,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              "QTY => ${productModel.qty}",
              textAlign: TextAlign.end,
              style: titleListTextStyle,
            ),
          ),

          ///
          const Flexible(child: Icon(Icons.edit, color: Colors.blue)),
        ],
      ),
    );
  }
}
