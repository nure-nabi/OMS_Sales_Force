import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_salesforce/config/app_detail.dart';
import 'package:oms_salesforce/src/constant/constant.dart';
import 'package:oms_salesforce/src/service/sharepref/get_all_pref.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/container_decoration.dart';
import 'package:oms_salesforce/src/widgets/space.dart';
import 'package:provider/provider.dart';

import 'component/drawer.dart';
import 'component/grid_section.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    ///
    Provider.of<HomeState>(context, listen: false).getContext = context;
  }

  @override
  void dispose() {
    super.dispose();
  }

  onBack() async {
    await SystemNavigator.pop();
  }


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return WillPopScope(
      onWillPop: () {
        return onBack();
      },
      child: Consumer<HomeState>(
        builder: (context, state, child) {
          return Stack(children: [
            Scaffold(
              appBar: AppBar(title: Text(AppDetails.appName), actions: [

                // IconButton(
                //   onPressed: () async {
                //     await state.downloadButton();
                //   },
                //   icon: const Icon(Icons.download_outlined),
                // ),
                IconButton(
                  onPressed: () async {
                    await state.uploadButton();
                  },
                  icon: const Icon(Icons.upload_outlined),
                ),
                horizantalSpace(5),
              ]),
              drawer: const DrawerSection(),
              body: ListView(
                  // shrinkWrap: true,
                  // physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      decoration: ContainerDecoration.decoration(),
                      child: Image.asset(
                        AssetsList.bannerImage,
                        height: screenWidth < 600 ? height / 5 : height / 4,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const HomeGridSection(),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final state =
                    //         Provider.of<ProductOrderState>(context, listen: false);
                    //     await state.getDataFromOrderTable();
                    //   },
                    //   child: const Text("CLICK"),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final state =
                    //         Provider.of<ProductOrderState>(context, listen: false);
                    //     await state.getFormatPOSTDATA();
                    //   },
                    //   child: const Text("CLICK"),
                    // )
                  ]),
            ),
            if (state.isLoading) LoadingScreen.loadingScreen(),
          ]);
        },
      ),
    );
  }
}
