import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/constant/constant.dart';
import 'package:oms_salesforce/src/core/allreports/questions/questions.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../enum/enumerator.dart';
import '../../allreports/allreports.dart';
import '../../top_buying/top_buying.dart';
import '../home_state.dart';

class HomeGridSection extends StatelessWidget {
  const HomeGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeState>();

    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Row(
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.leaveNotes,
                name: "Add Leave",
                onTap: () async {
                  await NavigationHelper(context).indexNavigation(
                    indexEnum: HomePageGridEnum.addLeave,
                  );
                },
              ),
            ),
            state.isShowSmartOrder
                ? Expanded(
                    child: GridWidget(
                      image: AssetsList.smartOrder,
                      name: "Smart Order",
                      onTap: () async {
                        await NavigationHelper(context).indexNavigation(
                          indexEnum: HomePageGridEnum.smartOrder,
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: GridWidget(
                      image: AssetsList.quickOrder,
                      name: "Quick Order",
                      onTap: () async {
                        await NavigationHelper(context).indexNavigation(
                          indexEnum: HomePageGridEnum.quickOrder,
                        );
                      },
                    ),
                  )
          ],
        ),

        ///
        Row(
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.pendingSync,
                name: "Pending Sync",
                onTap: () async {
                  await NavigationHelper(context).indexNavigation(
                    indexEnum: HomePageGridEnum.pendingSync,
                  );
                },
              ),
            ),
            Expanded(
              child: GridWidget(
                image: AssetsList.pendingVerified,
                name: "Pending Verify",
                onTap: () async {
                  await NavigationHelper(context).indexNavigation(
                    indexEnum: HomePageGridEnum.pendingVerify,
                  );
                },
              ),
            ),
          ],
        ),

        ///
        Row(
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.targetIcon,
                name: "Target And Achievement",
                onTap: () async {
                  await NavigationHelper(context).indexNavigation(
                    indexEnum: HomePageGridEnum.targetAndAchivement,
                  );
                },
              ),
            ),
            Expanded(
              child: GridWidget(
                image: AssetsList.productivityIcon,
                name: "Coverage And Productivity",
                onTap: () async {
                  await NavigationHelper(context).indexNavigation(
                    indexEnum: HomePageGridEnum.coverageAndProductivity,
                  );
                },
              ),
            ),
          ],
        ),

        ///
        Row(
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.deliveredReport,
                name: "Delivered Report",
                onTap: () async {
                  await NavigationHelper(context).indexNavigation(
                    indexEnum: HomePageGridEnum.deliveredReport,
                  );
                },
              ),
            ),
            Expanded(
              child: GridWidget(
                image: AssetsList.orderReport,
                name: "Order Report",
                onTap: () async {
                  await NavigationHelper(context).indexNavigation(
                    indexEnum: HomePageGridEnum.orderReport,
                  );
                },
              ),
            ),
          ],
        ),

        ///
        // Row(
        //   children: [
        //     Expanded(
        //       child: GridWidget(
        //         image: AssetsList.movementGPS,
        //         name: "Movement GPS",
        //         onTap: () async {
        //           await NavigationHelper(context).indexNavigation(
        //             indexEnum: HomePageGridEnum.movementGps,
        //           );
        //         },
        //       ),
        //     ),
        //     Expanded(
        //       child: GridWidget(
        //         image: AssetsList.activityGPS,
        //         name: "Activity GPS",
        //         onTap: () async {
        //           await NavigationHelper(context).indexNavigation(
        //             indexEnum: HomePageGridEnum.activityGps,
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),

        ///
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.pdcReport,
                name: "PDC Report",
                onTap: () async {
                  context.read<PDCState>().getCustomerFilter = false;
                  Navigator.pushNamed(context, pdcReportPath);
                },
              ),
            ),
            Expanded(
              child: GridWidget(
                image: AssetsList.topBuying,
                name: "Top Buying",
                onTap: () async {
                  context.read<TopBuyingState>().isFromIndex = true;
                  Navigator.pushNamed(context, topBuyingPath);
                },
              ),
            ),
          ],
        ),

        ///
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.todo,
                name: "TO-DO",
                onTap: () async {
                  Navigator.pushNamed(context, todoList);
                },
              ),
            ),
            // const Expanded(child: SizedBox.shrink()),
            Expanded(
              child: GridWidget(
                image: AssetsList.outletVisit,
                name: "Outlet Visit",
                onTap: () async {
                  // context.read<TopBuyingState>().isFromIndex = true;
                  Navigator.pushNamed(context, outletVisitPath);
                },
              ),
            ),
          ],
        ),

        ///
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.questionReport,
                name: "Question Report",
                onTap: () async {
                  context.read<QuestionState>().isFromIndex = true;
                  Navigator.pushNamed(context, questionPath);
                },
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            // Expanded(
            //   child: GridWidget(
            //     image: AssetsList.appIcon,
            //     name: "Outlet Visit",
            //     onTap: () async {
            //       // context.read<TopBuyingState>().isFromIndex = true;
            //       Navigator.pushNamed(context, outletVisitPath);
            //     },
            //   ),
            // ),
          ],
        ),

        ///
      ],
    );
  }
}

///
///
///
///
///
///
///
///
///

class GridWidget extends StatelessWidget {
  final String image, name;
  final void Function()? onTap;
  const GridWidget({
    super.key,
    required this.image,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Center(
                  child: Image.asset(
                    image,
                    width: screenWidth < 600 ? 30.0 : 45.0,
                  ),
                ),
              ),
              const SizedBox(height: 3.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: textFormTitleStyle.copyWith(
                    fontSize: screenWidth < 600 ? 13.0 : 16.0,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
