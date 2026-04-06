import 'package:flutter/material.dart';
import '../../../core/models/group_model.dart';
import '../services/group_mock_service.dart';

class GroupProvider extends ChangeNotifier {
  final GroupMockService _service = GroupMockService();
  GroupModel? _currentGroup;
  bool _isLoading = false;
  String _errorMessage = '';

  GroupModel? get currentGroup => _currentGroup;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // 小孩加入群組
  Future<bool> joinGroup(String code) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _currentGroup = await _service.joinGroupByCode(code);
      _isLoading = false;
      notifyListeners();
      return true; // 成功
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false; // 失敗
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