import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/utils/loading_indicator.dart';
import 'package:oms_salesforce/theme/fonts_style.dart';
import 'package:provider/provider.dart';

import '../questions.dart';
import 'components/question_answer_section.dart';
import 'components/question_report_section.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionState>().context = context;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionState>(
      builder: (BuildContext context, state, Widget? child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text(
                  "Questions ( ${state.isFromIndex ? "" : state.productState.outletDetail.glDesc} )",
                ),
              ),
              body: state.isFromIndex
                  ? const QuestioReportSection()
                  : Column(
                      children: [
                        TabBar(
                          labelStyle: titleTextStyle,
                          controller: _tabController,
                          tabs: const [
                            Tab(text: "Question Answer"),
                            Tab(text: "Reports"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: const [
                              QuestionAnswerSection(),
                              QuestioReportSection(),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),

            ///
            if (state.isLoading) LoadingScreen.loadingScreen(),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
