import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../family_group/providers/group_provider.dart';
import '../../providers/task_provider.dart';
import 'create_task_view.dart';
import '../../../../core/models/member_profile_enums.dart';
import '../../models/task_model.dart';

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

    // 抓取目前選中小孩的任務
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
                    
                    Widget trailingWidget;
                    
                    if (task.status == TaskStatus.underReview) {
                      // 待審核狀態：顯示核准按鈕
                      trailingWidget = ElevatedButton(
                        onPressed: () {
                          // 呼叫 Provider 執行核准邏輯
                          context.read<TaskProvider>().approveTask(task.id);
                          
                          // 顯示成功提示
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('已核准任務！發放 ${task.rewardCoins} 幣。')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: const Text('審核通過', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      );
                    } else if (task.status == TaskStatus.completed) {
                      // 已完成狀態：顯示綠色勾勾文字
                      trailingWidget = const Text('已完成', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16));
                    } else {
                      // 其他狀態 (available)：顯示待完成文字
                      trailingWidget = const Text('待完成', style: TextStyle(color: Colors.grey, fontSize: 14));
                    }

                    return Card( // 稍微加上 Card 讓任務列表更有層次感
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('獎勵：${task.rewardCoins} 幣', style: const TextStyle(color: Colors.orange)),
                        trailing: trailingWidget, // 放上我們剛剛判斷好的元件
                      ),
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