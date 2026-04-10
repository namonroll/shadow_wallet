import 'package:flutter/material.dart';

//寫死錢包餘額1000，等後端接了再改成用service從後端拿
class WalletProvider extends ChangeNotifier {
  int _balance = 1000; // 小孩的錢包餘額

  int get balance => _balance;

  // 增加餘額 (家長核准任務時呼叫)
  void addCoins(int amount) {
    _balance += amount;
    notifyListeners();
  }
}