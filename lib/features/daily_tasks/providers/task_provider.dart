import 'package:flutter/material.dart';
import '../../../core/services/data_service.dart';
import '../../../data/models/task_completion.dart';
import '../../../data/models/task_model.dart';
import '../../../data/enums.dart';

class TaskProvider extends ChangeNotifier {
  // 1. 內部狀態
  final List<TaskCompletion> _completions = [];
  final List<Task> _allTasks = DataService.fetchAllTasks();

  // 3. 關鍵修正：加上 <Task>，這樣 UI 就不會拿到 dynamic
  List<Task> get availableTasks => _allTasks;

  // 專門給家長看的：待審核列表
  List<TaskCompletion> get pendingAuditList => 
      _completions.where((c) => c.status == TaskStatus.uncompleted).toList();

  // 專門給孩子看的：今日已完成紀錄
  List<TaskCompletion> get childFinishedToday => 
      _completions.where((c) => c.status == TaskStatus.completed).toList();

  // 3. 動作 (Actions)
  void submitTask(String taskId, String childId) {
    final newCompletion = TaskCompletion(
      completionId: "TC_${DateTime.now().millisecondsSinceEpoch}",
      taskId: taskId,
      childId: childId,
      completedAt: DateTime.now(),
      reportedBy: UserRole.child,
      status: TaskStatus.uncompleted,
      coinEarned: 0,
      timeSavedMin: 0,
    );
    _completions.add(newCompletion);
    notifyListeners();
  }

  void auditTask(String completionId, TaskStatus newStatus, int reward) {
    int index = _completions.indexWhere((c) => c.completionId == completionId);
    if (index != -1) {
      _completions[index] = _completions[index].copyWith(
        status: newStatus,
        coinEarned: reward,
      );
      notifyListeners();
    }
  }
}