import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import '../../../../data/models/task_model.dart';
import '../../../../data/enums.dart';

class TaskEditorSheet extends StatefulWidget {
  final Task? existingTask; // 判斷是新增還是編輯

  const TaskEditorSheet({Key? key, this.existingTask}) : super(key: key);

  @override
  State<TaskEditorSheet> createState() => _TaskEditorSheetState();
}

class _TaskEditorSheetState extends State<TaskEditorSheet> {
  late TextEditingController _nameCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _coinCtrl;
  String? _selectedTarget;

  @override
  void initState() {
    super.initState();
    // 如果是編輯，帶入現有資料；如果是新增，留空
    _nameCtrl = TextEditingController(text: widget.existingTask?.name ?? '');
    _descCtrl = TextEditingController(text: widget.existingTask?.description ?? '');
    _coinCtrl = TextEditingController(text: widget.existingTask?.baseCoin.toString() ?? '10');
    _selectedTarget = widget.existingTask?.targetChildId;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _coinCtrl.dispose();
    super.dispose();
  }

  void _saveTask() {
    final taskProvider = context.read<TaskProvider>();
    
    // 簡單的驗證
    if (_nameCtrl.text.isEmpty || _coinCtrl.text.isEmpty) return;

    final newTask = Task(
      taskId: widget.existingTask?.taskId ?? "TASK_${DateTime.now().millisecondsSinceEpoch}",
      familyId: "FAMILY_001", // 暫時寫死，未來從 Auth 取
      targetChildId: _selectedTarget,
      name: _nameCtrl.text,
      category: widget.existingTask?.category ?? TaskCategory.A, // 這裡可額外做下拉選單
      dayType: widget.existingTask?.dayType ?? TaskDayType.weekday,  // 這裡可額外做下拉選單
      description: _descCtrl.text,
      isLongTerm: widget.existingTask?.isLongTerm ?? false,
      baseCoin: int.tryParse(_coinCtrl.text) ?? 0,
      isActive: true,
    );

    if (widget.existingTask == null) {
      taskProvider.addNewTask(newTask);
    } else {
      taskProvider.modifyTask(newTask);
    }

    Navigator.pop(context); // 儲存後關閉表單
  }

  @override
  Widget build(BuildContext context) {
    // 取得鍵盤高度，避免鍵盤遮擋表單
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset, left: 16, right: 16, top: 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.existingTask == null ? "新增任務" : "編輯任務", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            // 任務名稱
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "任務名稱", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            
            // 獎勵金額
            TextField(
              controller: _coinCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "獎勵 (Coin)", border: OutlineInputBorder(), prefixIcon: Icon(Icons.monetization_on)),
            ),
            const SizedBox(height: 16),

            // 指定對象 (下拉選單)
            DropdownButtonFormField<String?>(
              value: _selectedTarget,
              decoration: const InputDecoration(labelText: "指定對象", border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: null, child: Text("全家共用")),
                DropdownMenuItem(value: "child_1", child: Text("小明")),
                DropdownMenuItem(value: "child_2", child: Text("小華")),
              ],
              onChanged: (val) => setState(() => _selectedTarget = val),
            ),
            const SizedBox(height: 16),

            // 任務描述
            TextField(
              controller: _descCtrl,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "詳細說明 (選填)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),

            // 儲存按鈕
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                onPressed: _saveTask,
                child: const Text("儲存任務", style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 24), // 底部留白
          ],
        ),
      ),
    );
  }
}