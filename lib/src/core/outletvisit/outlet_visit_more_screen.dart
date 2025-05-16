import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/outletvisit/outletvisit.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../widgets/widgets.dart';

class OutletVisitMoreScreen extends StatelessWidget {
  const OutletVisitMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OutletVisitState>();
    return Scaffold(
      appBar: AppBar(title: Text(state.selectedOutlet.glDesc)),
      body: ListView.builder(
        itemCount: state.outletVisitMoreList.length,
        itemBuilder: (BuildContext context, int index) {
          OutletVisitDataModel indexData = state.outletVisitMoreList[index];
          return Container(
            decoration: ContainerDecoration.decoration(
              color: index % 2 == 0 ? Colors.white : Colors.blueGrey.shade100,
            ),
            margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Column(
              children: [
                _buildData(
                  "Visit Date",
                  indexData.visitTime.substring(0, 10),
                ),
                _buildData("Sales Qty", "${indexData.qty}"),
                _buildData("Sales Amt", "${indexData.amt}"),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildData(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: textFormTitleStyle,
            textAlign: TextAlign.start,
          ),
        ),
        const Expanded(child: Text(":", textAlign: TextAlign.center)),
        Expanded(
          flex: 4,
          child: Text(
            value,
            textAlign: TextAlign.start,
          ),
        ),
      ]),
    );
  }
}
