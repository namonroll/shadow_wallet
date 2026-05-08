import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../daily_tasks/view/child_task_list_view.dart';
import '../../finance_periodic/view/child_wallet_view.dart';

class ChildMainNavigation extends StatefulWidget {
  const ChildMainNavigation({Key? key}) : super(key: key);
  @override
  State<ChildMainNavigation> createState() => _ChildMainNavigationState();
}

class _ChildMainNavigationState extends State<ChildMainNavigation> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = const [
    ChildTaskListView(), // 第一頁：任務清單
    ChildWalletView(), // 第二頁：錢包
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('孩子模式 - ${context.read<AuthProvider>().childData.nickname}'),
        backgroundColor: Colors.orange,
        elevation: 0,
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
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in), label: '任務'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: '錢包'),
        ],
      ),
    );
  }
}