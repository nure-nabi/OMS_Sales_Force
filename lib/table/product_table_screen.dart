import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../src/core/products/model/product_model.dart';
import '../src/core/products/product_state.dart';

class ProductInTable extends StatefulWidget {
  const ProductInTable({super.key});

  @override
  State<ProductInTable> createState() => _ProductInTableState();
}

class _ProductInTableState extends State<ProductInTable> {
  GlobalKey globalKey = GlobalKey();
  List<TableRow> tableRows = [];
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Show in Table"),
      ),
      body: Column(
        children:[
          Expanded(
              child: buildTable(state.productGroupTableList)),
    ]
      ),
    );
  }

  Widget buildTable(List<ProductGroupModel> productGroupModel){

    buildBillTable(productGroupModel);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: RepaintBoundary(
          key: globalKey,
          child: Table(
            border: TableBorder.all(width: 1, color: Colors.black),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: tableRows,
          ),
        ),
      ),
    );
  }

  buildBillTable(List<ProductGroupModel> productGroupList){

    tableRows.add(tableRowTitle());
    double totalAmount=0.0;
    for(var productGroupList in productGroupList){
      tableRows.add(
        tableRowProductData1(
            serialNo: '1',
            groupName: productGroupList.grpDesc,
            SubGroup: '',
            productName: ''
        ),
      );
      for(var productSubGroupList in productGroupList.productSubGroupList){
        tableRows.add(
          tableRowProductData1(
              serialNo: '',
              groupName: '',
              SubGroup: productSubGroupList.sGrpDesc,
              productName: ''
          ),
        );
        int index= 0;
        double grandTotal = 0.0;
        for(var productList in productSubGroupList.productList){
         // Fluttertoast.showToast(msg:  (index+1).toString());
          tableRows.add(
            tableRowProductData1(
                serialNo: (index+1).toString(),
                groupName: '',
                SubGroup: '',
                productName: productList.pDesc
            ),
          );
        //  List<String> allHeader = [];
         // Map<String,dynamic> list = productSubGroupList.productList.first as Map<String, dynamic>;
          List<String> exclusion = [
            'IsBold',
            'IsBoldL',
            'IsBoldA',
            'LedgerId',
          ];

        //  final List<String> basicHeaders = list.keys.where((e) => exclusion.contains(e) == false).map((e) => e).toList();
         // allHeader.addAll(basicHeaders);
        //  Fluttertoast.showToast(msg: basicHeaders.first);

          grandTotal += double.parse(productList.buyRate);
          totalAmount += grandTotal;
        }
        tableRows.add(tableTotal("Group Total",grandTotal));
      }
    }
    tableRows.add(tableTotal("Grand Total",totalAmount));
  }

  TableRow tableRowTitle() {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.black54),
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'S.N',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Group',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Sub Group',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Product Name',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
  TableRow tableRowProductData1({
    required String serialNo,
    required String groupName,
    required String SubGroup,
    required String productName,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TableRowInkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serialNo.toString(),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 14.5, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TableRowInkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupName.toString(),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TableRowInkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  SubGroup.toString(),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TableRowInkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName.toString(),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }

  TableRow tableTotal(String title,double total) {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.black54),
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      SizedBox(),
      SizedBox(),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            total.toStringAsFixed(2),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );

  }
}
