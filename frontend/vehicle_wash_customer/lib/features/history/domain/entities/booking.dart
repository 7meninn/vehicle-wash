class Booking {
  final String id;
  final String status;
  final String service;
  final DateTime date;
  final String vehicle;
  final double price;

  Booking({
    required this.id,
    required this.status,
    required this.service,
    required this.date,
    required this.vehicle,
    required this.price,
  });
}
