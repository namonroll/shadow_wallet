import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../../../core/mock/mock_database.dart';

//先寫死資料，之後再和service拿
class TaskProvider extends ChangeNotifier {
  // 從 MockData 讀取初始任務
  final List<TaskModel> _tasks = MockData.initialTasks;

  List<TaskModel> get tasks => _tasks;

  void addTask(String title, int coins) {
    final newTask = TaskModel(
      id: 't_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      rewardCoins: coins,
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

  // 家長核准任務 (狀態變為已完成)
  void approveTask(String taskId) {
    final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].status = TaskStatus.completed;
      notifyListeners();
    }
  }
}