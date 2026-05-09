import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../../finance_periodic/providers/wallet_provider.dart';

class ParentTaskManageView extends StatelessWidget {
  const ParentTaskManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final history = context.watch<TaskProvider>().history;
    final wallet = context.read<WalletProvider>();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [Tab(text: "任務設定"), Tab(text: "完成紀錄")],
            labelColor: Colors.indigo,
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTaskSettingTab(), // 管理現有任務清單
                _buildHistoryTab(context, history, wallet), // 查看並可駁回
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskSettingTab() {
    return const Center(child: Text("這裡可以 新增/刪除 任務定義\n(實作方式與清單類似)"));
  }

  Widget _buildHistoryTab(BuildContext context, List history, WalletProvider wallet) {
    if (history.isEmpty) return const Center(child: Text("尚無任務完成紀錄"));

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final log = history[index];
        return ListTile(
          leading: const Icon(Icons.history_edu),
          title: Text("任務 ID: ${log.taskId}"),
          subtitle: Text("時間: ${log.completedAt.toString().substring(0, 16)}"),
          trailing: TextButton(
            onPressed: () {
              // 駁回邏輯：從紀錄刪除並扣錢
              context.read<TaskProvider>().revertTask(log, wallet);
            },
            child: const Text("駁回並扣款", style: TextStyle(color: Colors.red)),
          ),
        );
      },
    );
  }
}