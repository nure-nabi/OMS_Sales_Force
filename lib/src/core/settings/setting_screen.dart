import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/settings/setting_state.dart';
import 'package:oms_salesforce/src/widgets/container_decoration.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SettingState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Setting")),
          bottomNavigationBar: ElevatedButton(
            child: const Text("Confirm"),
            onPressed: () {
              state.refreshPageToLogIn(context);
            },
          ),
          body: ListView(
            padding: const EdgeInsets.all(10.0),
            children: [
              ///
              optionDesign(
                title: "Show Smart Order",
                value: state.isShowSmartOrder,
                onChanged: (value) async {
                  state.getIsShowSmartOrder = value;
                },
              ),

              // ///
              // optionDesign(
              //   title: "Show Smart Order",
              //   value: state.isShowSmartOrder,
              //   onChanged: (value) async {
              //     state.getIsShowSmartOrder = value;
              //     await state.updateSmartOrder();
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget optionDesign({
    required String title,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: ContainerDecoration.decoration(),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title, style: titleTextStyle),
                ),
              ),
              Flexible(
                child: CupertinoSwitch(value: value, onChanged: onChanged),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
