import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/group_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '/core/widgets/child_nav_scaffold.dart';

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
                      // ... 前面 success 判斷不變 ...
                      if (success) {
                        String newGroupId = context.read<GroupProvider>().currentGroup!.id;
                        context.read<AuthProvider>().updateUserGroup(newGroupId);
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('成功加入家庭！')),
                        );

                        // 🌟 關鍵修正：跳轉到「帶有導覽列」的外殼
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const ChildNavScaffold()), // 剛才寫的那個
                          (route) => false, // 清空導航堆疊，防止按返回鍵回到加入頁
                        );
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