class MonthlyReport {
  final String reportId;
  final String childId;
  final int year;
  final int month;
  final int totalTasksCompleted;
  final int totalCoinsEarned;
  final String motivationAnalysis; // AI 或系統生成的評語快照

  MonthlyReport({
    required this.reportId,
    required this.childId,
    required this.year,
    required this.month,
    required this.totalTasksCompleted,
    required this.totalCoinsEarned,
    required this.motivationAnalysis,
  });
}