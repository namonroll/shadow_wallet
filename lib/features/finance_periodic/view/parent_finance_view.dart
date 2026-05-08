import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../../../data/enums.dart';

class ParentFinanceView extends StatelessWidget {
  const ParentFinanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WalletProvider>();
    final savings = provider.getWallet(WalletType.savings);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("家庭財務狀態", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ListTile(
          title: const Text("儲蓄金年利率設定"),
          subtitle: Text("目前設定: ${(savings.interestRate * 100).toInt()}%"),
          trailing: const Icon(Icons.edit),
          onTap: () {
            // 這裡可以跳出對話框讓家長修改利率
            provider.updateInterestRate(0.10); // 模擬改為 10%
          },
        ),
        const Divider(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text("結算模擬 (開發測試用)"),
                ElevatedButton(
                  onPressed: () => provider.performWeeklySettlement(),
                  child: const Text("執行週日結算 (加發利息)"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}