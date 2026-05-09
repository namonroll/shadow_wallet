import '../enums.dart';

class Task {
  final String taskId;
  final String familyId;
  final String? targetChildId; // 可選，若為 null 代表全家通用
  final String name;
  final TaskCategory category;
  final TaskDayType dayType;
  final String description;
  final bool isLongTerm;
  final int baseCoin;
  final bool isActive;

  Task({
    required this.taskId,
    required this.familyId,
    this.targetChildId,
    required this.name,
    required this.category,
    required this.dayType,
    required this.description,
    required this.isLongTerm,
    required this.baseCoin,
    this.isActive = true,
  });

  Task copyWith({String? name, bool? isActive, int? baseCoin}) => Task(
    taskId: taskId,
    familyId: familyId,
    targetChildId: targetChildId,
    name: name ?? this.name,
    category: category,
    dayType: dayType,
    description: description,
    isLongTerm: isLongTerm,
    baseCoin: baseCoin ?? this.baseCoin,
    isActive: isActive ?? this.isActive,
  );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    taskId: json['task_id'],
    familyId: json['family_id'],
    name: json['name'],
    category: TaskCategory.values.byName(json['category']),
    dayType: TaskDayType.values.byName(json['day_type']),
    description: json['description'] ?? '',
    isLongTerm: json['is_long_term'],
    baseCoin: json['base_coin'],
    isActive: json['is_active'] ?? true,
  );

  Map<String, dynamic> toJson() => {
    'task_id': taskId,
    'family_id': familyId,
    'name': name,
    'category': category.name,
    'day_type': dayType.name,
    'description': description,
    'is_long_term': isLongTerm,
    'base_coin': baseCoin,
    'is_active': isActive,
  };
}