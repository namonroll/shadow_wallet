import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/providers/auth_provider.dart';

class ChildProfileView extends StatelessWidget {
  const ChildProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    return ListView(
      children: [
        const SizedBox(height: 20),
        const Center(
          child: CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
        ),
        const SizedBox(height: 10),
        Center(child: Text(user?.name ?? '小朋友', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.family_restroom),
          title: const Text('我的家庭群組'),
          subtitle: Text(user?.groupId ?? '未加入'),
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('登出', style: TextStyle(color: Colors.red)),
          onTap: () {
            // 清除登入狀態並跳回 RoleSelectionView
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
      ],
    );
  }
}