import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadow_wallet/features/main_navigation/view/root_screen.dart';
import 'core/providers/auth_provider.dart';
import 'features/reports/providers/report_provider.dart';
import 'features/daily_tasks/providers/task_provider.dart';
import 'features/finance_periodic/providers/wallet_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
      ],
      child: const ShadowWalletApp(),
    ),
  );
}

class ShadowWalletApp extends StatelessWidget {
  const ShadowWalletApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shadow Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // 將主導航畫面設定為首頁
      home: const RootScreen(),
    );
  }
}