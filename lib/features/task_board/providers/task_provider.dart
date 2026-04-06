import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  // 模擬資料庫裡的任務清單 (先塞兩個假資料方便測試)
  final List<TaskModel> _tasks = [
    TaskModel(id: 't_1', title: '洗碗', rewardCoins: 15),
    TaskModel(id: 't_2', title: '背 10 個英文單字', rewardCoins: 30),
  ];

  // 讓外部讀取任務清單
  List<TaskModel> get tasks => _tasks;

  // 新增任務的方法
  void addTask(String title, int coins) {
    final newTask = TaskModel(
      id: 't_${DateTime.now().millisecondsSinceEpoch}', // 用時間戳當隨機 ID
      title: title,
      rewardCoins: coins,
    );
    
    _tasks.add(newTask);
    notifyListeners(); // 📢 廣播：任務列表更新囉！畫面請重繪！
  }
  void submitTaskForReview(String taskId) {
    final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].status = TaskStatus.underReview;
      notifyListeners();
    }
  }

  // 家長核准任務 (狀態變為已完成)
  void approveTask(String taskId) {
    final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].status = TaskStatus.completed;
      notifyListeners();
    }
  }
}