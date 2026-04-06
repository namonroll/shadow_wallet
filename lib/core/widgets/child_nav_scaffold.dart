import 'package:flutter/material.dart';
import '../../features/task_board/views/child/child_task_board_view.dart';
import '../../features/wallet/providers/wallet_provider.dart';
import 'package:provider/provider.dart';

class ChildNavScaffold extends StatefulWidget {
  @override
  _ChildNavScaffoldState createState() => _ChildNavScaffoldState();
}

class _ChildNavScaffoldState extends State<ChildNavScaffold> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    ChildTaskBoardView(),
    const Center(child: Text('錢包詳情頁')), // 之後可以換成真正的 WalletView
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的任務中心'),
        actions: [
          // 頂部顯示即時餘額
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text('💰 ${context.watch<WalletProvider>().balance} 幣')),
          )
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '看任務'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: '我的錢包'),
        ],
      ),
    );
  }
}