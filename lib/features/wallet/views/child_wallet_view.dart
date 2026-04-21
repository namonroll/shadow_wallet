import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';

class ChildWalletView extends StatelessWidget {
  const ChildWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    // 監聽錢包餘額
    final balance = context.watch<WalletProvider>().balance;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 135, 151, 216), Color.fromARGB(255, 113, 108, 255)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('目前餘額', style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 10),
                Text(
                  '💰 $balance 幣',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const ListTile(
            leading: Icon(Icons.history, color: Colors.blue),
            title: Text('收支明細'),
            subtitle: Text('（目前尚無紀錄）'),
          ),
        ],
      ),
    );
  }
}