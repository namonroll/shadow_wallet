import '../enums.dart';

class Parent {
  final String parentId;
  final String familyId;
  final String name;
  final UserRole role; // 預設家長
  final String baumrindType; // 教養模式
  final String aiMode; // 保守/平衡/自助
  final DateTime createdAt;

  Parent({
    required this.parentId,
    required this.familyId,
    required this.name,
    this.role = UserRole.parent,
    required this.baumrindType,
    required this.aiMode,
    required this.createdAt,
  });

  Parent copyWith({String? name, String? baumrindType, String? aiMode}) => Parent(
    parentId: parentId, familyId: familyId, createdAt: createdAt,
    name: name ?? this.name,
    baumrindType: baumrindType ?? this.baumrindType,
    aiMode: aiMode ?? this.aiMode,
  );

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
    parentId: json['parent_id'], familyId: json['family_id'], name: json['name'],
    baumrindType: json['baumrind_type'], aiMode: json['ai_mode'],
    createdAt: DateTime.parse(json['created_at']),
  );

  Map<String, dynamic> toJson() => {
    'parent_id': parentId, 'family_id': familyId, 'name': name,
    'baumrind_type': baumrindType, 'ai_mode': aiMode, 'created_at': createdAt.toIso8601String(),
  };
}