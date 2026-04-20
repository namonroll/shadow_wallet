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
                labelText: '家庭序號 (測試請輸入 9999)',
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
                      // 1. 只負責叫 Provider 去做事
                      bool success = await context.read<GroupProvider>().joinGroup(_codeController.text);
                      
                      if (success) {
                        // 2. 成功後的狀態更新（建議把 updateUserGroup 封裝進去，或保持這樣但只需處理導航）
                        final newGroupId = context.read<GroupProvider>().currentGroup!.id;
                        context.read<AuthProvider>().updateUserGroup(newGroupId);

                        // 3. 導航
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const ChildNavScaffold()),
                            (route) => false,
                          );
                        }
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