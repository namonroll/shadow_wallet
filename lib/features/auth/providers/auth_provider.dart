import 'package:flutter/material.dart';
import '../../../core/models/user_model.dart'; // 確保 UserRole 的 enum 是定義在這裡的
//身分資料先寫死在provider裡，等後端串接了再改成用service從後端拿
class AuthProvider extends ChangeNotifier {
  // 核心資料：維持使用 UserModel 作為唯一的資料來源
  UserModel? _currentUser;

  // ==========================================
  // 1. [取得狀態的 Getter]
  // ==========================================
  
  // 原本的 Getter：提供給舊畫面讀取使用者資料
  UserModel? get currentUser => _currentUser;

  // 新增的 Getter：專門提供給 ChildNavScaffold (導覽列) 判斷用的
  UserRole? get role => _currentUser?.role;
  String? get groupId => _currentUser?.groupId;
  
  // 輔助判斷：只要 currentUser 存在，且裡面的 groupId 不是 null，就代表已加入群組
  bool get isInGroup => _currentUser?.groupId != null && _currentUser!.groupId!.isNotEmpty;

  // ==========================================
  // 2. [操作資料的方法 (Methods)]
  // ==========================================

  void setRoleAndLogin(UserRole role, String name) {
    _currentUser = UserModel(
      id: 'u_123',
      name: name,
      role: role,
    );
    notifyListeners(); // 通知畫面更新
  }

  // 融合你的 joinGroup 邏輯：小孩輸入序號後呼叫這個
  void joinGroup(String code) {
    if (_currentUser != null) {
      // 將資料寫入 currentUser 模型中
      _currentUser!.groupId = "group_$code"; 
      notifyListeners();
    }
  }

  // 保留原本的 updateUserGroup：以防家長端或其他地方有用到
  void updateUserGroup(String groupId) {
    if (_currentUser != null) {
      _currentUser!.groupId = groupId;
      notifyListeners();
    }
  }
}