import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isParent = context.watch<AuthProvider>().isParent;
    return Center(
      child: Text(
        isParent ? '家長端個人檔案' : '孩子端個人檔案',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}