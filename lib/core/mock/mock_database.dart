import '../../features/task_board/models/task_model.dart';
import '../models/user_model.dart';
import '../models/group_model.dart';

class MockData {
  // 1. 錢包初始餘額
  static const int initialBalance = 1000;

  // 2. 預設任務列表 (使用 getter 確保每次拿到的都是新的物件)
  static List<TaskModel> get initialTasks => [
        TaskModel(id: 't_1', title: '洗碗', rewardCoins: 15),
        TaskModel(id: 't_2', title: '背 10 個英文單字', rewardCoins: 30),
        TaskModel(id: 't_3', title: '整理房間', rewardCoins: 50, status: TaskStatus.available),
      ];

  // 3. 預設使用者 (供測試身分切換使用)
  static final parentUser = UserModel(id: 'u_parent', name: '爸爸', role: UserRole.parent, groupId: '9999');
  static final childUser = UserModel(id: 'u_child', name: '小明', role: UserRole.child, groupId: '9999');
  static List<String> get initialChildMembers => ['小明', '小華'];

  static const String testJoinCode = '9999';
  static final initialGroup = GroupModel(id: 'g_101', name: '小明家', joinCode: testJoinCode);
}

