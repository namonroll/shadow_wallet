import '../models/family_model.dart';
import '../models/child_model.dart';
import '../models/parent.dart';
import '../models/task_model.dart';
import '../models/override.dart';
import '../models/child_profile.dart';
import '../models/wallet.dart';
import '../models/task_completion.dart';
import '../enums.dart';
import '../models/report_model.dart';

class MockDatabase {
  // 1. 家庭與成員
  static final family = Family(familyId: "F01", familyName: "王家", createdAt: DateTime.now(), timezone: "Asia/Taipei");
  
  static final parent = Parent(
    parentId: "P01", familyId: "F01", name: "大明", 
    baumrindType: "權威開明型", aiMode: "平衡模式", createdAt: DateTime.now()
  );

  static final child = Child(
    childId: "C01", familyId: "F01", nickname: "小明", 
    birthDate: DateTime(2018, 1, 1), ageGroup: "6-9", pinCode: "0000"
  );

  // 2. 孩子設定
  static final childProfile = ChildProfile(
    profileId: "CP01", childId: "C01", motivationLevel: "高", 
    personalityType: "理智型", interestTags: ["積木", "繪畫"], 
    accountType: AccountType.double, updatedAt: DateTime.now()
  );

  // 3. 錢包系統 (流程 C 所需)
  static final wallets = [
    Wallet(walletId: "W01", childId: "C01", walletType: WalletType.pocketMoney, balance: 150.0, interestRate: 0.0),
    Wallet(walletId: "W02", childId: "C01", walletType: WalletType.savings, balance: 1200.0, interestRate: 0.05),
  ];
  static final List<Task> sampleTasks = [
    Task(
      taskId: "task_01",
      familyId: "fam_001",
      name: "自己整理書包",
      category: TaskCategory.A,
      dayType: TaskDayType.weekday,
      description: "收書包",
      isLongTerm: false,
      baseCoin: 5,
    ),
    Task(
      taskId: "task_02",
      familyId: "fam_001",
      name: "練習鋼琴",
      category: TaskCategory.B,
      dayType: TaskDayType.weekend,
      description: "練習鋼琴 30 分鐘",
      isLongTerm: true,
      baseCoin: 20,
    ),
    Task(
      taskId: "task_03",
      familyId: "fam_001",
      name: "洗碗",
      category: TaskCategory.C,
      dayType: TaskDayType.weekday,
      description: "洗一下碗",
      isLongTerm: false,
      baseCoin: 10,
    ),
  ];
  // 4. 任務完成與異常標記 (流程 B 所需)
  static final completions = [
    TaskCompletion(
      completionId: "TC01", taskId: "T01", childId: "C01", 
      completedAt: DateTime.now(), reportedBy: UserRole.child, 
      status: TaskStatus.completed, coinEarned: 10, timeSavedMin: 15
    ),
  ];

  static final overrides = [
    OverrideRecord(
      overrideId: "OR01", completionId: "TC01", parentId: "P01", 
      overrideType: OverrideType.reward, coinDeducted: 0, creditFlag: true, reason: "表現優異額外獎勵"
    ),
  ];
  static List<MonthlyReport> monthlyReports = [
    MonthlyReport(
      reportId: "REP_2026_03_child_1",
      childId: "child_1", // 必須對應到你任務中的 childId
      year: 2026,
      month: 3,
      totalTasksCompleted: 15,
      totalCoinsEarned: 150,
      motivationAnalysis: "小明本月表現穩定，特別是在『做家事』類別展現了高度的主動性！建議下個月可以嘗試給予更具挑戰性的目標。",
    ),
    MonthlyReport(
      reportId: "REP_2026_04_child_1",
      childId: "child_1",
      year: 2026,
      month: 4,
      totalTasksCompleted: 22,
      totalCoinsEarned: 220,
      motivationAnalysis: "本月進步神速！完成率提升了 40%，動機光譜顯示已從『外在獎勵驅動』逐漸轉向『成就感驅動』。",
    ),
  ];
}
