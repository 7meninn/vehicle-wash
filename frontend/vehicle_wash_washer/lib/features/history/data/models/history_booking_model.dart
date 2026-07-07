import '../../domain/entities/history_booking.dart';

class HistoryBookingModel extends HistoryBooking {
  HistoryBookingModel({
    required super.bookingId,
    required super.status,
    required super.slot,
    required super.bookingDate,
  });

  factory HistoryBookingModel.fromJson(Map<String, dynamic> json) {
    return HistoryBookingModel(
      bookingId: json['bookingId'] as String,
      status: json['status'] as String,
      slot: json['slot'] as String,
      bookingDate: json['bookingDate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'status': status,
      'slot': slot,
      'bookingDate': bookingDate,
    };
  }
}
