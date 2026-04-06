enum UserRole { parent, child, none }

class UserModel {
  final String id;
  final String name;
  final UserRole role;
  String? groupId; // 記錄使用者加入的群組 ID

  UserModel({
    required this.id,
    required this.name,
    required this.role,
    this.groupId,
  });

  // 未來接 API 時，這裡會寫 fromJson 和 toJson
}