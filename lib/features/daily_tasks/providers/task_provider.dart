import 'package:flutter/material.dart';
import '../../../core/services/data_service.dart';
import '../../../data/models/task_completion.dart';
import '../../../data/models/task_model.dart';
import '../../../data/enums.dart';
import '../../finance_periodic/providers/wallet_provider.dart';

class TaskProvider extends ChangeNotifier {
  // --- 1. 私有狀態 ---
  final List<TaskCompletion> _completions = [];
  List<Task> _allTasks = []; // 移除 final，以便初始化載入
  
  String? _selectedChildId; // null 代表顯示全部
  bool _isLoading = false;

  // --- 2. Getters ---
  bool get isLoading => _isLoading;
  String? get selectedChildId => _selectedChildId;

  /// 供「孩子端」或「管理清單」顯示的過濾清單
  List<Task> get displayTasks {
    return _allTasks.where((t) {
      if (!t.isActive) return false;
      if (_selectedChildId == null) return true;
      return t.targetChildId == _selectedChildId || t.targetChildId == null;
    }).toList();
  }

  /// 供「紀錄分頁」顯示的過濾清單 (最新的在前)
  List<TaskCompletion> get displayHistory {
    if (_selectedChildId == null) return _completions;
    return _completions.where((c) => c.childId == _selectedChildId).toList();
  }

  // --- 3. 初始化與設定 ---
  
  TaskProvider() {
    loadInitialData(); // 構造函數直接觸發載入
  }

  void loadInitialData() {
    _isLoading = true;
    // notifyListeners(); // 如果在構造函數調用，這裡通常不需要通知
    _allTasks = DataService.fetchAllTasks();
    _isLoading = false;
    notifyListeners();
  }

  void selectChild(String? childId) {
    _selectedChildId = childId;
    notifyListeners();
  }

  // --- 4. 業務邏輯 (孩子動作) ---

  /// 孩子點擊完成 (信任制：直接記錄 + 直接加錢)
  void completeTaskDirectly(Task task, String childId, WalletProvider wallet) {
    final newLog = TaskCompletion(
      completionId: "LOG_${DateTime.now().millisecondsSinceEpoch}",
      taskId: task.taskId,
      childId: childId,
      reportedBy: UserRole.child,
      status: TaskStatus.completed,
      coinEarned: task.baseCoin,
      completedAt: DateTime.now(),
      timeSavedMin: 0,
    );

    // 建議將新紀錄插在最前面，這樣 displayHistory 就不用每次 reversed
    _completions.insert(0, newLog);
    
    // 同步更新錢包
    wallet.addIncome(task.baseCoin);
    notifyListeners();
  }

  // --- 5. 管理邏輯 (家長 CRUD) ---

  void addNewTask(Task task) {
    DataService.insertTask(task);
    _allTasks.insert(0, task);
    notifyListeners();
  }

  void modifyTask(Task updatedTask) {
    DataService.updateTask(updatedTask);
    int index = _allTasks.indexWhere((t) => t.taskId == updatedTask.taskId);
    if (index != -1) {
      _allTasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void removeTask(String taskId) {
    DataService.deactivateTask(taskId);
    int index = _allTasks.indexWhere((t) => t.taskId == taskId);
    if (index != -1) {
      _allTasks[index] = _allTasks[index].copyWith(isActive: false);
      notifyListeners();
    }
  }

  /// 駁回紀錄 (扣錢 + 刪除紀錄)
  void revertTask(TaskCompletion log, WalletProvider wallet) {
    _completions.removeWhere((item) => item.completionId == log.completionId);
    wallet.addIncome(-log.coinEarned); 
    notifyListeners();
  }

  // --- 6. 輔助工具 ---
  
  String getTaskNameById(String taskId) {
    try {
      return _allTasks.firstWhere((t) => t.taskId == taskId).name;
    } catch (e) {
      return "未知任務";
    }
  }
}