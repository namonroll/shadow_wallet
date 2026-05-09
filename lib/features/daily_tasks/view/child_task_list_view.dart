import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../../finance_periodic/providers/wallet_provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../data/models/task_model.dart';

class ChildTaskListView extends StatelessWidget {
  const ChildTaskListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 使用封裝好的 getter 拿資料
    final tasks = context.watch<TaskProvider>().availableTasks;

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: Colors.orange.shade100,
              child: const Icon(Icons.star, color: Colors.orange),
            ),
            title: Text(task.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('可領取: \$${task.baseCoin}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showTaskDetail(context, task),
          ),
        );
      },
    );
  }

  // 任務詳情彈窗 (BottomSheet)
  void _showTaskDetail(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, color: Colors.grey[300]),
              const SizedBox(height: 20),
              Text(task.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(task.description , 
                   textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoTile(Icons.monetization_on, "獎勵", "\$${task.baseCoin}"),
                  _infoTile(Icons.timer, "預計", "15 分鐘"),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    final auth = context.read<AuthProvider>();
                    final wallet = context.read<WalletProvider>();
                    
                    // 執行新邏輯：直接加錢並記錄
                    context.read<TaskProvider>().completeTaskDirectly(
                      task, 
                      auth.childData.childId, 
                      wallet
                    );

                    Navigator.pop(context); // 關閉詳情
                    _showSuccessEffect(context, task.baseCoin.toInt());
                  },
                  child: const Text('我完成了，領取獎勵！', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.orange),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _showSuccessEffect(BuildContext context, int amount) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('\$$amount 幣已入帳！'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}