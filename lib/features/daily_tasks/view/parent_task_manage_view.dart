import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/task_completion.dart';
import 'widgets/task_editor_sheet.dart';
import '../../finance_periodic/providers/wallet_provider.dart';

class ParentTaskManageView extends StatelessWidget {
  const ParentTaskManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    // 假設家長有這兩個孩子 (未來從 AuthProvider 或 FamilyProvider 抓取)
    final childrenOptions = {"child_1": "小明", "child_2": "小華"};

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          title: _buildChildSelector(context, taskProvider, childrenOptions),
          bottom: const TabBar(
            labelColor: Colors.indigo,
            indicatorColor: Colors.indigo,
            tabs: [Tab(text: "任務管理"), Tab(text: "完成紀錄")],
          ),
        ),
        body: TabBarView(
          children: [
            _buildManageTab(context, taskProvider),
            _buildHistoryTab(context, taskProvider), // 使用上一階段寫好的歷史紀錄 UI
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showTaskEditor(context, null), // null 代表新增
          backgroundColor: Colors.indigo,
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text("新增任務", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  // --- 1. 孩子選擇器 (Choice Chips) ---
  Widget _buildChildSelector(BuildContext context, TaskProvider provider, Map<String, String> children) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ChoiceChip(
            label: const Text("全部/共用"),
            selected: provider.selectedChildId == null,
            onSelected: (val) => provider.selectChild(null),
          ),
          const SizedBox(width: 8),
          ...children.entries.map((entry) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: provider.selectedChildId == entry.key,
              onSelected: (val) => provider.selectChild(val ? entry.key : null),
            ),
          )),
        ],
      ),
    );
  }

  // --- 2. 任務管理清單 ---
  Widget _buildManageTab(BuildContext context, TaskProvider provider) {
    final tasks = provider.displayTasks;
    if (tasks.isEmpty) return const Center(child: Text("目前沒有任務，趕快新增一個吧！"));

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          child: ListTile(
            title: Text(task.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("獎勵: \$${task.baseCoin} | 對象: ${task.targetChildId ?? '全家'}"),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () => _showTaskEditor(context, task), // 傳入 task 代表編輯
            ),
            onLongPress: () {
              // 長按刪除提示
              provider.removeTask(task.taskId);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已刪除任務')));
            },
          ),
        );
      },
    );
  }

  Widget _buildHistoryTab(BuildContext context, TaskProvider provider) {
    final history = provider.displayHistory; // 抓取過濾後的歷史紀錄
    
    if (history.isEmpty) {
      return const Center(child: Text("目前還沒有完成紀錄喔！", style: TextStyle(color: Colors.grey)));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final log = history[index];
        // 透過 Provider 的輔助方法，用 taskId 查出任務名稱
        final taskName = provider.getTaskNameById(log.taskId); 

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.check, color: Colors.white),
            ),
            title: Text(taskName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              "完成者: ${log.childId}\n時間: ${log.completedAt.month}/${log.completedAt.day} ${log.completedAt.hour}:${log.completedAt.minute.toString().padLeft(2, '0')}"
            ),
            isThreeLine: true,
            trailing: Text(
              "+\$${log.coinEarned}", 
              style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 18)
            ),
            onLongPress: () {
              // 家長專屬功能：長按紀錄可以選擇「駁回」
              _showRevertDialog(context, provider, log);
            },
          ),
        );
      },
    );
  }

  // --- 4. 駁回任務對話框 (新增這個方法在類別底端) ---
  void _showRevertDialog(BuildContext context, TaskProvider taskProvider, TaskCompletion log) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("駁回任務紀錄"),
        content: const Text("確定要駁回這筆紀錄嗎？\n這將會從孩子的錢包中扣回已發放的獎勵！"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("取消", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // 需要抓取 WalletProvider 來扣錢
              final walletProvider = context.read<WalletProvider>();
              taskProvider.revertTask(log, walletProvider);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('已駁回任務並扣回獎勵')),
              );
            },
            child: const Text("確認駁回", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // --- 3. 彈出新增/編輯表單 ---
  void _showTaskEditor(BuildContext context, Task? existingTask) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 讓 BottomSheet 可以推到全螢幕高度以容納鍵盤
      builder: (ctx) => TaskEditorSheet(existingTask: existingTask),
    );
  }
}