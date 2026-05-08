class Family {
  final String familyId;
  final String familyName;
  final DateTime createdAt;
  final String timezone;

  Family({
    required this.familyId,
    required this.familyName,
    required this.createdAt,
    required this.timezone,
  });

  Family copyWith({String? familyName, String? timezone}) => Family(
    familyId: familyId,
    familyName: familyName ?? this.familyName,
    createdAt: createdAt,
    timezone: timezone ?? this.timezone,
  );

  factory Family.fromJson(Map<String, dynamic> json) => Family(
    familyId: json['family_id'],
    familyName: json['family_name'],
    createdAt: DateTime.parse(json['created_at']),
    timezone: json['timezone'],
  );

  Map<String, dynamic> toJson() => {
    'family_id': familyId,
    'family_name': familyName,
    'created_at': createdAt.toIso8601String(),
    'timezone': timezone,
  };
}