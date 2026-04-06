import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/group_provider.dart';
import '../../auth/providers/auth_provider.dart';

class ChildJoinView extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final groupProvider = context.watch<GroupProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('加入家庭群組')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('請輸入家長提供的序號', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '家庭序號 (測試請輸入 1234)',
              ),
            ),
            const SizedBox(height: 20),
            if (groupProvider.errorMessage.isNotEmpty)
              Text(groupProvider.errorMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            groupProvider.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      bool success = await context.read<GroupProvider>().joinGroup(_codeController.text);
                      if (success) {
                        // 更新 AuthProvider 狀態
                        String newGroupId = context.read<GroupProvider>().currentGroup!.id;
                        context.read<AuthProvider>().updateUserGroup(newGroupId);
                        
                        // 加入成功，顯示彈窗
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('成功加入家庭！')),
                        );
                        // TODO: 導航到小孩的任務首頁
                      }
                    },
                    child: const Text('加入'),
                  ),
          ],
        ),
      ),
    );
  }
}