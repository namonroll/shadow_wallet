import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/report_provider.dart';
import '../../daily_tasks/providers/task_provider.dart';
import '../../daily_tasks/view/widgets/child_selector_bar.dart'; // 引入共用組件
import './widgets/monthly_report_card.dart';

class ReportDashboardView extends StatelessWidget {
  const ReportDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final reportProvider = context.watch<ReportProvider>();
    final selectedChildId = taskProvider.selectedChildId;

    // 當 Provider 資料變動時，這段會觸發過濾
    // 注意：addPostFrameCallback 是為了避免在 build 期間觸發 notifyListeners
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reportProvider.loadReports(selectedChildId ?? ""); 
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("成長報告"),
        // 關鍵：在這裡加入選擇器
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: ChildSelectorBar(), 
        ),
      ),
      body: _buildBody(selectedChildId, reportProvider),
    );
  }

  Widget _buildBody(String? selectedChildId, ReportProvider reportProvider) {
    if (selectedChildId == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.face, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text("請先在上方選擇孩子", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    if (reportProvider.reports.isEmpty) {
      return const Center(child: Text("目前尚無本月報表"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reportProvider.reports.length,
      itemBuilder: (context, index) {
        return MonthlyReportCard(report: reportProvider.reports[index]);
      },
    );
  }
}