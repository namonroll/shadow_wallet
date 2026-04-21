import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/models/user_model.dart';
import '../providers/auth_provider.dart';
import '../../../core/widgets/child_nav_scaffold.dart';
import '../../../core/widgets/parent_nav_scaffold.dart';

class RoleSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('成長錢包')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('身分', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().setRoleAndLogin(UserRole.parent, '阿明');
                Navigator.push(context, MaterialPageRoute(builder: (_) => ParentNavScaffold()));
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('阿明(家長)', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().setRoleAndLogin(UserRole.child, '小明');
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChildNavScaffold()));
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('小明(小孩)', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().setRoleAndLogin(UserRole.child, '小華');
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChildNavScaffold()));
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('小華(小孩)', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}