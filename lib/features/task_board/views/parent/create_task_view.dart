import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';

class CreateTaskView extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _coinsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('發布新任務')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '任務名稱 (例如：拖地)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _coinsController,
              keyboardType: TextInputType.number, // 限制只能輸入數字
              decoration: const InputDecoration(
                labelText: '獎勵影子幣數量',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monetization_on, color: Colors.orange),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // 1. 取得輸入的值
                  final title = _titleController.text;
                  final coinsText = _coinsController.text;

                  // 2. 簡單的防呆機制 (確保沒填錯)
                  if (title.isNotEmpty && coinsText.isNotEmpty) {
                    final coins = int.tryParse(coinsText) ?? 0;
                    
                    // 3. 呼叫 Provider 新增任務 (使用 context.read)
                    context.read<TaskProvider>().addTask(title, coins);

                    // 4. 新增成功後，關閉這一頁回到上一頁
                    Navigator.pop(context);
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