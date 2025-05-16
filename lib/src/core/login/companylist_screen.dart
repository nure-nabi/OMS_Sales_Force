import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/login/login.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/src/widgets/container_decoration.dart';
import 'package:oms_salesforce/theme/theme.dart';
import 'package:provider/provider.dart';

class CompanyListScreen extends StatelessWidget {
  final bool automaticallyImplyLeading;
  const CompanyListScreen({
    super.key,
    required this.automaticallyImplyLeading,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginState>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Company List"),
            automaticallyImplyLeading: automaticallyImplyLeading,
          ),
          body: ListView.builder(
            itemCount: state.companyList.length,
            itemBuilder: (context, index) {
              CompanyDetailsModel companyDetail = state.companyList[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                padding: const EdgeInsets.all(8.0),
                decoration: ContainerDecoration.decoration(),
                child: InkWell(
                  onTap: () async {
                    // await onListClicked(context, detailsModel: companyDetail);
                    await state.apiForUpdateAgentCode(
                      context,
                      selectedCompany: companyDetail,
                      automaticallyImplyLeading: automaticallyImplyLeading,
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        companyDetail.companyName,
                        style: textFormTitleStyle.copyWith(
                          fontSize: 20.0,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        companyDetail.panNo,
                        style: subTitleTextStyle,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (state.isCompanyUpdated) LoadingScreen.loadingScreen(),
      ],
    );
  }
}
