import '../../../data/mock/mock_database.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/wallet.dart';
import '../../../data/models/child_model.dart';
import '../../../data/models/parent.dart';

class DataService {
  // 模擬從資料庫/API 獲取原始數據
  static List<Task> fetchAllTasks() => MockDatabase.sampleTasks;
  static List<Wallet> fetchWallets() => MockDatabase.wallets;
  static Child fetchChildInfo() => MockDatabase.child;
  static Parent fetchParentInfo() => MockDatabase.parent;

  static void insertTask(Task newTask) {
    // 未來替換成 HTTP POST
    // MockDatabase.sampleTasks.add(newTask);
  }
  static void updateTask(Task updatedTask) {
    // 未來替換成 HTTP PUT
    /*
    int index = MockDatabase.sampleTasks.indexWhere((t) => t.taskId == updatedTask.taskId);
    if (index != -1) {
      MockDatabase.sampleTasks[index] = updatedTask;
    }
    */
  }
  static void deactivateTask(String taskId) {
    // 未來替換成 HTTP DELETE 或 PUT (Soft delete)
    /*
    int index = MockDatabase.sampleTasks.indexWhere((t) => t.taskId == taskId);
    if (index != -1) {
      MockDatabase.sampleTasks[index] = MockDatabase.sampleTasks[index].copyWith(isActive: false);
    }
    */
  }
  // 未來這裡可以改成：
  // static Future<List<Task>> fetchAllTasks() async { 
  //    final response = await http.get('...'); 
  //    return decode(response);
  // }
}