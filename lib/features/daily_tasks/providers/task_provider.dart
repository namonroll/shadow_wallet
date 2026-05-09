import 'package:flutter/material.dart';
import '../../../core/services/data_service.dart';
import '../../../data/models/task_completion.dart';
import '../../finance_periodic/providers/wallet_provider.dart';
import '../../../data/models/task_model.dart';
import '../../../data/enums.dart';

class TaskProvider extends ChangeNotifier {
  // 1. 私有狀態
  // 從 Service 抓取所有定義好的任務
  final List<Task> _allTasks = DataService.fetchAllTasks();
  // 任務完成紀錄
  final List<TaskCompletion> _completions = [];
  
  // 2. Getter (讓 View 變成伸手將軍)
  List<Task> get availableTasks => _allTasks;
  
  // 這裡我們讓最新的紀錄排在最前面，方便家長查看
  List<TaskCompletion> get history => _completions.reversed.toList();

  // 3. 業務邏輯

  /// 孩子直接完成任務 (信任制)
  void completeTaskDirectly(Task task, String childId, WalletProvider wallet) {
    final newLog = TaskCompletion(
      completionId: "LOG_${DateTime.now().millisecondsSinceEpoch}",
      taskId: task.taskId,
      childId: childId,
      reportedBy: UserRole.child,
      status: TaskStatus.completed,
      coinEarned: task.baseCoin.toInt(),
      completedAt: DateTime.now(),
      timeSavedMin: 0,
    );

    // 更新本地狀態
    _completions.add(newLog);

    // 跨 Provider 連動：增加錢包餘額
    wallet.addIncome(task.baseCoin.toInt());

    // 模擬存檔邏輯 (將來這裡會改為呼叫 API)
    // DataService.saveTaskCompletion(newLog); 

    notifyListeners();
  }

  /// 家長事後駁回紀錄
  void revertTask(TaskCompletion log, WalletProvider wallet) {
    // 從清單移除
    _completions.removeWhere((item) => item.completionId == log.completionId);
    
    // 跨 Provider 連動：扣回已發放的金額 (傳入負值)
    wallet.addIncome(-log.coinEarned); 

    // 模擬存檔邏輯 (同步更新 Mock 數據源)
    // DataService.deleteTaskCompletion(log.completionId);

    notifyListeners();
  }
  
  // 4. 輔助邏輯：根據 ID 找任務名稱 (家長端紀錄顯示用)
  String getTaskNameById(String taskId) {
    try {
      return _allTasks.firstWhere((t) => t.taskId == taskId).name;
    } catch (e) {
      return "未知任務";
    }
  }
}