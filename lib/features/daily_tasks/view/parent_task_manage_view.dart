import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../../../data/models/task_model.dart';
import 'widgets/task_editor_sheet.dart';

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
    // 這裡放入你上一階段實作的 _buildHistoryTab 程式碼
    // 記得改用 provider.displayHistory 來渲染，確保切換孩子時紀錄會跟著變
    return const Center(child: Text("完成紀錄 UI (同前一階段)"));
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