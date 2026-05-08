import '../enums.dart';

class ChildProfile {
  final String profileId;
  final String childId;
  final String motivationLevel;
  final String personalityType;
  final List<String> interestTags;
  final AccountType accountType; // SINGLE/DOUBLE
  final DateTime updatedAt;

  ChildProfile({
    required this.profileId, required this.childId,
    required this.motivationLevel, required this.personalityType,
    required this.interestTags, required this.accountType,
    required this.updatedAt,
  });

  factory ChildProfile.fromJson(Map<String, dynamic> json) => ChildProfile(
    profileId: json['profile_id'], childId: json['child_id'],
    motivationLevel: json['motivation_level'], personalityType: json['personality_type'],
    interestTags: List<String>.from(json['interest_tags']),
    accountType: AccountType.values.byName(json['account_type']),
    updatedAt: DateTime.parse(json['updated_at']),
  );
  // ... toJson & copyWith 略
}