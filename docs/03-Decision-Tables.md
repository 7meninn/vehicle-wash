# Decision Tables

## Version

1.0

---

# Purpose

This document centralizes all business decision rules for the Mobile Vehicle Wash Marketplace Platform.

While the BRD explains business objectives and the SRS specifies system requirements, this document defines exactly how the system shall behave under different scenarios.

Whenever a business rule changes, this document shall be updated before implementation.

---

# Table of Contents

1. Booking Acceptance
2. Customer Cancellation
3. Washer Cancellation
4. Booking Completion
5. Refund Rules
6. Travel Compensation
7. Washer Capacity
8. Booking Assignment
9. Payment Decisions
10. Dispute Decisions
11. Customer Not Reachable
12. Washer Verification
13. Weekly Payout
14. Notification Triggers
15. Administrative Overrides

---

# DT-001 Booking Acceptance

| Situation | Booking Assigned | Customer Notified | Other Washers Notified |
|-----------|-----------------|-------------------|------------------------|
| First eligible washer accepts | Yes | Yes | Booking removed |
| Second washer accepts after assignment | No | No | Already assigned |
| Washer exceeds capacity | No | No | No change |
| Washer suspended | No | No | No change |
| Washer outside service area | No | No | No change |
| Booking already cancelled | No | No | No change |
| Booking already completed | No | No | No change |

---

# DT-002 Customer Cancellation

| Situation | Refund | Washer Paid | Travel Fee | Booking Status | Admin Review |
|-----------|--------|-------------|------------|----------------|--------------|
| Before slot begins | Full | No | No | Cancelled | No |
| Slot started, washer not accepted | Full | No | No | Cancelled | No |
| Washer accepted, not On The Way | Full | No | No | Cancelled | No |
| Washer On The Way | Full minus travel fee | Travel fee only | Yes | Cancelled | No |
| Wash Started | No | Yes | N/A | Continue | No |
| Booking Completed | No | Yes | N/A | Completed | No |
| Active Dispute | Pending decision | Pending | Pending | Dispute | Yes |

---

# DT-003 Washer Cancellation

| Situation | Customer Refund | Washer Penalty | Reassignment | Admin Review |
|-----------|----------------|----------------|--------------|--------------|
| Before acceptance | N/A | None | N/A | No |
| After acceptance | Full | Cancellation recorded | Yes | No |
| Replacement accepts | None | Cancellation recorded | Yes | No |
| No replacement by slot end | Full | Cancellation recorded | No | No |
| Repeated cancellations | Depends | Temporary suspension | N/A | Optional |
| Wash Started | Not Allowed | N/A | N/A | Yes |

---

# DT-004 Booking Completion

| Situation | Booking Status | Customer Notification | Payout Eligible |
|-----------|----------------|----------------------|-----------------|
| Wash Started | In Progress | No | No |
| Evidence uploaded | In Progress | No | No |
| Completed | Completed | Yes | Pending dispute window |
| Dispute window expired | Closed | No | Yes |
| Dispute raised | Dispute | Yes | No |

---

# DT-005 Completion Evidence

| Requirement | Mandatory |
|------------|-----------|
| Before Photo | Yes |
| After Photo | Yes |
| GPS Location | Yes |
| Timestamp | Yes |
| Vehicle Photo | Optional |

Booking cannot be marked complete until all mandatory evidence has been uploaded.

---

# DT-006 Refund Rules

| Scenario | Refund Amount |
|----------|---------------|
| Customer cancels before slot | 100% |
| Customer cancels after washer accepted | 100% |
| Customer cancels after On The Way | 100% minus travel compensation |
| Customer cancels after Wash Started | 0% |
| Platform unable to assign washer | 100% |
| Washer cancels and no replacement found | 100% |
| Admin approves partial refund | Configurable |
| Admin approves full refund | 100% |

---

# DT-007 Travel Compensation

| Situation | Compensation |
|-----------|--------------|
| Washer not travelling | No |
| Accepted only | No |
| On The Way | Yes |
| Wash Started | Included in payout |
| Customer cancelled after On The Way | Travel fee deducted from refund |
| Admin override | Configurable |

Travel compensation amount shall be configurable by administrators.

---

# DT-008 Washer Capacity

| Situation | Booking Allowed |
|-----------|----------------|
| Capacity available | Yes |
| Capacity reached | No |
| Capacity changed by admin | Future bookings only |
| Washer suspended | No |
| Washer unavailable for slot | No |

The maximum booking capacity per slot is configured individually for each washer by an administrator.

---

# DT-009 Booking Assignment

| Situation | Assignment Result | Customer Impact | Washer Impact | Admin Review |
|-----------|------------------|-----------------|---------------|--------------|
| First eligible washer accepts | Booking assigned immediately | Booking confirmed | Booking added to active jobs | No |
| Multiple washers accept simultaneously | First successful backend transaction wins | No impact | Remaining washers receive "Booking Already Assigned" | No |
| No washer accepts before slot ends | Booking cancelled | Full refund | None | No |
| Washer cancels after accepting | Booking rebroadcast to eligible washers | No immediate impact | Cancellation recorded | No |
| Replacement washer accepts | Booking reassigned | No visible change to customer | Previous washer penalized | No |
| No replacement accepts before slot ends | Booking cancelled | Full refund | Previous washer penalized | No |
| Washer reaches configured slot capacity | Cannot receive additional bookings | No impact | Capacity limit enforced | No |
| Admin manually reassigns booking | Booking transferred | No visible operational details shown | New washer assigned | Yes |

---

# DT-010 Payment Decisions

| Situation | Booking Created | Customer Charged | Refund Required | Admin Review |
|-----------|----------------|-----------------|----------------|--------------|
| Payment successful | Yes | Yes | No | No |
| Payment failed | No | No | No | No |
| Payment verification failed | No | Pending gateway reconciliation | If captured incorrectly | Yes |
| Customer closes payment page | No | No | No | No |
| Gateway timeout | Wait for gateway callback | Pending | Depends on final payment status | Optional |
| Duplicate payment callback | No duplicate booking | No duplicate charge | No | No |
| Payment succeeded but booking creation failed | No | Yes | Automatic full refund (or retry booking creation if technically safe) | Yes |

---

# DT-011 Customer Not Reachable / Vehicle Not Found

| Situation | Immediate Action | Booking Status | Payout | Refund | Admin Review |
|-----------|-----------------|----------------|--------|--------|--------------|
| Customer unreachable | Washer uploads required proof | Dispute | Pending | Pending | Yes |
| Vehicle not found | Washer uploads required proof | Dispute | Pending | Pending | Yes |
| Wrong parking location provided | Evidence required | Dispute | Pending | Pending | Yes |
| Customer answers after washer leaves | Admin decision | Dispute | Pending | Pending | Yes |
| Evidence insufficient | Admin may reject washer claim | Dispute | Pending | Pending | Yes |

### Required Washer Evidence

Before a "Customer Not Reachable" or "Vehicle Not Found" claim is accepted, the washer shall provide:

- Current GPS location
- Timestamp
- Photo of the parking area (without violating privacy)
- Proof of at least one in-app call attempt (or platform-recorded call log)
- Optional additional notes

Without the required evidence, the claim should not be considered valid.

---

# DT-012 Dispute Resolution Matrix

| Customer Claim | Washer Evidence | Suggested Resolution |
|---------------|----------------|----------------------|
| Poor wash quality | Strong completion evidence | Admin review, possible partial refund |
| Vehicle not washed | No completion evidence | Full refund |
| Wrong vehicle washed | Verified | Full refund + warning |
| Minor quality issue | Evidence supports service completion | Partial refund (admin configurable) |
| Major property damage | Verified | Escalate for manual investigation |
| Fake customer dispute | Strong washer evidence | Reject dispute |
| Fake washer completion | Weak or inconsistent evidence | Refund customer, penalize washer |
| Customer unreachable claim | Valid proof | Admin decides compensation split |
| Insufficient evidence from both parties | Inconclusive | Manual administrative decision |

---

# DT-013 Weekly Payout Eligibility

| Booking Status | Eligible for Payout |
|---------------|---------------------|
| Awaiting Acceptance | No |
| Accepted | No |
| On The Way | No |
| Wash Started | No |
| Completed (Dispute Window Active) | No |
| Dispute | No |
| Closed | Yes |
| Cancelled | No |

### Additional Conditions

A booking becomes eligible only when:

- Wash successfully completed.
- Mandatory evidence uploaded.
- Dispute window expires.
- No active dispute exists.
- Administrative hold does not exist.

---

# DT-014 Notification Triggers

| Event | Customer | Washer | Admin |
|------|----------|--------|-------|
| Booking Created | Yes | Eligible washers | No |
| Booking Accepted | Yes | Assigned washer | No |
| Washer On The Way | Yes | No | No |
| Wash Started | Optional | No | No |
| Booking Completed | Yes | Yes | No |
| Dispute Raised | Yes | Yes | Yes |
| Refund Approved | Yes | If payout affected | Yes |
| Weekly Payout Generated | No | Yes | Yes |
| Weekly Payout Completed | No | Yes | Yes |
| Washer Approved | No | Yes | No |
| Washer Suspended | No | Yes | Yes |
| Customer Suspended | Yes | No | Yes |
| Platform Announcement | Yes | Yes | Optional |

Notification channels may include:

- Push Notification
- SMS (future)
- Email (future)
- In-app notification

---

# DT-015 Administrative Overrides

| Situation | Allowed | Audit Required | Reason Required |
|-----------|---------|----------------|-----------------|
| Force booking cancellation | Yes | Yes | Yes |
| Manual full refund | Yes | Yes | Yes |
| Manual partial refund | Yes | Yes | Yes |
| Manual payout adjustment | Yes | Yes | Yes |
| Approve exceptional payout | Yes | Yes | Yes |
| Restore suspended account | Yes | Yes | Yes |
| Suspend customer | Yes | Yes | Yes |
| Suspend washer | Yes | Yes | Yes |
| Modify booking capacity | Yes | Yes | No |
| Update pricing configuration | Yes | Yes | No |

Administrative overrides are exceptional actions and should only be used when standard automated workflows cannot resolve the situation.

---

# Global Decision Principles

The following principles apply across all decision tables:

- The backend is the single source of truth for all business decisions.
- Customer-facing applications shall expose only necessary information and abstract internal operational details.
- Every financial decision shall be traceable through audit logs.
- Every state transition shall comply with the Booking State Machine defined in the SRS.
- Administrative overrides shall always be logged.
- Future business rule changes shall be reflected in this document before implementation.

---

# End of Decision Tables
