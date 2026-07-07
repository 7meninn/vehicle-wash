import '../../domain/entities/payout.dart';

class PayoutModel extends Payout {
  PayoutModel({
    required super.week,
    required super.amount,
    required super.status,
    super.transactionReference,
  });

  factory PayoutModel.fromJson(Map<String, dynamic> json) {
    return PayoutModel(
      week: json['week'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      transactionReference: json['transactionReference'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'amount': amount,
      'status': status,
      'transactionReference': transactionReference,
    };
  }
}
