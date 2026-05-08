import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../../../core/providers/auth_provider.dart';

class ChildTaskListView extends StatelessWidget {
  const ChildTaskListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().availableTasks;
    final auth = context.read<AuthProvider>();

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(child: Text(task.category.name)),
            title: Text(task.name),
            subtitle: Text('獎勵: ${task.baseCoin} 幣'),
            trailing: ElevatedButton(
              onPressed: () {
                // 執行提交邏輯
                context.read<TaskProvider>().submitTask(task.taskId, auth.childData.childId);
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
}