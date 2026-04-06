import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/models/user_model.dart';
import '../providers/auth_provider.dart';
import '../../family_group/views/child_join_view.dart';
import '../../family_group/views/parent_create_view.dart';

class RoleSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('歡迎使用教育錢包')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('請選擇你的身分', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().setRoleAndLogin(UserRole.parent, '爸爸');
                Navigator.push(context, MaterialPageRoute(builder: (_) => ParentCreateView()));
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('我是家長', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().setRoleAndLogin(UserRole.child, '小明');
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChildJoinView()));
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('我是小孩', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}