import '../enums.dart';

class OverrideRecord {
  final String overrideId;
  final String completionId;
  final String parentId;
  final OverrideType overrideType;
  final int coinDeducted;
  final bool creditFlag;
  final String reason;

  OverrideRecord({
    required this.overrideId, required this.completionId, required this.parentId,
    required this.overrideType, required this.coinDeducted,
    required this.creditFlag, required this.reason,
  });
}