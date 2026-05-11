import '../../../data/models/task_completion.dart';
import '../../../data/models/report_model.dart';

class ReportService {
  // 模擬後端的資料庫表
  static final List<MonthlyReport> _mockReportDatabase = [];
  
  // 取得歷史報表
  static List<MonthlyReport> fetchReports(String childId) {
    return _mockReportDatabase.where((r) => r.childId == childId).toList();
  }

  // 模擬後端在月底自動執行的「結算程式」
  static MonthlyReport generateMonthlyReport(String childId, int year, int month, List<TaskCompletion> allLogs) {
    // 1. 篩選出該月份的紀錄
    final monthlyLogs = allLogs.where((log) {
      return log.childId == childId &&
             log.completedAt.year == year &&
             log.completedAt.month == month;
    }).toList();

    // 2. 統計數據
    int totalCoins = 0;
    for (var log in monthlyLogs) {
      totalCoins += log.coinEarned;
    }

    // 3. 模擬動機光譜/AI 評語生成邏輯
    String analysis = monthlyLogs.length > 10 ? "動機增加喔" : "沒什麼動機喔";

    // 4. 產生報表快照並「存入資料庫」
    final newReport = MonthlyReport(
      reportId: "REP_${year}_${month}_$childId",
      childId: childId,
      year: year,
      month: month,
      totalTasksCompleted: monthlyLogs.length,
      totalCoinsEarned: totalCoins,
      motivationAnalysis: analysis,
    );

    _mockReportDatabase.add(newReport); // 存檔
    return newReport;
  }
}