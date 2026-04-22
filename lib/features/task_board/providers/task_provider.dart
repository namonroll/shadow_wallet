import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../../../core/mock/mock_database.dart'; // 引入 MockData

class TaskProvider extends ChangeNotifier {
  // MockData 取得初始任務 (使用 List.from)
  final List<TaskModel> _tasks = List.from(MockData.initialTasks);

  // 取得所有任務 (一般情況用不到，但保留著)
  List<TaskModel> get tasks => _tasks;

  // 新增：過濾並取得「特定小孩」的任務
  List<TaskModel> getTasksForChild(String childName) {
    return _tasks.where((task) => task.assigneeName == childName).toList();
  }

  //新增任務時，必須傳入分派給哪個小孩
  void addTask(String title, int coins, String assigneeName) {
    final newTask = TaskModel(
      id: 't_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      rewardCoins: coins,
      assigneeName: assigneeName, // 存入被指派的小孩
    );
    _tasks.add(newTask);
    notifyListeners();
  }
  
  void submitTaskForReview(String taskId) {
    final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].status = TaskStatus.underReview;
      notifyListeners();
    }
  }

  void approveTask(String taskId) {
    final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].status = TaskStatus.completed;
      notifyListeners();
    }
  }

  void rejectTask(String taskId) {
    final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      // 將狀態改回「可執行」，讓小孩能再次看到並提交
      _tasks[taskIndex].status = TaskStatus.available; 
      notifyListeners();
    }
  }
}

  