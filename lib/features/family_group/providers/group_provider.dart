import 'package:flutter/material.dart';
import '../../../core/models/group_model.dart';
import '../../../core/models/member_profile_enums.dart'; // 記得引入 Enum
import '../services/group_mock_service.dart';
import '../../../core/mock/mock_database.dart'; 

class GroupProvider extends ChangeNotifier {
  final GroupMockService _service = GroupMockService();
  GroupModel? _currentGroup;
  bool _isLoading = false;
  String _errorMessage = '';

  // 🌟 修改：從 MockData 取得初始名單 (使用 List.from 這樣以後才能新增成員)
  final List<String> _members = List.from(MockData.initialChildMembers);

  final Map<String, Map<String, dynamic>> _memberSettings = {};

  GroupModel? get currentGroup => _currentGroup;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  
  List<String> get members => _members;
  Map<String, Map<String, dynamic>> get memberSettings => _memberSettings;

  void updateMemberProfile({
    required String name,
    required AgeGroup age,
    required ChildPersonality personality,
    required ParentStyle style,
  }) {
    _memberSettings[name] = {
      'age': age,
      'personality': personality,
      'style': style,
    };
    notifyListeners();
  }

  // 小孩加入群組
  Future<bool> joinGroup(String code) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _currentGroup = await _service.joinGroupByCode(code);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 家長建立群組
  Future<bool> createGroup(String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentGroup = await _service.createGroup(name);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}