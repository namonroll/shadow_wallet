import 'package:flutter/material.dart';
import '../../../core/services/report_service.dart';
import '../../../data/models/report_model.dart';
import '../../daily_tasks/providers/task_provider.dart';

class ReportProvider extends ChangeNotifier {
  List<MonthlyReport> _reports = [];
  
  // Getter 讓 UI 能取得報表列表
  List<MonthlyReport> get reports => _reports;

  /// 【修正點】定義 UI 呼叫的 loadReports 方法
  void loadReports(String childId) {
    // 從 Service 抓取該孩子的歷史報表
    // 這裡我們假設 ReportService.fetchReports(childId) 已經實作
    final data = ReportService.fetchReports(childId);
    
    // 為了效能優化：只有當資料真的變動時才通知 UI 重新建構
    if (_reports != data) {
      _reports = data;
      notifyListeners();
    }
  }

  /// 模擬後端生成報表的邏輯 (開發測試用)
  void forceGenerateReport(String childId, TaskProvider taskProvider) {
    final now = DateTime.now();
    
    // 調用 Service 計算並產生報表
    ReportService.generateMonthlyReport(
      childId, 
      now.year, 
      now.month, 
      taskProvider.displayHistory, // 傳入目前的完成紀錄進行運算
    );
    
    // 生成後重新載入
    loadReports(childId); 
  }
}