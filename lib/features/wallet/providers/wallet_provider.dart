import 'package:flutter/material.dart';
import '../../../core/mock/mock_database.dart';

class WalletProvider extends ChangeNotifier {
  // 從 MockData 讀取初始金額
  int _balance = MockData.initialBalance;

  int get balance => _balance;

  void addCoins(int amount) {
    _balance += amount;
    notifyListeners();
  }
}