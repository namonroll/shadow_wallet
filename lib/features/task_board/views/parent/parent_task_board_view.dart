import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import 'create_task_view.dart';
import '../../../wallet/providers/wallet_provider.dart';
import '../../models/task_model.dart';

class ParentTaskBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 監聽任務列表
    final tasks = context.watch<TaskProvider>().tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('家長控制台 - 任務看板'),
        backgroundColor: Colors.blue[100],
      ),
      // 如果沒有任務顯示提示，有任務就顯示 ListView
      body: tasks.isEmpty
          ? const Center(child: Text('目前沒有任務，趕快按右下角新增吧！'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.task_alt, color: Colors.blue),
                    title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('狀態: ${task.status.name}'),
                    trailing: task.status == TaskStatus.underReview
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () {
                            // 1. 任務變更為已完成
                            context.read<TaskProvider>().approveTask(task.id);
                            // 2. 錢包發錢
                            context.read<WalletProvider>().addCoins(task.rewardCoins);
                          },
                          child: const Text('核准發錢'),
                        )
                      : Text('${task.rewardCoins} 幣'),
                  ),
                );
              },
            ),
      // 右下角的浮動新增按鈕 (FAB)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 跳轉到新增任務頁面
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}