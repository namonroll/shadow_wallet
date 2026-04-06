// 任務狀態的列舉 
enum TaskStatus {
  available,  // 待領取 (剛發布)
  inProgress, // 進行中 (小孩已領取)
  underReview,// 審核中 (小孩提交證明，等家長確認)
  completed   // 已完成 (家長已給錢)
}

class TaskModel {
  final String id;
  final String title;
  final int rewardCoins; // 影子幣獎勵
  TaskStatus status;

  TaskModel({
    required this.id,
    required this.title,
    required this.rewardCoins,
    this.status = TaskStatus.available, // 預設狀態是待領取
  });
}