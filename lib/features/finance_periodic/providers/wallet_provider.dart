import 'package:flutter/material.dart';
import '../../../core/services/data_service.dart';
import '../../../data/models/wallet.dart';
import '../../../data/enums.dart';

class WalletProvider extends ChangeNotifier {
  final List<Wallet> _wallets = DataService.fetchWallets();

  Wallet get pocketMoneyWallet => 
      _wallets.firstWhere((w) => w.walletType == WalletType.pocketMoney);

  Wallet get savingsWallet => 
      _wallets.firstWhere((w) => w.walletType == WalletType.savings);

  // --- 財務邏輯 (保留並集中管理) ---

  void addIncome(int amount) {
    // 找到零用錢錢包的索引
    int index = _wallets.indexWhere((w) => w.walletType == WalletType.pocketMoney);
    if (index != -1) {
      _wallets[index] = _wallets[index].copyWith(
        balance: _wallets[index].balance + amount,
      );
      notifyListeners(); // 通知 UI 更新紅字消失後的新數值
    }
  }

  void performWeeklySettlement() {
    int index = _wallets.indexWhere((w) => w.walletType == WalletType.savings);
    if (index != -1) {
      double interest = _wallets[index].balance * _wallets[index].interestRate;
      _wallets[index] = _wallets[index].copyWith(
        balance: _wallets[index].balance + interest,
        lastInterestAt: DateTime.now(),
      );
      notifyListeners();
    }
  }
  void updateInterestRate(double newRate) {
  int index = _wallets.indexWhere((w) => w.walletType == WalletType.savings);
  if (index != -1) {
    _wallets[index] = _wallets[index].copyWith(interestRate: newRate);
    notifyListeners(); // 這行很重要，這會讓 UI 的 % 數立即改變
  }
}
}