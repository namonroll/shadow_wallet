import '../../../core/mock/mock_database.dart'; // 引入統一資料倉庫
import '../../../core/models/group_model.dart';

class GroupMockService {
  // 模擬：透過序號加入群組
  Future<GroupModel> joinGroupByCode(String code) async {
    await Future.delayed(const Duration(seconds: 1)); // 模擬網路延遲
    
    // 改為比對 MockData 裡的序號
    if (code == MockData.testJoinCode) {
      return MockData.initialGroup; 
    } else {
      throw Exception('找不到該群組，請確認序號是否正確！');
    }
  }

  // 模擬：家長建立新群組
  Future<GroupModel> createGroup(String familyName) async {
    await Future.delayed(const Duration(seconds: 1));
    // 這裡可以回傳一個基於 MockData 格式的新物件
    return GroupModel(
      id: 'g_${DateTime.now().millisecondsSinceEpoch}',
      name: familyName,
      joinCode: MockData.testJoinCode, // 測試期間維持一致的序號方便測試
    );
  }
}