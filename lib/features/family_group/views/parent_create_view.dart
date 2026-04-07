import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/group_provider.dart';
import '/core/widgets/parent_nav_scaffold.dart';

class ParentCreateView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final groupProvider = context.watch<GroupProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('建立家庭群組')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (groupProvider.currentGroup == null) ...[
              const Text('為你的家庭取個名字吧', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: '家庭名稱'),
              ),
              const SizedBox(height: 20),
              groupProvider.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        context.read<GroupProvider>().createGroup(_nameController.text);
                      },
                      child: const Text('建立家庭'),
                    ),
            ] else ...[
              // 建立成功後顯示序號
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 20),
              Text('家庭「${groupProvider.currentGroup!.name}」建立成功！',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              const Text('請讓孩子輸入以下序號加入：',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16)),
              Text(
                groupProvider.currentGroup!.joinCode,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // 家長完成建立後，也要跳轉到家長的「導覽列外殼」
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const ParentNavScaffold()), // 剛才寫的那個
                    (route) => false,
                  );
                },
                child: const Text('進入控制面板'),
              )
            ]
          ],
        ),
      ),
    );
  }
}