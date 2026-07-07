class Payout {
  final String week;
  final double amount;
  final String status;
  final String? transactionReference;

  Payout({
    required this.week,
    required this.amount,
    required this.status,
    this.transactionReference,
  });
}
