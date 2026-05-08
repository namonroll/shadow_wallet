import 'package:flutter/material.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/task_completion.dart';
import '../../../data/mock/mock_database.dart';
import '../../../data/enums.dart';

class TaskProvider extends ChangeNotifier {
  // 存放從 Mock 載入的原始任務
  List<Task> _availableTasks = MockDatabase.sampleTasks;
  // 存放任務完成記錄
  List<TaskCompletion> _completions = [];

  List<Task> get availableTasks => _availableTasks;
  List<TaskCompletion> get completions => _completions;
  

  // 孩子提交任務
  void submitTask(String taskId, String childId) {
    final newCompletion = TaskCompletion(
      completionId: "TC_${DateTime.now().millisecondsSinceEpoch}",
      taskId: taskId,
      childId: childId,
      completedAt: DateTime.now(),
      reportedBy: UserRole.child,
      status: TaskStatus.uncompleted, // 初始狀態為待審核
      coinEarned: 0, 
      timeSavedMin: 0,
    );
    
    _completions.add(newCompletion);
    notifyListeners();
  }

  // 家長審核任務
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