import 'package:flutter/material.dart';

void showWeeklyAffirmation(BuildContext context, String childName, int taskCount) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/trophy.png', height: 120), // 假設有獎盃圖
          const SizedBox(height: 16),
          Text("太棒了，$childName！", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text("本週你一共完成了 $taskCount 項任務，\n家長看到了你的努力與堅持！", 
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, height: 1.5)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: const Text("收下肯定", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}