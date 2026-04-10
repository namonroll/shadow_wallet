import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/task_board/views/child/child_task_board_view.dart';
import '../../features/family_group/views/child_join_view.dart'; // 假設你之前的加入頁面在此
import '../../features/wallet/providers/wallet_provider.dart';
import '../../features/wallet/views/child_wallet_view.dart';
import '../../features/profile/views/child_profile_view.dart';

class ChildNavScaffold extends StatefulWidget {
  const ChildNavScaffold({super.key});

  @override
  State<ChildNavScaffold> createState() => _ChildNavScaffoldState();
}

class _ChildNavScaffoldState extends State<ChildNavScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final wallet = context.watch<WalletProvider>();

    // 核心邏輯：如果還沒加入群組，強制顯示「加入頁面」，不顯示導覽列
    if (!auth.isInGroup) {
      return ChildJoinView(); 
    }

    // 如果已加入群組，則顯示正常的導覽列介面
    final List<Widget> pages = [
      ChildTaskBoardView(), // 任務面板
      ChildWalletView(), // 錢包
      ChildProfileView(), // 設定面板
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的錢包'),
        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('💰 ${wallet.balance}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ))
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: '任務'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: '錢包'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
      ),
    );
  }
}