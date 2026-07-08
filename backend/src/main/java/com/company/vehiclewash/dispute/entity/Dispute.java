package com.company.vehiclewash.dispute.entity;

import com.company.vehiclewash.dispute.enums.DisputeStatus;
import com.company.vehiclewash.dispute.enums.DisputeType;
import com.company.vehiclewash.dispute.enums.RaisedBy;
import com.company.vehiclewash.dispute.enums.ResolutionType;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "disputes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Dispute {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false, unique = true)
    private UUID bookingId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DisputeType disputeType;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private RaisedBy raisedBy;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DisputeStatus disputeStatus;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String issueDescription;

    @Column(columnDefinition = "TEXT")
    private String adminResolution;

    @Enumerated(EnumType.STRING)
    private ResolutionType resolutionType;

    @Column(precision = 5, scale = 2)
    private BigDecimal refundPercentage;

    @Column(precision = 5, scale = 2)
    private BigDecimal payoutPercentage;

    private UUID resolvedBy;

    private LocalDateTime resolvedAt;

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "dispute", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<DisputeEvidence> evidenceList = new ArrayList<>();
    
    public void addEvidence(DisputeEvidence evidence) {
        evidenceList.add(evidence);
        evidence.setDispute(this);
    }
}
