import '../enums.dart';

class Wallet {
  final String walletId;
  final String childId;
  final WalletType walletType;
  final double balance;
  final double interestRate;
  final DateTime? lastInterestAt;

  Wallet({
    required this.walletId, required this.childId, required this.walletType,
    required this.balance, required this.interestRate, this.lastInterestAt,
  });

    Wallet copyWith({String? walletId, String? childId, WalletType? walletType, double? balance, double? interestRate, DateTime? lastInterestAt}) => Wallet(
      walletId: walletId ?? this.walletId,
      childId: childId ?? this.childId,
      walletType: walletType ?? this.walletType,
      balance: balance ?? this.balance,
      interestRate: interestRate ?? this.interestRate,
      lastInterestAt: lastInterestAt ?? this.lastInterestAt,
    );

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    walletId: json['wallet_id'], childId: json['child_id'],
    walletType: WalletType.values.byName(json['wallet_type']),
    balance: json['balance'].toDouble(),
    interestRate: json['interest_rate'].toDouble(),
    lastInterestAt: json['last_interest_at'] != null ? DateTime.parse(json['last_interest_at']) : null,
  );

}
