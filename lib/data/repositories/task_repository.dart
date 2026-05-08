import '../mock/mock_database.dart';
import '../models/task_model.dart';
import '../models/task_completion.dart';
import '../enums.dart';

class TaskRepository {
  // 模擬從資料庫或 API 獲取所有任務
  Future<List<Task>> fetchAllTasks() async {
    await Future.delayed(const Duration(milliseconds: 300)); // 模擬網路延遲
    return MockDatabase.sampleTasks;
  }

  // 模擬「後端篩選」：只拿特定狀態的完成記錄
  Future<List<TaskCompletion>> fetchCompletionsByStatus(TaskStatus status) async {
    // 未來這裡會是 http.get('/completions?status=${status.name}')
    return MockDatabase.completions.where((c) => c.status == status).toList();
  }
}