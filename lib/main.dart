import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/views/role_selection_view.dart';
import 'features/family_group/providers/group_provider.dart';
import 'features/task_board/providers/task_provider.dart';
import 'features/wallet/providers/wallet_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // 把Provider 註冊進來
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RoleSelectionView(),
    );
  }
}