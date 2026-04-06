import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import '../../models/task_model.dart';

class ChildTaskBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 只顯示「可領取」的任務
    final tasks = context.watch<TaskProvider>().tasks
        .where((t) => t.status == TaskStatus.available).toList();

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          child: ListTile(
            title: Text(task.title),
            subtitle: Text('獎勵: ${task.rewardCoins} 幣'),
            trailing: ElevatedButton(
              onPressed: () {
                // 呼叫你剛剛寫在 Provider 的方法
                context.read<TaskProvider>().submitTaskForReview(task.id);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已送出審核！')));
              },
              child: const Text('提交完成'),
            ),
          ),
        );
      },
    );
  }
}