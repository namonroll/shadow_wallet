import 'package:flutter/material.dart';
import '../../../data/models/wallet.dart';
import '../../../data/mock/mock_database.dart';
import '../../../data/enums.dart';

class WalletProvider extends ChangeNotifier {
  List<Wallet> _wallets = MockDatabase.wallets;

  List<Wallet> get wallets => _wallets;

  // 取得特定類型的錢包
  Wallet getWallet(WalletType type) => 
      _wallets.firstWhere((w) => w.walletType == type);

  // 模擬收到任務獎勵
  void addIncome(int amount) {
    int index = _wallets.indexWhere((w) => w.walletType == WalletType.pocketMoney);
    if (index != -1) {
      _wallets[index] = _wallets[index].copyWith(
        balance: _wallets[index].balance + amount,
      );
      notifyListeners();
    }
  }

  // 實作流程 C：利息計算與週期性結算
  void performWeeklySettlement() {
    for (int i = 0; i < _wallets.length; i++) {
      if (_wallets[i].walletType == WalletType.savings) {
        // 計算利息：餘額 * 利率
        double interest = _wallets[i].balance * _wallets[i].interestRate;
        _wallets[i] = _wallets[i].copyWith(
          balance: _wallets[i].balance + interest,
          lastInterestAt: DateTime.now(),
        );
      }
    }
    notifyListeners();
  }

  // 家長調整利率
  void updateInterestRate(double newRate) {
    int index = _wallets.indexWhere((w) => w.walletType == WalletType.savings);
    if (index != -1) {
      _wallets[index] = _wallets[index].copyWith(interestRate: newRate);
      notifyListeners();
    }
  }
}