import 'package:flutter/material.dart';
import '../../../core/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // 模擬登入 (設定身分)
void setRoleAndLogin(UserRole role, String name) {
    _currentUser = UserModel(
      id: 'u_123',
      name: name,
      role: role,
    );
    notifyListeners(); // 通知畫面更新
  }

  // 更新使用者的群組狀態
  void updateUserGroup(String groupId) {
    if (_currentUser != null) {
      _currentUser!.groupId = groupId;
      notifyListeners();
    }
  }
}