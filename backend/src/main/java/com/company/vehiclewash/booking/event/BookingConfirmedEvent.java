package com.company.vehiclewash.booking.event;

import java.util.UUID;

public class BookingConfirmedEvent {
    private final UUID bookingId;

    public BookingConfirmedEvent(UUID bookingId) {
        this.bookingId = bookingId;
    }

    public UUID getBookingId() {
        return bookingId;
    }
}
