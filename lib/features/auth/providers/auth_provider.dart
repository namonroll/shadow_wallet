import 'package:flutter/material.dart';
import '../../../core/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  // 核心資料：維持使用 UserModel 作為唯一的資料來源
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  UserRole? get role => _currentUser?.role;
  String? get groupId => _currentUser?.groupId;
  bool get isInGroup => _currentUser?.groupId != null && _currentUser!.groupId!.isNotEmpty;



  void setRoleAndLogin(UserRole role, String name) {
    _currentUser = UserModel(
      id: 'u_123',
      name: name,
      role: role,
    );
    notifyListeners(); // 通知畫面更新
  }

  void joinGroup(String code) {
    if (_currentUser != null) {

      _currentUser!.groupId = "group_$code"; 
      notifyListeners();
    }
  }

  void updateUserGroup(String groupId) {
    if (_currentUser != null) {
      _currentUser!.groupId = groupId;
      notifyListeners();
    }
  }
}