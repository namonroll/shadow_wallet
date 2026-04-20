import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../family_group/providers/group_provider.dart';
import '../../providers/task_provider.dart';
import 'create_task_view.dart';
import '../../../../core/models/member_profile_enums.dart';

class ParentTaskBoardView extends StatefulWidget {
  const ParentTaskBoardView({super.key});

  @override
  State<ParentTaskBoardView> createState() => _ParentTaskBoardViewState();
}

class _ParentTaskBoardViewState extends State<ParentTaskBoardView> {
  String? _selectedChild;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final members = context.read<GroupProvider>().members;
      if (members.isNotEmpty) {
        setState(() => _selectedChild = members.first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupProvider = context.watch<GroupProvider>();
    final taskProvider = context.watch<TaskProvider>();
    final children = groupProvider.members;

    //  關鍵修改：只抓取目前選中小孩的任務
    final childTasks = _selectedChild != null 
        ? taskProvider.getTasksForChild(_selectedChild!) 
        : [];

    return Scaffold(
      appBar: AppBar(title: const Text('任務管理')),
      body: Column(
        children: [
          // 1. 小孩選擇列
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: children.length,
              itemBuilder: (context, index) {
                final name = children[index];
                final isSelected = _selectedChild == name;
                return GestureDetector(
                  onTap: () => setState(() => _selectedChild = name),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
                          child: Icon(Icons.person, color: isSelected ? Colors.white : Colors.grey),
                        ),
                        Text(name, style: TextStyle(color: isSelected ? Colors.blue : Colors.black)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          
          // 2. 任務列表 (顯示過濾後的 childTasks)
          Expanded(
            child: childTasks.isEmpty 
              ? Center(child: Text(_selectedChild == null ? '請先選擇小孩' : '目前沒有任務，點擊右下角新增'))
              : ListView.builder(
                  itemCount: childTasks.length,
                  itemBuilder: (context, index) {
                    final task = childTasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text('獎勵：${task.rewardCoins} 影子幣'),
                      trailing: Text(task.status.toString().split('.').last), 
                    );
                  },
                ),
          ),
        ],
      ),
      
      // 3. 新增任務按鈕
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedChild == null) return;
          
          final settings = groupProvider.memberSettings[_selectedChild!];
          //現在先寫死關係驅動小孩
          final personality = settings?['personality'] ?? ChildPersonality.dolphin;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTaskView(
                childName: _selectedChild!,
                personality: personality,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}