import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';

class ParentFinanceView extends StatelessWidget {
  const ParentFinanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletProvider = context.watch<WalletProvider>();
    final savings = walletProvider.savingsWallet;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("利息與結算設定", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        
        // 1. 利率設定卡片
        Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.trending_up)),
            title: const Text("目前的週利率"),
            subtitle: Text("${(savings.interestRate * 100).toStringAsFixed(0)}% (每週結算一次)"),
            trailing: const Icon(Icons.edit),
            onTap: () => _showRateEditor(context, walletProvider),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // 2. 模擬結算按鈕 (開發階段手動觸發，正式環境為自動)
        ElevatedButton.icon(
          onPressed: () {
            walletProvider.performWeeklySettlement();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("結算完成！利息已撥入孩子帳戶")));
          },
          icon: const Icon(Icons.calculate),
          label: const Text("手動執行週結算 (模擬週日)"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
        ),
      ],
    );
  }

  void _showRateEditor(BuildContext context, WalletProvider provider) {
    // 先把初始值拿出來
    double tempRate = provider.savingsWallet.interestRate;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("調整教育利率"),
        content: StatefulBuilder( // 關鍵！有了它滑桿才會動
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("目前設定: ${(tempRate * 100).toInt()}%", 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo)),
                const SizedBox(height: 16),
                const Text("較高的利率能鼓勵孩子將錢存入儲蓄帳戶，而非隨意花掉。"),
                Slider(
                  value: tempRate,
                  min: 0.0,
                  max: 0.2, // 最高 20%
                  divisions: 20,
                  onChanged: (val) {
                    // 這裡的 setState 是 StatefulBuilder 提供的，會觸發 Dialog 重新繪製
                    setState(() => tempRate = val); 
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("取消")),
          TextButton(
            onPressed: () {
              provider.updateInterestRate(tempRate); // 確定後才寫入 Provider
              Navigator.pop(ctx);
            }, 
            child: const Text("確定修改"),
          ),
        ],
      ),
    );
  }
}