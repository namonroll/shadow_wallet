import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/auth_provider.dart';
import 'parent_main_navigation.dart';
import 'child_main_navigation.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 監聽當前身份
    final isParent = context.watch<AuthProvider>().isParent;

    // 根據身份，返回完全不同的底層導航框架
    return isParent 
        ? const ParentMainNavigation() 
        : const ChildMainNavigation();
  }
}