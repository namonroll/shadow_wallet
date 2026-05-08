
import 'family_model.dart';

class Child {
  final String childId;
  final String familyId;
  final String nickname;
  final DateTime birthDate;
  final String ageGroup;
  final String pinCode;
  
  // 關聯對象預留
  final Family? family;

  Child({
    required this.childId,
    required this.familyId,
    required this.nickname,
    required this.birthDate,
    required this.ageGroup,
    required this.pinCode,
    this.family,
  });

  Child copyWith({String? nickname, String? ageGroup, String? pinCode, Family? family}) => Child(
    childId: childId,
    familyId: familyId,
    nickname: nickname ?? this.nickname,
    birthDate: birthDate,
    ageGroup: ageGroup ?? this.ageGroup,
    pinCode: pinCode ?? this.pinCode,
    family: family ?? this.family,
  );

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    childId: json['child_id'],
    familyId: json['family_id'],
    nickname: json['nickname'],
    birthDate: DateTime.parse(json['birth_date']),
    ageGroup: json['age_group'],
    pinCode: json['pin_code'],
  );

  Map<String, dynamic> toJson() => {
    'child_id': childId,
    'family_id': familyId,
    'nickname': nickname,
    'birth_date': birthDate.toIso8601String(),
    'age_group': ageGroup,
    'pin_code': pinCode,
  };
}