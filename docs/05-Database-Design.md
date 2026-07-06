# Database Design Document

## Version

1.0

---

# Purpose

This document defines the logical and physical database design for the Mobile Vehicle Wash Marketplace Platform.

It specifies:

- Tables
- Columns
- Relationships
- Constraints
- Indexes
- Naming conventions
- Data types
- Audit fields
- Soft delete strategy
- Referential integrity rules

The database shall serve as the single source of truth for all persistent business data.

---

# Table of Contents

1. Database Principles
2. Naming Conventions
3. Common Columns
4. UUID Strategy
5. Audit Strategy
6. Customer Module
7. Washer Module
8. Booking Module
9. Assignment Module
10. Pricing Module
11. Payment Module
12. Refund Module
13. Payout Module
14. Dispute Module
15. Notification Module
16. Audit Module

---

# 1. Database Principles

The platform uses PostgreSQL as the primary relational database.

The design follows these principles:

- ACID compliance
- Third Normal Form (3NF)
- Strong referential integrity
- UUID primary keys
- Optimistic locking
- Immutable financial records
- Soft delete where appropriate

Business logic shall remain in the application layer.

Database triggers shall be avoided except where absolutely necessary.

---

# 2. Naming Conventions

## Tables

Plural snake_case.

Examples:

```
customers

washers

bookings

payments

refunds
```

---

## Columns

Snake case.

Examples

```
customer_id

created_at

booking_status

slot_start_time
```

---

## Primary Keys

Every table:

```
id UUID PRIMARY KEY
```

---

## Foreign Keys

Use entity name.

Examples

```
customer_id

booking_id

washer_id

payment_id
```

---

## Boolean Columns

Prefix with:

```
is_

has_
```

Examples

```
is_active

is_deleted

has_dispute
```

---

# 3. Common Columns

Nearly every table shall contain:

| Column | Type |
|---------|------|
| id | UUID |
| created_at | TIMESTAMP |
| updated_at | TIMESTAMP |
| created_by | UUID (nullable) |
| updated_by | UUID (nullable) |
| version | INTEGER |

Business tables supporting soft deletion shall additionally include:

```
is_deleted

deleted_at

deleted_by
```

---

# 4. UUID Strategy

UUID Version 7 is recommended when available for improved index locality.

If unavailable, UUID Version 4 is acceptable.

UUID generation shall occur in the backend.

---

# 5. Audit Strategy

Financial tables shall never support deletion.

Historical state shall always be preserved.

Every significant business action shall create corresponding audit records.

---

# 6. Customer Module

---

## customers

Stores registered customer accounts.

| Column | Type | Constraints |
|---------|------|-------------|
| id | UUID | PK |
| mobile_number | VARCHAR(15) | UNIQUE NOT NULL |
| full_name | VARCHAR(150) | NULL |
| email | VARCHAR(255) | NULL |
| is_active | BOOLEAN | DEFAULT TRUE |
| reliability_score | DECIMAL(5,2) | DEFAULT 100.00 |
| last_login_at | TIMESTAMP | NULL |
| created_at | TIMESTAMP | NOT NULL |
| updated_at | TIMESTAMP | NOT NULL |
| version | INTEGER | NOT NULL |

### Indexes

- mobile_number
- is_active

---

## vehicles

A customer may register multiple vehicles.

| Column | Type |
|---------|------|
| id | UUID |
| customer_id | UUID FK |
| vehicle_type | ENUM |
| vehicle_number | VARCHAR(20) |
| vehicle_brand | VARCHAR(100) |
| vehicle_model | VARCHAR(100) |
| vehicle_color | VARCHAR(50) |
| is_default | BOOLEAN |
| created_at | TIMESTAMP |
| updated_at | TIMESTAMP |
| version | INTEGER |

### Constraints

Vehicle number should be unique per customer.

### Indexes

- customer_id
- vehicle_number

---

## addresses

Stores customer service addresses.

| Column | Type |
|---------|------|
| id | UUID |
| customer_id | UUID FK |
| address_label | VARCHAR(100) |
| full_address | TEXT |
| latitude | DECIMAL(10,7) |
| longitude | DECIMAL(10,7) |
| is_default | BOOLEAN |
| created_at | TIMESTAMP |
| updated_at | TIMESTAMP |

### Indexes

- customer_id
- latitude
- longitude

---

# Relationships

Customer

↓

Vehicles

(1:N)

Customer

↓

Addresses

(1:N)

---

# 7. Washer Module

---

## washers

Stores washer profiles.

| Column | Type |
|---------|------|
| id | UUID |
| mobile_number | VARCHAR(15) |
| full_name | VARCHAR(150) |
| home_address | TEXT |
| home_latitude | DECIMAL(10,7) |
| home_longitude | DECIMAL(10,7) |
| verification_status | ENUM |
| trust_score | DECIMAL(5,2) |
| average_rating | DECIMAL(3,2) |
| total_completed_jobs | INTEGER |
| weekly_capacity_override | INTEGER NULL |
| is_active | BOOLEAN |
| created_at | TIMESTAMP |
| updated_at | TIMESTAMP |
| version | INTEGER |

### Indexes

- verification_status
- is_active
- home_latitude
- home_longitude

---

## washer_documents

Stores verification documents.

| Column | Type |
|---------|------|
| id | UUID |
| washer_id | UUID FK |
| document_type | ENUM |
| storage_key | VARCHAR(500) |
| verification_status | ENUM |
| rejection_reason | TEXT |
| verified_by | UUID |
| verified_at | TIMESTAMP |

---

## washer_availability

Stores future slot availability.

| Column | Type |
|---------|------|
| id | UUID |
| washer_id | UUID FK |
| slot_date | DATE |
| slot_id | UUID FK |
| is_available | BOOLEAN |

Unique Constraint:

```
washer_id

slot_date

slot_id
```

---

## service_areas

Defines geographical service regions.

| Column | Type |
|---------|------|
| id | UUID |
| name | VARCHAR(100) |
| polygon_geojson | JSONB |
| is_active | BOOLEAN |

---

## washer_service_areas

Links washers to supported service areas.

| Column | Type |
|---------|------|
| id | UUID |
| washer_id | UUID FK |
| service_area_id | UUID FK |

---

# Relationships

Washer

↓

Documents

(1:N)

Washer

↓

Availability

(1:N)

Washer

↓

Service Areas

(N:M)

---

# 8. Booking Module

The Booking Module represents the complete lifecycle of a vehicle wash request.

It manages:

- Booking creation
- Slot selection
- Assignment
- Status transitions
- Completion
- Cancellation
- Disputes
- Historical tracking

The booking itself is immutable except for controlled state transitions.

---

# booking_slots

Defines the platform-controlled booking slots.

Slots are managed by administrators and shared across all washers.

Example:

08:00 - 10:00

10:00 - 12:00

12:00 - 02:00

etc.

## Columns

| Column | Type | Constraints |
|---------|------|-------------|
| id | UUID | PK |
| slot_name | VARCHAR(100) | NOT NULL |
| start_time | TIME | NOT NULL |
| end_time | TIME | NOT NULL |
| display_order | INTEGER | NOT NULL |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | NOT NULL |
| updated_at | TIMESTAMP | NOT NULL |

---

## Constraints

No two active slots may overlap.

Slots should completely cover the business operating hours.

---

## bookings

Represents one customer booking.

This is the central table of the platform.

---

### Columns

| Column | Type |
|---------|------|
| id | UUID |
| booking_number | VARCHAR(30) UNIQUE |
| customer_id | UUID FK |
| vehicle_id | UUID FK |
| address_id | UUID FK |
| slot_id | UUID FK |
| assigned_washer_id | UUID FK NULL |
| booking_status | ENUM |
| booking_date | DATE |
| scheduled_start_time | TIMESTAMP |
| scheduled_end_time | TIMESTAMP |
| wash_started_at | TIMESTAMP NULL |
| completed_at | TIMESTAMP NULL |
| cancelled_at | TIMESTAMP NULL |
| cancellation_reason | TEXT |
| cancellation_by | ENUM |
| dispute_deadline | TIMESTAMP |
| payment_status | ENUM |
| has_dispute | BOOLEAN |
| version | INTEGER |
| created_at | TIMESTAMP |
| updated_at | TIMESTAMP |

---

### Indexes

booking_number

customer_id

assigned_washer_id

booking_date

booking_status

slot_id

payment_status

---

## Booking Status Enum

The booking lifecycle shall follow the following states.

```
CREATED

PAYMENT_PENDING

CONFIRMED

SEARCHING_WASHER

ASSIGNED

ON_THE_WAY

WASH_STARTED

COMPLETED

DISPUTED

REFUND_PENDING

REFUNDED

CANCELLED

FAILED
```

State transitions shall only occur through backend validation.

---

## booking_status_history

Every status transition shall be permanently recorded.

No status history shall ever be deleted.

---

### Columns

| Column | Type |
|---------|------|
| id | UUID |
| booking_id | UUID FK |
| previous_status | ENUM |
| new_status | ENUM |
| changed_by | UUID |
| change_reason | TEXT |
| changed_at | TIMESTAMP |

---

## Relationships

Booking

↓

Status History

(1:N)

---

# 9. Assignment Module

The Assignment Module determines which washer ultimately fulfills a booking.

The Booking Module owns the booking.

The Assignment Module owns the matching process.

---

## booking_assignments

Stores the currently selected washer.

---

### Columns

| Column | Type |
|---------|------|
| id | UUID |
| booking_id | UUID FK |
| washer_id | UUID FK |
| assignment_status | ENUM |
| assigned_at | TIMESTAMP |
| accepted_at | TIMESTAMP |
| rejected_at | TIMESTAMP NULL |
| cancelled_at | TIMESTAMP NULL |
| cancellation_reason | TEXT |

---

## Assignment Status

```
PENDING

SENT

ACCEPTED

DECLINED

EXPIRED

CANCELLED

COMPLETED
```

---

## assignment_attempts

Every assignment attempt should be recorded.

This allows future analytics.

---

### Columns

| Column | Type |
|---------|------|
| id | UUID |
| booking_id | UUID FK |
| washer_id | UUID FK |
| rank_score | DECIMAL(8,2) |
| response | ENUM |
| response_time_seconds | INTEGER |
| attempted_at | TIMESTAMP |

---

## Why Store Assignment Attempts?

This enables future analysis.

Examples:

- Acceptance rate

- Average response time

- Distance vs acceptance

- Ranking algorithm tuning

- Fraud detection

- AI model training

---

# 10. Pricing Module

The platform controls all pricing.

Washers never determine customer pricing.

---

## pricing_rules

Stores active pricing.

---

### Columns

| Column | Type |
|---------|------|
| id | UUID |
| vehicle_type | ENUM |
| base_price | DECIMAL(10,2) |
| price_per_km | DECIMAL(10,2) |
| minimum_price | DECIMAL(10,2) |
| maximum_price | DECIMAL(10,2) NULL |
| gst_percentage | DECIMAL(5,2) |
| platform_commission_percentage | DECIMAL(5,2) |
| travel_compensation | DECIMAL(10,2) |
| is_active | BOOLEAN |
| effective_from | TIMESTAMP |
| effective_until | TIMESTAMP NULL |

---

## Important Principle

Historical bookings should NEVER recalculate pricing.

Every booking stores its own pricing snapshot.

Changing pricing rules affects only future bookings.

---

## booking_price_breakdown

Stores immutable pricing details for every booking.

---

### Columns

| Column | Type |
|---------|------|
| id | UUID |
| booking_id | UUID FK |
| base_price | DECIMAL(10,2) |
| distance_km | DECIMAL(8,2) |
| distance_charge | DECIMAL(10,2) |
| travel_fee | DECIMAL(10,2) |
| gst_percentage | DECIMAL(5,2) |
| gst_amount | DECIMAL(10,2) |
| platform_fee | DECIMAL(10,2) |
| washer_payout | DECIMAL(10,2) |
| total_customer_price | DECIMAL(10,2) |
| created_at | TIMESTAMP |

---

## Why Keep a Pricing Snapshot?

Suppose:

Today:

Base Price = ₹250

Tomorrow:

Admin changes it to ₹300

A booking made yesterday must still reflect ₹250.

Therefore every booking requires its own immutable pricing snapshot.

---

# Relationships

Booking

↓

Price Breakdown

(1:1)

Pricing Rules

↓

Future Bookings

(No direct FK relationship)

---

# Capacity Rules

The platform shall support an admin-configurable maximum bookings per washer per slot.

Recommended table:

## washer_capacity_rules

| Column | Type |
|---------|------|
| id | UUID |
| washer_id | UUID FK |
| max_bookings_per_slot | INTEGER |
| effective_from | TIMESTAMP |
| effective_until | TIMESTAMP NULL |
| is_active | BOOLEAN |

If no washer-specific rule exists, the system shall use a global default from the Platform Configuration module.

---

# 11. Payment Module

The Payment Module records all customer payment transactions.

The platform receives the payment first.

The washer is paid later through the Weekly Payout process.

No payment information should ever be deleted.

---

# payments

Stores every payment transaction.

## Columns

| Column | Type | Constraints |
|---------|------|-------------|
| id | UUID | PK |
| booking_id | UUID FK UNIQUE |
| customer_id | UUID FK |
| payment_gateway | ENUM |
| gateway_order_id | VARCHAR(150) |
| gateway_payment_id | VARCHAR(150) |
| gateway_signature | VARCHAR(255) |
| payment_status | ENUM |
| amount | DECIMAL(10,2) |
| currency | VARCHAR(10) |
| paid_at | TIMESTAMP NULL |
| failure_reason | TEXT NULL |
| created_at | TIMESTAMP |
| updated_at | TIMESTAMP |
| version | INTEGER |

---

## Payment Status

```
PENDING

AUTHORIZED

CAPTURED

FAILED

REFUNDED

PARTIALLY_REFUNDED
```

---

## Indexes

- booking_id
- customer_id
- payment_status
- gateway_payment_id

---

# payment_events

Stores webhook history received from the payment gateway.

Nothing received from Razorpay should be discarded.

## Columns

| Column | Type |
|---------|------|
| id | UUID |
| payment_id | UUID FK |
| event_name | VARCHAR(100) |
| gateway_event_id | VARCHAR(150) |
| payload | JSONB |
| processed | BOOLEAN |
| received_at | TIMESTAMP |

---

## Why Keep Webhooks?

Examples:

- Debug failed payments
- Duplicate webhook detection
- Gateway reconciliation
- Audit trail

---

# 12. Refund Module

Refunds are immutable financial records.

Every refund creates a new record.

Refunds never modify payment history.

---

# refunds

## Columns

| Column | Type |
|---------|------|
| id | UUID |
| payment_id | UUID FK |
| booking_id | UUID FK |
| refund_amount | DECIMAL(10,2) |
| refund_reason | ENUM |
| initiated_by | ENUM |
| gateway_refund_id | VARCHAR(150) |
| refund_status | ENUM |
| admin_notes | TEXT |
| created_at | TIMESTAMP |
| processed_at | TIMESTAMP NULL |

---

## Refund Reasons

```
CUSTOMER_CANCELLED

WASHER_CANCELLED

NO_WASHER_AVAILABLE

SERVICE_NOT_COMPLETED

BAD_SERVICE

CUSTOMER_NOT_REACHABLE

ADMIN_OVERRIDE

OTHER
```

---

## Refund Status

```
PENDING

PROCESSING

COMPLETED

FAILED
```

---

## Partial Refund Support

The schema supports:

- Full refund
- Partial refund
- Multiple refund records for one payment (if business rules allow in future)

---

# 13. Payout Module

Washers receive weekly payouts.

Payouts are generated only after the dispute window has closed.

---

# payout_batches

Represents a weekly settlement batch.

## Columns

| Column | Type |
|---------|------|
| id | UUID |
| batch_reference | VARCHAR(50) UNIQUE |
| batch_start_date | DATE |
| batch_end_date | DATE |
| total_amount | DECIMAL(12,2) |
| total_jobs | INTEGER |
| payout_status | ENUM |
| generated_at | TIMESTAMP |
| processed_at | TIMESTAMP NULL |

---

## payout_items

One record per eligible completed booking.

## Columns

| Column | Type |
|---------|------|
| id | UUID |
| payout_batch_id | UUID FK |
| washer_id | UUID FK |
| booking_id | UUID FK |
| payout_amount | DECIMAL(10,2) |
| payout_status | ENUM |
| transferred_at | TIMESTAMP NULL |
| transaction_reference | VARCHAR(150) NULL |

---

## Payout Status

```
PENDING

READY

PROCESSING

COMPLETED

FAILED
```

---

## Benefits

This design allows:

- Retry failed payouts
- Weekly reporting
- Reconciliation
- Future bank integrations
- Export to accounting software

---

# Relationships

Payout Batch

↓

Payout Items

(1:N)

Washer

↓

Payout Items

(1:N)

Booking

↓

Payout Item

(1:1)

---

# 14. Dispute Module

Disputes are initiated when the customer or washer reports an issue.

The booking remains immutable.

The dispute tracks the investigation separately.

---

# disputes

## Columns

| Column | Type |
|---------|------|
| id | UUID |
| booking_id | UUID FK UNIQUE |
| dispute_type | ENUM |
| raised_by | ENUM |
| dispute_status | ENUM |
| issue_description | TEXT |
| admin_resolution | TEXT NULL |
| resolution_type | ENUM NULL |
| refund_percentage | DECIMAL(5,2) NULL |
| payout_percentage | DECIMAL(5,2) NULL |
| resolved_by | UUID NULL |
| resolved_at | TIMESTAMP NULL |
| created_at | TIMESTAMP |

---

## Dispute Types

```
BAD_WASH

CUSTOMER_NOT_REACHABLE

VEHICLE_NOT_FOUND

PROPERTY_ACCESS_DENIED

SERVICE_INCOMPLETE

OTHER
```

---

## Dispute Status

```
OPEN

UNDER_REVIEW

WAITING_FOR_EVIDENCE

RESOLVED

REJECTED
```

---

# dispute_evidence

Stores supporting evidence.

## Columns

| Column | Type |
|---------|------|
| id | UUID |
| dispute_id | UUID FK |
| uploaded_by | ENUM |
| media_type | ENUM |
| storage_key | VARCHAR(500) |
| uploaded_at | TIMESTAMP |

Evidence may include:

- Before photos
- After photos
- Location proof
- Call attempt screenshots
- Vehicle-area photos
- Other supporting files

---

# Relationships

Dispute

↓

Evidence

(1:N)

---

# 15. Notification Module

Stores notification history.

---

# notifications

## Columns

| Column | Type |
|---------|------|
| id | UUID |
| recipient_type | ENUM |
| recipient_id | UUID |
| notification_type | ENUM |
| title | VARCHAR(200) |
| body | TEXT |
| delivery_channel | ENUM |
| delivery_status | ENUM |
| is_read | BOOLEAN |
| sent_at | TIMESTAMP |
| read_at | TIMESTAMP NULL |

---

## Delivery Status

```
QUEUED

SENT

DELIVERED

FAILED
```

---

## Notification Types

Examples:

- Booking Confirmed
- Washer On The Way
- Wash Completed
- Refund Completed
- Weekly Payout
- Verification Approved

---

# 16. Audit Module

Every critical action performed by administrators or the system shall be permanently recorded.

Audit logs are immutable.

---

# audit_logs

## Columns

| Column | Type |
|---------|------|
| id | UUID |
| actor_type | ENUM |
| actor_id | UUID NULL |
| entity_type | VARCHAR(100) |
| entity_id | UUID |
| action | VARCHAR(100) |
| previous_value | JSONB NULL |
| new_value | JSONB NULL |
| ip_address | VARCHAR(50) |
| user_agent | TEXT |
| created_at | TIMESTAMP |

---

## Examples of Audited Actions

- Admin approves washer
- Admin rejects washer
- Pricing updated
- Capacity changed
- Refund approved
- Refund rejected
- Dispute resolved
- Washer suspended
- Customer suspended
- Platform configuration changed

---

# 17. Platform Configuration Module

Centralized table for platform business rules and runtime configurations.

---

# platform_configurations

## Columns

| Column | Type | Constraints |
|---------|------|-------------|
| id | UUID | PK |
| config_key | VARCHAR(100) | UNIQUE NOT NULL |
| config_value | VARCHAR(255) | NOT NULL |
| data_type | ENUM | NOT NULL |
| description | TEXT | NULL |
| is_editable | BOOLEAN | DEFAULT TRUE |
| updated_by | UUID | NULL |
| updated_at | TIMESTAMP | NOT NULL |
| version | INTEGER | NOT NULL |

---

## Database Relationship Summary

Customer
├── Vehicles
├── Addresses
├── Bookings

Washer
├── Documents
├── Availability
├── Service Areas
├── Assignment Attempts
├── Payout Items

Booking
├── Status History
├── Assignment
├── Price Breakdown
├── Payment
├── Refund
├── Dispute
├── Notification
├── Audit Log

Dispute
└── Evidence

Payout Batch
└── Payout Items

---

# End of Database Design Document
