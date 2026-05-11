import 'package:flutter/material.dart';
import '../../../core/services/data_service.dart';
import '../../../data/models/wallet.dart';
import '../../../data/enums.dart';

class WalletProvider extends ChangeNotifier {
  final List<Wallet> _wallets = DataService.fetchWallets();
  
  // 紀錄本週結算的摘要，供 UI 顯示
  Map<String, dynamic>? _lastSettlementSummary;
  Map<String, dynamic>? get lastSettlementSummary => _lastSettlementSummary;

  Wallet get pocketMoneyWallet => _wallets.firstWhere((w) => w.walletType == WalletType.pocketMoney);
  Wallet get savingsWallet => _wallets.firstWhere((w) => w.walletType == WalletType.savings);

  // 修改餘額 (通用方法)
  void addIncome(int amount) {
    int index = _wallets.indexWhere((w) => w.walletType == WalletType.pocketMoney);
    if (index != -1) {
      _wallets[index] = _wallets[index].copyWith(balance: _wallets[index].balance + amount);
      notifyListeners();
    }
  }

  /// 核心邏輯：執行每週結算 (全流程 C 的週日自動觸發)
  void performWeeklySettlement() {
    double currentSavings = savingsWallet.balance;
    double interestRate = savingsWallet.interestRate;
    double interestEarned = currentSavings * interestRate; // 利息 = 餘額 * 利率

    // 1. 更新儲蓄帳戶餘額
    int sIndex = _wallets.indexWhere((w) => w.walletType == WalletType.savings);
    _wallets[sIndex] = _wallets[sIndex].copyWith(
      balance: currentSavings + interestEarned,
      lastInterestAt: DateTime.now(),
    );

    // 2. 產生本週摘要 (孩子端顯示用)
    _lastSettlementSummary = {
      'date': DateTime.now(),
      'interestEarned': interestEarned,
      'totalBalance': _wallets[sIndex].balance,
      'status': 'success'
    };

    // 3. 存入服務層
    DataService.saveSettlementLog(_lastSettlementSummary!);

    notifyListeners();
  }

  /// 家長調整利率 (調整教育參數)
  void updateInterestRate(double newRate) {
    int index = _wallets.indexWhere((w) => w.walletType == WalletType.savings);
    if (index != -1) {
      _wallets[index] = _wallets[index].copyWith(interestRate: newRate);
      notifyListeners();
    }
  }
}