import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../../../data/enums.dart';

class ParentAuditView extends StatelessWidget {
  const ParentAuditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 過濾出所有「待審核」的任務
    final pendingTasks = context.watch<TaskProvider>().completions
        .where((c) => c.status == TaskStatus.uncompleted).toList();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('待審核清單', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: pendingTasks.isEmpty 
            ? const Center(child: Text('目前沒有待審核的任務'))
            : ListView.builder(
                itemCount: pendingTasks.length,
                itemBuilder: (context, index) {
                  final completion = pendingTasks[index];
                  return ListTile(
                    title: Text('任務 ID: ${completion.taskId}'),
                    subtitle: Text('提交時間: ${completion.completedAt.toString().substring(0, 16)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => context.read<TaskProvider>().auditTask(completion.completionId, TaskStatus.completed, 10),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, color: Colors.orange),
                          onPressed: () { 
                            context.read<TaskProvider>().auditTask(completion.completionId, TaskStatus.reDiscuss, 0); },
                        ),
                      ],
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }
}