import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:oms_salesforce/src/constant/constant.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/service/router/router.dart';
import 'package:oms_salesforce/src/widgets/widgets.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../service/sharepref/set_all_pref.dart';
import '../home_state.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeState>();
    double screenWidth = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Container(
        width: screenWidth / 1.5,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(children: [
          titleSection(context),
          DrawerIconName(
            name: "Dashboard",
            iconName: Icons.dashboard,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          divider(),
          DrawerIconName(
            name: "Switch Company",
            iconName: MdiIcons.redoVariant,
            onTap: () async {
              await SetAllPref.setBranch(value: "null");
              context.read<LoginState>().getCompanyFromDatabase();
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const CompanyListScreen(
                    automaticallyImplyLeading: true,
                  ),
                ),
              );
            },
          ),
          divider(),
          DrawerIconName(
            name: "Setting",
            iconName: MdiIcons.cog,
            onTap: () {
              Navigator.pushNamed(context, settingPath);
            },
          ),
          divider(),
          DrawerIconName(
            name: "Clear Data",
            iconName: Icons.clear,
            onTap: () async {
              await state.clearSharePref(context);
            },
          ),
          divider(),
          DrawerIconName(
            name: "LogOut",
            iconName: Icons.logout,
            onTap: () async {
              await state.logOut(context);
            },
          ),
          divider(),
          // DrawerIconName(
          //   name: "Refresh",
          //   iconName: Icons.refresh,
          //   onTap: () async {},
          // ),
          // divider(),
        ]),
      ),
    );
  }

  Widget titleSection(context) {
    final state = Provider.of<HomeState>(context, listen: false);

    return Container(
      color: primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage(AssetsList.appIcon),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "OMS|SalesForce",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "GlobalTech",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
          verticalSpace(10.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                state.companyDetail.companyName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                state.companyDetail.loginName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          verticalSpace(5.0),
        ],
      ),
    );
  }

  Widget divider() {
    return Container(height: 1.0, color: Colors.grey.shade300);
  }
}

class DrawerIconName extends StatelessWidget {
  final String name;
  final IconData iconName;
  final Function onTap;

  const DrawerIconName({
    super.key,
    required this.iconName,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                iconName,
                size: 25.0,
                color: primaryColor,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
