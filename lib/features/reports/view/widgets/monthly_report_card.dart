import 'package:flutter/material.dart';
import '../../../../data/models/report_model.dart';

class MonthlyReportCard extends StatelessWidget {
  final MonthlyReport report;

  const MonthlyReportCard({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.indigo.shade100),
      ),
      child: Column(
        children: [
          // 頂部月份標籤
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.indigo.shade500,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${report.year} 年 ${report.month} 月", 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                const Icon(Icons.auto_awesome, color: Colors.amber, size: 20),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. 核心數據區 (正規做法：此數據由後端聚合算出)
                Row(
                  children: [
                    _buildStatItem("完成任務", "${report.totalTasksCompleted}", Icons.task_alt, Colors.blue),
                    const VerticalDivider(),
                    _buildStatItem("獲得獎勵", "\$${report.totalCoinsEarned}", Icons.monetization_on, Colors.orange),
                  ],
                ),
                const Divider(height: 32),

                // 2. AI 智能分析評語 (對應 流程C_2.png：家長端肯定提示)
                const Text("🤖 AI 成長導師分析", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    report.motivationAnalysis,
                    style: TextStyle(color: Colors.brown.shade800, height: 1.5),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // 3. 動作連結 (快速任務調整入口)
                OutlinedButton(
                  onPressed: () { /* 跳轉至任務管理 */ },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text("根據報告調整下月任務"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}