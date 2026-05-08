import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../../../data/enums.dart';

class ChildWalletView extends StatelessWidget {
  const ChildWalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WalletProvider>();
    final pocketMoney = provider.getWallet(WalletType.pocketMoney);
    final savings = provider.getWallet(WalletType.savings);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildWalletCard(
            title: "我的零用錢",
            amount: pocketMoney.balance,
            color: Colors.orange.shade100,
            icon: Icons.monetization_on,
          ),
          const SizedBox(height: 16),
          _buildWalletCard(
            title: "我的儲蓄金 (利息: ${(savings.interestRate * 100).toInt()}%)",
            amount: savings.balance,
            color: Colors.blue.shade100,
            icon: Icons.account_balance,
          ),
          const Spacer(),
          const Text("小提示：把錢放進儲蓄金，每週日會長出更多錢喔！"),
        ],
      ),
    );
  }

  Widget _buildWalletCard({required String title, required double amount, required Color color, required IconData icon}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(icon), const SizedBox(width: 8), Text(title)]),
          const SizedBox(height: 12),
          Text("\$${amount.toStringAsFixed(1)}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}