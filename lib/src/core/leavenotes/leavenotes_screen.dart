import 'package:flutter/material.dart';
import 'package:oms_salesforce/src/core/leavenotes/leavenotes_state.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import 'components/leave_notes_form.dart';
import 'components/leave_notes_report.dart';

class LeaveNotesScreen extends StatefulWidget {
  const LeaveNotesScreen({super.key});

  @override
  State<LeaveNotesScreen> createState() => _LeaveNotesScreenState();
}

class _LeaveNotesScreenState extends State<LeaveNotesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Provider.of<LeaveNotesState>(context, listen: false).getContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveNotesState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Leave Notes")),
          body: Column(
            children: [
              TabBar(
                labelStyle: titleTextStyle,
                controller: _tabController,
                tabs: const [Tab(text: "Form"), Tab(text: "Reports")],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [LeaveNotesForm(), LeaveNotesReports()],
                ),
              ),
            ],
          ),
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
