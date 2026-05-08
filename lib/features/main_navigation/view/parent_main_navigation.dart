import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/enums.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../features/daily_tasks/view/parent_audit_view.dart';
import '../../../../features/daily_tasks/providers/task_provider.dart';
import '../../../../features/finance_periodic/view/parent_finance_view.dart';

class ParentMainNavigation extends StatefulWidget {
  const ParentMainNavigation({Key? key}) : super(key: key);
  @override
  State<ParentMainNavigation> createState() => _ParentMainNavigationState();
}
// ... 其他 import

class _ParentMainNavigationState extends State<ParentMainNavigation> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = const [
    Center(child: Text('家庭儀表板 (開發中)')),
    ParentAuditView(), // 第二頁：審核頁面
    ParentFinanceView(), // 第三頁：財務頁面
    Center(child: Text('系統設定')),
  ];

  @override
  Widget build(BuildContext context) {
    // 監聽待審核數量，可以在 UI 上做標記 (Badge)
    final pendingCount = context.watch<TaskProvider>().completions
        .where((c) => c.status == TaskStatus.uncompleted).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('家長模式 - ${context.read<AuthProvider>().parentData.name}'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.published_with_changes),
            onPressed: () => context.read<AuthProvider>().toggleRole(),
          )
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed, // 強制固定，不隱藏標籤(>3個會被隱藏)
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.analytics), label: '數據'),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text(pendingCount.toString()),
              isLabelVisible: pendingCount > 0,
              child: const Icon(Icons.fact_check),
            ),
            label: '審核',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: '財務'),
          const BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
      ),
    );
  }
}