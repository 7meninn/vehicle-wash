import '../../domain/entities/booking.dart';

class BookingModel extends Booking {
  BookingModel({
    required super.id,
    required super.status,
    required super.service,
    required super.date,
    required super.vehicle,
    required super.price,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      status: json['status'] as String,
      service: json['service'] ?? 'Standard Wash',
      date: DateTime.parse(json['createdAt'] ?? json['date'] ?? DateTime.now().toIso8601String()),
      vehicle: json['vehicleDetails']?['vehicleNumber'] ?? json['vehicle'] ?? 'Unknown Vehicle',
      price: (json['price'] ?? json['totalAmount'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'service': service,
      'date': date.toIso8601String(),
      'vehicle': vehicle,
      'price': price,
    };
  }
}
