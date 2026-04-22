import 'package:flutter/material.dart';
import '../../../core/mock/mock_database.dart';

class WalletProvider extends ChangeNotifier {
  // 儲存所有孩子的餘額
  final Map<String, int> _balances = Map.from(MockData.initialBalances);

  // 取得特定孩子的餘額
  int getBalance(String childName) {
    return _balances[childName] ?? 0;
  }

  // 🌟 增加特定孩子的餘額
  void addBalance(String childName, int amount) {
    if (_balances.containsKey(childName)) {
      _balances[childName] = _balances[childName]! + amount;
      notifyListeners();
    }
  }

  // 🌟 扣除特定孩子的餘額 (掃描購物用)
  void deductBalance(String childName, int amount) {
    if (_balances.containsKey(childName) && _balances[childName]! >= amount) {
      _balances[childName] = _balances[childName]! - amount;
      notifyListeners();
    }
  }
}