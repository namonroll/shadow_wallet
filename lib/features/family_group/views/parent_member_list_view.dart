import 'package:flutter/material.dart';
import 'parent_member_edit_view.dart';

class ParentMemberListView extends StatelessWidget {
  const ParentMemberListView({super.key});

  @override
  Widget build(BuildContext context) {
    // 假資料：之後從 GroupProvider 撈取家庭成員
    final List<String> children = ['小明', '小華'];

    return Scaffold(
      appBar: AppBar(title: const Text('家庭成員管理')),
      body: ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) {
          final childName = children[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(childName, style: const TextStyle(fontSize: 18)),
              subtitle: const Text('點擊設定教育參數'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 點擊後跳轉到設定頁面
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParentMemberEditView(memberName: childName),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}