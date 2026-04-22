import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../../auth/providers/auth_provider.dart';
import 'scan_product_view.dart'; 

class ChildWalletView extends StatelessWidget {
  const ChildWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final balance = context.watch<WalletProvider>().getBalance(user?.name ?? '');

    return SingleChildScrollView( // 加上捲動支撐，預防小螢幕遮擋
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // 1. 餘額卡片
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
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('目前餘額', style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '💰 $balance 幣',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
                      onPressed: () => _goToScan(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 25),

          // 2. 快捷功能區塊 (新增掃描按鈕)
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  icon: Icons.camera_alt,
                  label: '掃描商品',
                  color: Colors.orange,
                  onTap: () => _goToScan(context),
                ),
              ),
              const SizedBox(width: 15),
              
            ],
          ),

          const SizedBox(height: 30),
          
          // 3. 收支明細
          const Divider(),
          const ListTile(
            leading: Icon(Icons.history, color: Colors.blueGrey),
            title: Text('收支明細', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // 封裝導向掃描頁面的邏輯
  void _goToScan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScanProductView()),
    );
  }

  // 封裝功能按鈕的 UI
  Widget _buildActionButton(BuildContext context, {
    required IconData icon, 
    required String label, 
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}