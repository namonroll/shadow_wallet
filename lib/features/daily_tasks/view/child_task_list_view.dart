import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../data/models/task_model.dart'; // 確保引入 Model 以獲得型別提示

class ChildTaskListView extends StatelessWidget {
  const ChildTaskListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. 強制指定型別為 List<Task>，避免編譯器誤判
    final List<Task> tasks = context.watch<TaskProvider>().availableTasks;
    final auth = context.read<AuthProvider>();

    if (tasks.isEmpty) {
      return const Center(child: Text('目前沒有可用的任務'));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            // 2. 修正 Category 顯示邏輯
            // 如果 task.category 是 Enum，建議用 .toString().split('.').last 
            // 或者直接用 task.category.toString() 測試
            leading: CircleAvatar(
              child: Icon(_getCategoryIcon(task.category)), 
            ),
            title: Text(task.name),
            subtitle: Text('獎勵: ${task.baseCoin.toInt()} 幣'),
            trailing: ElevatedButton(
              onPressed: () {
                context.read<TaskProvider>().submitTask(
                  task.taskId, 
                  auth.childData.childId
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('任務已提交，待家長審核！')),
                );
              },
              child: const Text('完成'),
            ),
          ),
        );
      },
    );
  }

  // 輔助方法：根據分類給圖示，避免直接噴 .name 的錯誤
  IconData _getCategoryIcon(dynamic category) {
    // 這裡根據你的 Enum 內容做調整
    return Icons.assignment; 
  }
}