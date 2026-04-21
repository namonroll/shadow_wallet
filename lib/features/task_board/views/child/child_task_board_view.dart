import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import '../../models/task_model.dart';
import '../../../auth/providers/auth_provider.dart';

class ChildTaskBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. 取得當前登入的使用者物件
    final user = context.watch<AuthProvider>().currentUser;
    
    // 2. 取得任務清單
    final taskProvider = context.watch<TaskProvider>();

    // 3. 修正篩選邏輯
    final tasks = taskProvider.tasks.where((t) {
      // 確保 user 不為 null，並且用 user.name 去比對字串
      final isMyTask = (user != null && t.assigneeName == user.name);
      final isAvailable = (t.status == TaskStatus.available);
      
      return isMyTask && isAvailable;
    }).toList();

    // 4. 如果是空的，給個提示（方便除錯）
    if (tasks.isEmpty) {
      return const Center(
        child: Text('目前沒有屬於你的待完成任務喔！'),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(task.title),
            subtitle: Text('獎勵: ${task.rewardCoins} 幣'),
            trailing: ElevatedButton(
              onPressed: () {
                context.read<TaskProvider>().submitTaskForReview(task.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('已送出審核！')),
                );
              },
              child: const Text('提交完成'),
            ),
          ),
        );
      },
    );
  }
}