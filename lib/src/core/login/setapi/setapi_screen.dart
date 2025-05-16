import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../../theme/theme.dart';
import '../../../widgets/menu_card_widget.dart';
import 'setapi_state.dart';
import 'package:device_imei/device_imei.dart';
import 'package:permission_handler/permission_handler.dart';

class SetAPISection extends StatefulWidget {
  const SetAPISection({super.key});

  @override
  State<SetAPISection> createState() => _SetAPISectionState();
}

class _SetAPISectionState extends State<SetAPISection>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    context.read<SetAPIState>().getContext = context;
    initController();
  }

  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 300);
    controller.reverseDuration = const Duration(milliseconds: 300);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final state = context.watch<SetAPIState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Domain")),
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: state.myDomainList.length,
          itemBuilder: (context, index) {
            return MenuCardWidget(
              title: state.myDomainList[index],
              onTap: () async {
                state.isShowConfirmHost = false;
                state.hostController.text = "";
                state.confirmHostController.text = "";
                state.getMyDomain = state.myDomainList[index];
                await showModalBottomSheet(
                  transitionAnimationController: controller,
                  context: context,
                  isScrollControlled: true,
                  builder: (builder) {
                    return const ButtonSheetSection();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ButtonSheetSection extends StatelessWidget {
  const ButtonSheetSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SetAPIState>();
    double screenHeight = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: screenHeight / 1.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20.0),
          Text(
            state.selectedDomain,
            style: titleTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Form(
            key: state.hostKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: state.hostController,
                decoration: InputDecoration(
                  hintText: 'Host Name',
                  hintStyle: hintTextStyle,
                  labelText: 'Enter Host Name',
                  labelStyle: labelTextStyle,
                ),
                onChanged: (text) {
                  state.hostKey.currentState!.validate();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return '* required';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          if (!state.isShowConfirmHost)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  state.checkHost();
                },
                child: const Text("CHECK"),
              ),
            ),
          const SizedBox(height: 20.0),
          if (state.isShowConfirmHost) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: state.confirmHostController,
                decoration: const InputDecoration(
                  labelText: 'Your Host Name',
                  labelStyle: labelTextStyle,
                ),
                onChanged: (text) {
                  state.hostKey.currentState!.validate();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return '* required';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: state.confirmLinkController,
                decoration: const InputDecoration(
                  labelText: 'Link Report',
                  labelStyle: labelTextStyle,
                ),
                onChanged: (text) {
                  state.hostKey.currentState!.validate();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return '* required';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            // const SizedBox(height: 10.0),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //   child: TextFormField(
            //     controller: state.confirmHostController,
            //     decoration: const InputDecoration(
            //       labelText: 'Your Host Name',
            //       labelStyle: labelTextStyle,
            //     ),
            //     onChanged: (text) {
            //       state.hostKey.currentState!.validate();
            //     },
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return '* required';
            //       } else {
            //         return null;
            //       }
            //     },
            //   ),
            // ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await state.setAPI();
                },
                child: const Text("CONFIRM"),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
