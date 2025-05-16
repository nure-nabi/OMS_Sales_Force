import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/imagepicker/imagepicker.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'click_image_state.dart';

class ClickImageScreen extends StatefulWidget {
  const ClickImageScreen({super.key});

  @override
  State<ClickImageScreen> createState() => _ClickImageScreenState();
}

class _ClickImageScreenState extends State<ClickImageScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ClickImageState>(context, listen: false).getContext = context;
    Provider.of<ImagePickerState>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final imageState = context.watch<ImagePickerState>();
    return Consumer<ClickImageState>(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: CustomAlertWidget(
                  title: "Save Image",
                  showCancle: true,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                bottom: 10.0,
                              ),
                              color: Colors.white,
                              child: const ImagePickerScreen(
                                isHeaderShow: false,
                                isPickFromGallery: false,
                                imageWidth: 200.0,
                                imageHeight: 200.0,
                                isCropperEnable: true,
                              ),
                            ),

                            ///
                            if (imageState.myPickedImage.isNotEmpty) ...[
                              TextFormField(
                                controller: state.remarks,
                                autofocus: true,
                                onChanged: (text) {},
                                decoration: TextFormDecoration.decoration(
                                    hintText: "Remarks"),
                              ),
                              ElevatedButton(
                                onPressed: state.isLoading
                                    ? null
                                    : () async {
                                        await state.onConfirm();
                                      },
                                child: const Text("SUBMIT"),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (state.isLoading) LoadingScreen.loadingScreen(),
                    ],
                  ),
                ),
              ),
              // if (state.isLoading) LoadingScreen.loadingScreen()
            ],
          ),
        );
      },
    );
  }
}
