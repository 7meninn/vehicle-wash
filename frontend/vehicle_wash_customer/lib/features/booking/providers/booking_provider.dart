import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingState {
  final String? vehicleId;
  final String? addressId;
  final String? bookingDate;
  final String? slotId;

  BookingState({
    this.vehicleId,
    this.addressId,
    this.bookingDate,
    this.slotId,
  });

  BookingState copyWith({
    String? vehicleId,
    String? addressId,
    String? bookingDate,
    String? slotId,
  }) {
    return BookingState(
      vehicleId: vehicleId ?? this.vehicleId,
      addressId: addressId ?? this.addressId,
      bookingDate: bookingDate ?? this.bookingDate,
      slotId: slotId ?? this.slotId,
    );
  }
}

class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier() : super(BookingState());

  void setVehicleId(String vehicleId) {
    state = state.copyWith(vehicleId: vehicleId);
  }

  void setAddressId(String addressId) {
    state = state.copyWith(addressId: addressId);
  }

  void setTime(String bookingDate, String slotId) {
    state = state.copyWith(bookingDate: bookingDate, slotId: slotId);
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>((ref) {
  return BookingNotifier();
});
