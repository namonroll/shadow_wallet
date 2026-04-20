import '../../features/task_board/models/task_model.dart';
import '../models/user_model.dart';
import '../models/group_model.dart';
import '../../core/models/member_profile_enums.dart';

class MockData {
  // 1. 錢包初始餘額
  static const int initialBalance = 1000;

  // 2. 預設任務列表 
  static List<TaskModel> get initialTasks => [
        TaskModel(id: 't_1', title: '洗碗', rewardCoins: 15,assigneeName: '小明'),
        TaskModel(id: 't_2', title: '背 10 個英文單字', rewardCoins: 30, assigneeName: '小華'),
        TaskModel(id: 't_3', title: '整理房間', rewardCoins: 50, status: TaskStatus.available, assigneeName: '小明'),
      ];
  //系統推薦任務
  static Map<ChildPersonality, List<Map<String, dynamic>>> get recommendedTasks => {
    ChildPersonality.lion: [
      {'title': '挑戰 30 分鐘內讀完一本書', 'reward': 50},
      {'title': '運動紀錄連續 3 天', 'reward': 100},
    ],
    ChildPersonality.dolphin: [
      {'title': '協助長輩準備晚餐', 'reward': 40},
      {'title': '分享今天的一件好事', 'reward': 20},
    ],
    ChildPersonality.cat: [
      {'title': '觀察並紀錄一種昆蟲', 'reward': 60},
      {'title': '完成一個科學小實驗', 'reward': 80},
    ],
  };

  // 3. 預設使用者 (供測試身分切換使用)
  static final parentUser = UserModel(id: 'u_parent', name: '爸爸', role: UserRole.parent, groupId: '9999');
  static final childUser = UserModel(id: 'u_child', name: '小明', role: UserRole.child, groupId: '9999');
  static List<String> get initialChildMembers => ['小明', '小華'];

  static const String testJoinCode = '9999';
  static final initialGroup = GroupModel(id: 'g_101', name: '小明家', joinCode: testJoinCode);
}

