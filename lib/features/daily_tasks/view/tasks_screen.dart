import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/auth_provider.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isParent = context.watch<AuthProvider>().isParent;
    return Center(
      child: Text(
        isParent ? '任務清單' : '孩子端任務清單',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}