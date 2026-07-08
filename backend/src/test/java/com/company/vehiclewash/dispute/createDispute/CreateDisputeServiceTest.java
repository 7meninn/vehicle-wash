package com.company.vehiclewash.dispute.createDispute;

import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.dispute.entity.Dispute;
import com.company.vehiclewash.dispute.enums.DisputeStatus;
import com.company.vehiclewash.dispute.enums.DisputeType;
import com.company.vehiclewash.dispute.repository.DisputeRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;


import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CreateDisputeServiceTest {

    @Mock
    private DisputeRepository disputeRepository;

    @Mock
    private BookingRepository bookingRepository;

    @InjectMocks
    private CreateDisputeService createDisputeService;

    @Test
    public void testCreateDispute_Success() {
        UUID bookingId = UUID.randomUUID();
        Booking booking = new Booking();
        booking.setId(bookingId);
        booking.setBookingStatus(BookingStatus.COMPLETED);
        booking.setHasDispute(false);

        CreateDisputeRequest req = new CreateDisputeRequest();
        req.setType(DisputeType.BAD_WASH);
        req.setDescription("test description");

        when(bookingRepository.findById(bookingId)).thenReturn(Optional.of(booking));

        createDisputeService.createDispute(bookingId, req);

        ArgumentCaptor<Dispute> disputeCaptor = ArgumentCaptor.forClass(Dispute.class);
        verify(disputeRepository).save(disputeCaptor.capture());

        Dispute savedDispute = disputeCaptor.getValue();
        assertEquals(bookingId, savedDispute.getBookingId());
        assertEquals(DisputeType.BAD_WASH, savedDispute.getDisputeType());
        assertEquals(DisputeStatus.OPEN, savedDispute.getDisputeStatus());

        assertEquals(true, booking.getHasDispute());
        assertEquals(BookingStatus.DISPUTED, booking.getBookingStatus());
        verify(bookingRepository).save(booking);
    }
}
