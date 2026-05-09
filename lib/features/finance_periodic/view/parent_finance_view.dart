import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';

class ParentFinanceView extends StatelessWidget {
  const ParentFinanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 使用 watch 監聽變化
    final provider = context.watch<WalletProvider>();
    
    // 修正點：使用我們新定義的專用 Getter
    final savings = provider.savingsWallet;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("家庭財務狀態", 
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        
        ListTile(
          title: const Text("儲蓄金年利率設定"),
          // 這裡 savings.interestRate 就不會噴紅字了
          subtitle: Text("目前設定: ${(savings.interestRate * 100).toInt()}%"),
          trailing: const Icon(Icons.edit),
          onTap: () {
            // 呼叫剛剛補上的方法
            provider.updateInterestRate(0.12); // 模擬改為 12%
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('利率已更新為 12%')),
            );
          },
        ),
        const Divider(),
        
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text("結算模擬 (開發測試用)", 
                  style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("點擊按鈕將根據當前儲蓄金額計算利息並滾入本金"),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => provider.performWeeklySettlement(),
                  icon: const Icon(Icons.autorenew),
                  label: const Text("執行週日結算 (加發利息)"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}