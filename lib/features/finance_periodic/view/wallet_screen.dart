import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/auth_provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isParent = context.watch<AuthProvider>().isParent;
    return Center(
      child: Text(
        isParent ? '家長端錢包' : '孩子端錢包',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}