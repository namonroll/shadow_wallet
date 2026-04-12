import 'package:flutter/material.dart';
import '../../features/task_board/views/parent/parent_task_board_view.dart';
import '../../features/family_group/views/parent_member_list_view.dart';
import '../../features/profile/views/parent_profile_view.dart';


class ParentNavScaffold extends StatefulWidget {
  const ParentNavScaffold({super.key});

  @override
  State<ParentNavScaffold> createState() => _ParentNavScaffoldState();
}

class _ParentNavScaffoldState extends State<ParentNavScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ParentTaskBoardView(), // 管理任務清單
    ParentMemberListView(), // 查看小孩表現
    ParentProfileView(), // 設定頁面
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: '任務管理'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '成員'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
      ),
    );
  }
}