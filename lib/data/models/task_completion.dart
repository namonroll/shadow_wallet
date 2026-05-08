import '../enums.dart';

class TaskCompletion {
  final String completionId;
  final String taskId;
  final String childId;
  final DateTime completedAt;
  final UserRole reportedBy;
  final TaskStatus status;
  final int coinEarned;
  final int timeSavedMin;
  final String? overrideId; // FK to Override

  TaskCompletion({
    required this.completionId, required this.taskId, required this.childId,
    required this.completedAt, required this.reportedBy, required this.status,
    required this.coinEarned, required this.timeSavedMin, this.overrideId,
  });
  // ... JSON methods 略
  TaskCompletion copyWith({String? completionId, String? taskId, String? childId, DateTime? completedAt, UserRole? reportedBy, TaskStatus? status, int? coinEarned, int? timeSavedMin, String? overrideId}) => TaskCompletion(
    completionId: completionId ?? this.completionId,
    taskId: taskId ?? this.taskId,
    childId: childId ?? this.childId,
    completedAt: completedAt ?? this.completedAt,
    reportedBy: reportedBy ?? this.reportedBy,
    status: status ?? this.status,
    coinEarned: coinEarned ?? this.coinEarned,
    timeSavedMin: timeSavedMin ?? this.timeSavedMin,
    overrideId: overrideId ?? this.overrideId,
  );
}

