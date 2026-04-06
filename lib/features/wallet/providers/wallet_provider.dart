import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  int _balance = 0; // 小孩的錢包餘額

  int get balance => _balance;

  // 增加餘額 (家長核准任務時呼叫)
  void addCoins(int amount) {
    _balance += amount;
    notifyListeners();
  }
}