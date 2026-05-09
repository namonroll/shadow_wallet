import 'package:flutter/material.dart';
import '../../data/enums.dart';
import '../services/data_service.dart';
import '../../data/models/child_model.dart';
import '../../data/models/parent.dart';

class AuthProvider extends ChangeNotifier {
  // 1. 紀錄當前角色身份
  UserRole _currentRole = UserRole.child;
  
  // 2. 預載 MockDatabase 的實體資料 (未來替換成從 API fetch)
  final Child _childData = DataService.fetchChildInfo();
  final Parent _parentData = DataService.fetchParentInfo();
  String get familyId => _parentData.familyId;
  // 提供一個 getter 讓全 App 都能拿到目前的 FamilyId
  
  // 取得狀態
  UserRole get currentRole => _currentRole;
  bool get isParent => _currentRole == UserRole.parent;
  bool get isChild => _currentRole == UserRole.child;

  // 取得實體資料 (UI 層需要印出名字或讀取設定時用這個)
  Child get childData => _childData;
  Parent get parentData => _parentData;

  // 開發測試用：一鍵切換登入者
  void toggleRole() {
    _currentRole = isParent ? UserRole.child : UserRole.parent;
    notifyListeners();
  }
}