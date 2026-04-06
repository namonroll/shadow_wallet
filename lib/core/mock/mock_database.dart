import '../models/group_model.dart';

// 這是一個簡單的「偽資料庫」，全 App 共用同一個實體
class MockDatabase {
  static final MockDatabase _instance = MockDatabase._internal();
  factory MockDatabase() => _instance;
  MockDatabase._internal();

  // 模擬雲端的群組列表
  final List<GroupModel> groups = [
    GroupModel(id: 'g_1', name: '預設家庭', joinCode: '1234'),
  ];
}