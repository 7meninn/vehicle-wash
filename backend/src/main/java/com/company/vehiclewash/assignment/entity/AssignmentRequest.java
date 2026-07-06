package com.company.vehiclewash.assignment.entity;

import com.company.vehiclewash.assignment.enums.AssignmentResponse;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "assignment_attempts")
public class AssignmentRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "booking_id", nullable = false)
    private UUID bookingId;

    @Column(name = "washer_id", nullable = false)
    private UUID washerId;

    @Column(name = "rank_score", precision = 8, scale = 2)
    private BigDecimal rankScore;

    @Enumerated(EnumType.STRING)
    @Column(name = "response")
    private AssignmentResponse response;

    @Column(name = "response_time_seconds")
    private Integer responseTimeSeconds;

    @Column(name = "attempted_at")
    private Instant attemptedAt = Instant.now();

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public UUID getBookingId() { return bookingId; }
    public void setBookingId(UUID bookingId) { this.bookingId = bookingId; }

    public UUID getWasherId() { return washerId; }
    public void setWasherId(UUID washerId) { this.washerId = washerId; }

    public BigDecimal getRankScore() { return rankScore; }
    public void setRankScore(BigDecimal rankScore) { this.rankScore = rankScore; }

    public AssignmentResponse getResponse() { return response; }
    public void setResponse(AssignmentResponse response) { this.response = response; }

    public Integer getResponseTimeSeconds() { return responseTimeSeconds; }
    public void setResponseTimeSeconds(Integer responseTimeSeconds) { this.responseTimeSeconds = responseTimeSeconds; }

    public Instant getAttemptedAt() { return attemptedAt; }
    public void setAttemptedAt(Instant attemptedAt) { this.attemptedAt = attemptedAt; }
}
