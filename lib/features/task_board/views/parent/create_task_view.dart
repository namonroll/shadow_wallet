import 'package:flutter/material.dart';
import '/core/models/member_profile_enums.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import '/core/mock/mock_database.dart';

class CreateTaskView extends StatefulWidget {
  final String childName;
  final ChildPersonality personality; 

  const CreateTaskView({super.key, required this.childName, required this.personality});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _coinsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 取得推薦任務
    final recommendations = MockData.recommendedTasks[widget.personality] ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('發布新任務')),
      body: SingleChildScrollView( // 防止鍵盤擋住
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 推薦區塊 ---
            Text('${widget.childName}的推薦任務)',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: recommendations.map((task) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ActionChip(
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      avatar: const Icon(Icons.auto_awesome, size: 16, color: Colors.blue),
                      label: Text(task['title']),
                      onPressed: () {
                        // 一鍵帶入！
                        setState(() {
                          _titleController.text = task['title'];
                          _coinsController.text = task['reward'].toString();
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            // --- 原本的輸入區塊 ---
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '任務名稱', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _coinsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '獎勵金額', border: OutlineInputBorder()),
            ),
            // ... 下方的發布按鈕保持原樣 ...
            const SizedBox(height: 40),

            // --- 🌟 補上的發布任務按鈕 ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // 1. 取得輸入的值
                  final title = _titleController.text.trim();
                  final coinsText = _coinsController.text.trim();

                  // 2. 簡單防呆：標題不能為空，金額也不能為空
                  if (title.isNotEmpty && coinsText.isNotEmpty) {
                    final coins = int.tryParse(coinsText) ?? 0;
                    
                    // 3. 呼叫 Provider 新增任務，並傳入「小孩名字」
                    context.read<TaskProvider>().addTask(title, coins, widget.childName);

                    // 4. 顯示成功訊息並回到上一頁
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('已成功指派任務給 ${widget.childName}！')),
                    );
                    Navigator.pop(context);
                  } else {
                    // 如果沒填寫完整，跳出提示
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('請填寫任務名稱與獎勵金額')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text('發布任務', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}