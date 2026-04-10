import '../../../core/models/group_model.dart';
//先寫死資料，之後再接後端
class GroupMockService {
  // 模擬資料庫中已經存在的一個家庭
  final GroupModel _mockDatabaseGroup = GroupModel(
    id: 'g_101',
    name: '小明家',
    joinCode: '9999', // 測試用的加入序號
  );

  // 模擬：透過序號加入群組
  Future<GroupModel> joinGroupByCode(String code) async {
    await Future.delayed(const Duration(seconds: 1)); // 模擬網路延遲1秒
    
    if (code == _mockDatabaseGroup.joinCode) {
      return _mockDatabaseGroup; // 序號正確，回傳群組資料
    } else {
      throw Exception('找不到該群組，請確認序號是否正確！'); // 序號錯誤
    }
  }

  // 模擬：家長建立新群組
  Future<GroupModel> createGroup(String familyName) async {
    await Future.delayed(const Duration(seconds: 1));
    return GroupModel(
      id: 'g_${DateTime.now().millisecondsSinceEpoch}', // 隨機產生ID
      name: familyName,
      joinCode: '9999', // 模擬產生的新序號
    );
  }
}