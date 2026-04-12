import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/providers/auth_provider.dart';

class ParentProfileView extends StatelessWidget {
  const ParentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    return ListView(
      children: [
        const SizedBox(height: 20),
        // 1. 大頭照與姓名
        const Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blueAccent, // 家長端可以用不同的顏色區分
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            '${user?.name ?? '家長'} (管理員)', 
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          )
        ),
        const Divider(),

        // 2. 家庭資訊
        ListTile(
          leading: const Icon(Icons.family_restroom, color: Colors.blue),
          title: const Text('我的家庭群組'),
          subtitle: Text(user?.groupId ?? '尚未建立'),
          trailing: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              // TODO: 實作複製群組 ID 的功能
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已複製群組 ID')));
            },
          ),
        ),

        // 3. 家長專屬：邀請成員 (這在設定頁很常見)
        ListTile(
          leading: const Icon(Icons.person_add, color: Colors.green),
          title: const Text('邀請小孩加入'),
          onTap: () {
            // 可以彈出一個 Dialog 顯示邀請碼
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('家庭邀請碼'),
                content: Text('請小孩輸入此序號：\n${user?.groupId ?? "9999"}', textAlign: TextAlign.center),
                actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('確定'))],
              ),
            );
          },
        ),

        // 4. 系統設定
        const ListTile(
          leading: Icon(Icons.notifications),
          title: Text('通知設定'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),

        // 5. 登出
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