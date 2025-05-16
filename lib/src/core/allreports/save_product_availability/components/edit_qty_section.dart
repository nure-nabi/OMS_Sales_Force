import 'package:flutter/material.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../../utils/show_toast.dart';
import '../../../../widgets/widgets.dart';
import '../db/save_product_availability_db.dart';
import '../model/save_product_availability_model.dart';
import '../save_product_availability.dart';

class EditProductQtySection extends StatefulWidget {
  final SaveProductAvailabilityModel productModel;

  const EditProductQtySection({super.key, required this.productModel});

  @override
  State<EditProductQtySection> createState() => _EditProductQtySectionState();
}

class _EditProductQtySectionState extends State<EditProductQtySection> {
  late final TextEditingController _updateQty =
      TextEditingController(text: widget.productModel.qty);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SaveProductAvailabilityState>();

    return CustomAlertWidget(
      title: "Update Qty",
      showCancle: true,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.productModel.productName, style: titleTextStyle),
            const SizedBox(height: 5.0),
            TextFieldFormat(
              textFieldName: 'QTY',
              textFormField: TextFormField(
                controller: _updateQty,
                keyboardType: TextInputType.number,
                decoration: TextFormDecoration.decoration(
                  hintText: "QTY",
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  late final NavigatorState navigator = Navigator.of(context);
                  Future.delayed(const Duration(milliseconds: 100));
                  await SaveProductAvailabilityDatabase.instance.updateQtyById(
                    itemCode: widget.productModel.itemCode,
                    qty: _updateQty.text,
                  );
                  await state.getAddProductList();
                  navigator.pop();
                  ShowToast.successToast(msg: "Qty Updated Successfully");
                },
                child: const Text("UPDATE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
