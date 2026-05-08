import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isParent = context.watch<AuthProvider>().isParent;
    return Center(
      child: Text(
        isParent ? '家長端主頁 (數據儀表板)' : '孩子端主頁 (今日概況)',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}