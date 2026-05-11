import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/wallet_provider.dart';

class SettlementCard extends StatelessWidget {
  const SettlementCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final summary = context.watch<WalletProvider>().lastSettlementSummary;

    if (summary == null) return const SizedBox.shrink();
    
    return Card(
      color: Colors.indigo.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.indigo.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.auto_awesome, color: Colors.indigo),
                const SizedBox(width: 8),
                const Text("本週儲蓄獎勵", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("產生的利息"),
                Text("+\$${summary['interestEarned'].toStringAsFixed(1)}", 
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
            const SizedBox(height: 8),
            Text("儲蓄金已自動滾入下週本金", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}