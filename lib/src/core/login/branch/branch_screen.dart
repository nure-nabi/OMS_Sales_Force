import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/src/service/sharepref/get_all_pref.dart';
import 'package:oms_salesforce/src/service/sharepref/set_all_pref.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:provider/provider.dart';

import '../../../../theme/colors.dart';
import '../../../widgets/widgets.dart';
import 'branch_state.dart';
import 'model/branch_model.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen({super.key});

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  @override
  void initState() {
    Provider.of<BranchState>(context, listen: false).getContext = context;
    super.initState();
   // WidgetsBinding.instance.addPostFrameCallback((_) {context.read<BranchState>().context = context;});
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BranchState>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text("Unit List")),
          body: ListView.builder(
            itemCount: state.branchList.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildBranchInfo(state, state.branchList[index]);
            },
          ),
        ),
        if (state.isLoading) LoadingScreen.loadingScreen(),
      ],
    );
  }

  Widget _buildBranchInfo(BranchState state, BranchModelAgent branchInfo) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      padding: const EdgeInsets.all(8.0),
      decoration: ContainerDecoration.decoration(),
      child: InkWell(
        onTap: () async {
          await SetAllPref.unitCode(value: branchInfo.branchCode);
          await state.userSelectedBranch(branchInfo);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              branchInfo.branchCode,
              style: textFormTitleStyle.copyWith(
                fontSize: 20.0,
                color: primaryColor,
              ),
            ),
          //  if (branchInfo.unitShortName.isNotEmpty)
             // Text(branchInfo.unitShortName, style: subTitleTextStyle),
          ],
        ),
      ),
    );
  }
}
