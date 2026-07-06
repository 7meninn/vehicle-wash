# Software Requirements Specification (SRS)

# Mobile Vehicle Wash Marketplace Platform

**Document Version:** 1.0

**Status:** Draft

**Related Documents:**

- Business Requirements Document (BRD)
- System Architecture Document
- Database Design Document
- REST API Specification
- Security Specification

---

# 1. Introduction

## 1.1 Purpose

This Software Requirements Specification (SRS) defines the complete software requirements for the Mobile Vehicle Wash Marketplace Platform.

The purpose of this document is to provide software engineers, architects, UI designers, QA engineers, DevOps engineers, and future contributors with a complete understanding of the software system that must be developed.

Unlike the Business Requirements Document (BRD), which focuses on business objectives and operational policies, this document specifies the software behaviour, functional requirements, non-functional requirements, validation rules, constraints, interfaces, and acceptance criteria.

This document serves as the primary technical requirements reference for software development.

---

## 1.2 Scope

The platform consists of three primary software applications:

- Customer Mobile Application
- Washer Mobile Application
- Administrative Web Portal

These applications communicate with a centralized backend responsible for authentication, booking management, payment processing, notifications, dispute handling, pricing, reporting, and administrative operations.

The software shall support:

- User authentication
- Vehicle management
- Address management
- Washer onboarding
- KYC verification
- Booking lifecycle management
- Payment processing
- Refund processing
- Weekly payouts
- Ratings and reviews
- Notifications
- Dispute handling
- Administrative configuration
- Reporting and analytics

The software shall be designed to support future expansion without requiring major architectural changes.

---

# 2. Intended Audience

This document is intended for:

- Product Managers
- Software Architects
- Backend Developers
- Mobile Developers
- Frontend Developers
- QA Engineers
- DevOps Engineers
- Project Managers
- Technical Leads

---

# 3. Definitions

| Term | Description |
|------|-------------|
| Customer | Individual booking vehicle washing services |
| Washer | Verified service provider performing washes |
| Booking | Scheduled vehicle washing request |
| Slot | Platform-defined service time window |
| Service Area | Geographic region served by a washer |
| Dispute | Customer complaint raised after completion |
| KYC | Know Your Customer verification process |
| Admin | Platform administrator |
| Capacity | Maximum bookings allowed for a washer during a slot |

---

# 4. Product Perspective

The Mobile Vehicle Wash Marketplace Platform is a marketplace system connecting customers requiring vehicle washing services with independently verified washers.

The platform manages the complete operational lifecycle from customer registration through booking completion, dispute resolution, and weekly washer payouts.

The system consists of independent software applications communicating through centralized backend services.

The software shall be modular to enable future scalability.

---

# 5. Product Goals

The software shall:

- Provide reliable booking management.
- Ensure secure payment processing.
- Minimize manual administrative work.
- Support configurable business policies.
- Scale to multiple cities.
- Maintain high system availability.
- Protect user data.
- Maintain operational transparency.
- Prevent fraud.
- Support future business expansion.

---

# 6. System Components

The platform consists of the following software components.

## Customer Mobile Application

Responsibilities include:

- Registration
- Authentication
- Vehicle Management
- Address Management
- Booking
- Payment
- Booking History
- Notifications
- Ratings
- Disputes
- Profile Management

---

## Washer Mobile Application

Responsibilities include:

- Registration
- KYC Submission
- Availability Management
- Service Area Configuration
- Booking Acceptance
- Navigation Assistance
- Wash Progress Updates
- Completion Evidence Upload
- Earnings
- Payout History
- Profile Management

---

## Administrative Portal

Responsibilities include:

- Dashboard
- Customer Management
- Washer Management
- Booking Management
- Pricing Configuration
- Capacity Management
- Refund Processing
- Dispute Resolution
- Weekly Payouts
- Analytics
- Business Configuration

---

## Backend Services

The backend is responsible for:

- Authentication
- Authorization
- Booking Engine
- Pricing Engine
- Payment Processing
- Notification Service
- File Storage
- KYC Management
- Reporting
- Administrative Operations
- Audit Logging

---

# 7. General Design Principles

The software shall follow the following principles:

## Modular Design

Business logic shall remain independent from presentation layers.

---

## Configurable Behaviour

Business policies should be configurable wherever practical.

Examples include:

- Pricing
- Capacity
- Time Slots
- Refund Percentages
- Travel Compensation
- Dispute Duration

---

## Security First

Sensitive operations shall require authentication and authorization.

User data shall be protected according to industry best practices.

---

## Scalability

The system shall support horizontal growth without requiring significant redesign.

---

## Maintainability

The codebase shall encourage modularity, readability, automated testing, and ease of maintenance.

---

## Reliability

The software shall prioritize data consistency over processing speed.

Financial operations must remain reliable under all supported operating conditions.

---

## Auditability

Critical operations shall be recorded for future investigation.

Examples include:

- Refunds
- Payouts
- Administrative Overrides
- Pricing Changes
- Capacity Changes
- Booking Status Changes

---

# 8. Assumptions

The following assumptions apply throughout the software.

- Users possess internet connectivity.
- Mobile devices support GPS.
- Push notification services are available.
- Online payment gateway is operational.
- Platform administrators are available for manual dispute resolution.
- Washers possess smartphones capable of capturing photographs.
- System time shall be synchronized using server time.

---

# 9. Constraints

The MVP shall operate under the following constraints.

- Online payment only.
- Two vehicle categories.
- Weekly payouts.
- Platform-controlled pricing.
- Manual washer approval.
- Manual dispute resolution.
- Silent completion workflow.
- Photograph-based service verification.
- Single-country deployment.

---

# 10. Software Quality Objectives

The software shall prioritize:

- Reliability
- Security
- Availability
- Scalability
- Performance
- Maintainability
- Configurability
- Observability
- Testability
- Simplicity

These objectives shall influence every architectural and implementation decision throughout the platform.

---

# 11. Functional Requirements

This chapter defines the functional behaviour expected from every software component of the platform.

Each functional requirement is uniquely identified for traceability.

Requirement priorities are defined as:

- **Critical** – Required for MVP launch.
- **High** – Required but may be implemented after core modules.
- **Medium** – Improves usability.
- **Low** – Future enhancement.

---

# Module 1 — Authentication & Account Management

---

# FR-001 Customer Registration

## Priority

Critical

## Actors

- Customer

## Description

The system shall allow a new customer to create an account using mobile number verification.

---

## Preconditions

- Customer is not logged in.
- Mobile number is not already registered.

---

## Trigger

Customer selects **Create Account**.

---

## Main Flow

1. Customer enters mobile number.
2. System validates the number format.
3. System sends an OTP.
4. Customer enters the OTP.
5. System verifies the OTP.
6. Customer enters profile information.
7. System creates the account.
8. Customer is logged in.
9. Home screen is displayed.

---

## Alternative Flows

### OTP Expired

Customer requests another OTP.

---

### OTP Incorrect

Customer re-enters OTP.

---

## Exceptions

- Invalid phone number
- Duplicate account
- OTP delivery failure
- Server unavailable

---

## Business Rules

- One account per mobile number.
- Mobile verification is mandatory.
- Registration timestamp shall be stored.
- New accounts are active immediately.

---

## Validation Rules

Mobile Number

- Required
- Indian mobile number
- Unique

Name

- Required
- Minimum 2 characters
- Maximum 100 characters

---

## Post Conditions

Customer account exists.

---

## Acceptance Criteria

- Valid user can register.
- Duplicate registration is rejected.
- Invalid OTP is rejected.
- Successful registration logs the customer in automatically.

---

# FR-002 Customer Login

## Priority

Critical

## Actors

Customer

---

## Description

Registered customers shall authenticate using OTP-based login.

---

## Preconditions

Customer account exists.

---

## Main Flow

1. Customer enters mobile number.
2. OTP is generated.
3. OTP is verified.
4. Authentication token is issued.
5. Customer accesses the application.

---

## Business Rules

- Passwords are not used.
- OTP expires after configurable duration.
- Login attempts may be rate limited.

---

## Exceptions

- Invalid OTP
- Expired OTP
- Suspended account
- Deleted account

---

## Acceptance Criteria

Only verified customers receive authenticated sessions.

---

# FR-003 Customer Logout

## Priority

Critical

---

## Description

The customer shall be able to securely terminate the current authenticated session.

---

## Main Flow

1. Customer taps Logout.
2. Session token is invalidated.
3. Customer returns to Login screen.

---

## Post Conditions

Authenticated APIs become inaccessible until login.

---

# FR-004 Edit Customer Profile

## Priority

High

---

## Description

Customers shall be able to update their profile information.

---

## Editable Fields

- Name
- Email
- Profile Picture

Mobile number modification is outside MVP scope.

---

## Business Rules

Profile changes take effect immediately.

---

# FR-005 Vehicle Management

## Priority

Critical

---

## Description

Customers shall be able to manage multiple vehicles.

---

## Functions

- Add Vehicle
- Edit Vehicle
- Delete Vehicle
- View Vehicles

---

## Vehicle Fields

- Vehicle Number
- Vehicle Type
- Nickname (optional)

---

## Validation

Vehicle Number

- Required
- Unique within customer account

Vehicle Type

- Two Wheeler
- Four Wheeler

---

## Business Rules

Vehicles linked to active bookings cannot be deleted.

---

## Acceptance Criteria

Customer can maintain multiple vehicles.

---

# FR-006 Address Management

## Priority

Critical

---

## Description

Customers shall manage multiple service addresses.

---

## Functions

- Add Address
- Edit Address
- Delete Address
- Set Default Address

---

## Address Fields

- Label
- Full Address
- Landmark
- Latitude
- Longitude
- Additional Notes

---

## Business Rules

Addresses associated with active bookings cannot be deleted.

---

## Acceptance Criteria

Customer can select any saved address during booking.

---

# FR-007 Washer Registration

## Priority

Critical

---

## Actors

Washer

---

## Description

The system shall allow service providers to register for approval.

---

## Registration Flow

1. Mobile verification.
2. Profile details.
3. Identity upload.
4. Selfie upload.
5. Home base selection.
6. Service area selection.
7. Availability setup.
8. Submit application.

---

## Post Conditions

Application status becomes **Pending Approval**.

---

## Acceptance Criteria

No washer can receive bookings before approval.

---

# FR-008 Washer Login

## Priority

Critical

---

## Description

Approved washers authenticate using OTP.

---

## Exceptions

- Pending Approval
- Rejected
- Suspended
- Inactive

---

## Acceptance Criteria

Only approved washers receive authenticated sessions.

---

# FR-009 Washer Profile Management

## Priority

High

---

## Editable Fields

- Name
- Profile Picture
- Home Base
- Service Area
- Availability

Identity verification documents require administrative approval before modification becomes effective.

---

# FR-010 Admin Authentication

## Priority

Critical

---

## Description

Administrators authenticate using secure credentials.

Future enhancements may include Multi-Factor Authentication (MFA).

---

## Business Rules

Administrative sessions shall have configurable timeout durations.

Every administrative login shall be recorded in audit logs.

---

# FR-011 Session Management

## Priority

Critical

---

## Description

The system shall securely manage authenticated sessions for all users.

---

## Functional Behaviour

The system shall:

- Issue secure authentication tokens.
- Expire inactive sessions.
- Invalidate sessions on logout.
- Reject expired tokens.
- Prevent unauthorized API access.

---

## Acceptance Criteria

Authenticated endpoints shall reject unauthenticated requests.

---

# FR-012 Role-Based Access Control (RBAC)

## Priority

Critical

---

## Description

Every authenticated request shall be authorized according to the user's role.

---

## Roles

- Customer
- Washer
- Administrator

---

## Business Rules

Customers cannot access washer resources.

Washers cannot access administrative functions.

Administrators possess elevated privileges according to configured permissions.

Unauthorized requests shall return an authorization error.

---

# Module 2 — Booking Management

The Booking Management module governs the complete lifecycle of a booking, from creation to final closure.

This module is the operational heart of the platform and coordinates customer requests, washer assignment, booking progress, cancellations, disputes, refunds, and completion.

---

# FR-013 Create Booking

## Priority

Critical

## Actors

- Customer

---

## Description

The system shall allow customers to create a vehicle wash booking.

---

## Preconditions

- Customer is authenticated.
- Customer account is active.
- At least one vehicle exists.
- At least one service address exists.
- Selected location is serviceable.
- Selected slot is available.

---

## Main Flow

1. Customer selects one or more vehicles.
2. Customer selects a service location.
3. Customer selects booking date.
4. Customer selects an available slot.
5. System calculates the booking price.
6. Customer reviews booking summary.
7. Customer proceeds to payment.

---

## Alternative Flows

Customer changes:

- Vehicle
- Address
- Date
- Slot

The system recalculates pricing immediately.

---

## Exceptions

- Invalid slot
- Service unavailable
- No eligible washers
- Invalid location

---

## Business Rules

Booking is not created until payment succeeds.

---

## Acceptance Criteria

Customer reaches payment only after all booking information is valid.

---

# FR-014 Price Calculation

## Priority

Critical

---

## Description

The system shall calculate the final booking amount before payment.

---

## Inputs

- Vehicle category
- Number of vehicles
- Distance
- Platform pricing rules
- Taxes

---

## Business Rules

- Pricing is platform controlled.
- Washers cannot modify pricing.
- Pricing rules are configurable.

---

## Acceptance Criteria

Displayed price matches platform pricing configuration.

---

# FR-015 Slot Availability

## Priority

Critical

---

## Description

The system shall display only available booking slots.

---

## Functional Behaviour

The system evaluates:

- Date
- Area
- Washer availability
- Washer capacity

Unavailable slots shall not be selectable.

---

## Business Rules

Slots are controlled by administrators.

---

## Acceptance Criteria

Unavailable slots cannot be booked.

---

# FR-016 Payment Before Booking

## Priority

Critical

---

## Description

Payment shall be completed before booking creation.

---

## Main Flow

1. Customer selects payment method.
2. Payment gateway processes payment.
3. Payment succeeds.
4. Booking is created.
5. Confirmation notification sent.

---

## Exceptions

- Payment failed
- Payment timeout
- Gateway unavailable

---

## Business Rules

No successful payment means no booking.

---

# FR-017 Booking Creation

## Priority

Critical

---

## Description

After successful payment, the booking record shall be created.

---

## System Behaviour

The booking shall receive:

- Unique Booking ID
- Initial Status
- Timestamp
- Price
- Customer reference
- Vehicle reference
- Address reference

---

## Initial Status

Awaiting Acceptance

---

# FR-018 Eligible Washer Discovery

## Priority

Critical

---

## Description

The system shall determine which washers are eligible to receive the booking request.

---

## Eligibility Rules

A washer is eligible only if:

- Approved
- Active
- Available
- Covers the booking location
- Supports vehicle category
- Has remaining booking capacity

---

## Business Rules

Ineligible washers never receive the booking.

---

# FR-019 Booking Broadcast

## Priority

Critical

---

## Description

Eligible washers shall receive a booking request notification.

---

## Functional Behaviour

The booking request contains:

- Approximate location
- Vehicle category
- Slot
- Estimated payout
- Distance
- Booking expiry time (if configured)

Customer identity is not exposed before acceptance.

---

## Acceptance Criteria

Only eligible washers receive the request.

---

# FR-020 Booking Acceptance

## Priority

Critical

---

## Description

A washer may accept a booking request.

---

## Main Flow

1. Washer reviews request.
2. Washer accepts.
3. System validates capacity.
4. Booking assigned.

---

## Business Rules

Assignment is first-accept wins.

---

## Post Conditions

Booking disappears from every other washer.

---

# FR-021 Booking Capacity Validation

## Priority

Critical

---

## Description

The system shall enforce administrator-configured booking capacity.

---

## Business Rules

Every washer has a configurable capacity value.

When capacity is reached:

- No additional bookings shown.
- Existing bookings remain unaffected.

---

## Acceptance Criteria

Capacity limits cannot be exceeded.

---

# FR-022 Booking Assignment

## Priority

Critical

---

## Description

The first eligible washer accepting the request becomes assigned.

---

## Post Conditions

Booking status changes to:

Accepted

---

## Notifications

Customer receives:

"Your booking has been accepted."

---

# FR-023 Washer On The Way

## Priority

High

---

## Description

The washer may indicate travel toward the customer.

---

## Functional Behaviour

Booking status becomes:

On The Way

---

## Business Rules

This status:

- Does not indicate service started.
- Enables travel compensation rules.
- Improves operational visibility.

---

## Customer Notification

"Your washer is on the way."

---

# FR-024 Wash Started

## Priority

Critical

---

## Description

The washer explicitly starts the service.

---

## Functional Behaviour

Booking status becomes:

Wash Started

---

## Business Rules

After this point:

- Customer cancellation is not refundable.
- Washer cancellation prohibited.
- Booking becomes operationally active.

---

# FR-025 Wash Completion Evidence

## Priority

Critical

---

## Description

The washer shall upload mandatory completion evidence.

---

## Required Evidence

- Before Photo
- After Photo
- GPS Location
- Timestamp

---

## Validation

Submission fails if mandatory evidence is missing.

---

# FR-026 Mark Booking Completed

## Priority

Critical

---

## Description

The washer completes the booking.

---

## Main Flow

1. Evidence uploaded.
2. Completion submitted.
3. Booking status updated.
4. Customer notified.

---

## Post Conditions

Booking enters:

Dispute Window

---

# FR-027 Silent Completion

## Priority

Critical

---

## Description

Customer approval is not required to finalize completion.

---

## Functional Behaviour

Customer receives:

"Your wash has been completed."

The booking automatically finalizes after the dispute window expires.

---

## Business Rules

Customers may raise disputes before automatic closure.

---

# FR-028 Booking History

## Priority

High

---

## Description

Customers and washers shall view historical bookings.

---

## Information Displayed

- Booking ID
- Date
- Vehicle
- Status
- Amount
- Location
- Completion Time

---

## Business Rules

Historical bookings are read-only.

---

# FR-029 Booking Search & Filter

## Priority

Medium

---

## Description

Users may search and filter booking history.

---

## Filters

- Date
- Status
- Vehicle
- Amount

---

# FR-030 Booking Status Tracking

## Priority

Critical

---

## Description

Customers shall always see the latest booking status.

---

## Possible Statuses

- Awaiting Acceptance
- Accepted
- On The Way
- Wash Started
- Completed
- Dispute
- Closed
- Cancelled

---

## Business Rules

Status changes occur only through authorized workflows.

---

# End of Booking Management Module

---

# Module 3 — Payment, Refund & Payout Management

This module governs all financial transactions performed by the platform.

The system shall ensure that payments, refunds, travel compensation, and weekly washer payouts are processed accurately, securely, and consistently.

All financial operations shall be auditable.

---

# FR-031 Initiate Payment

## Priority

Critical

## Actors

- Customer
- Payment Gateway

---

## Description

The system shall initiate payment after the customer confirms the booking summary.

---

## Preconditions

- Booking details are valid.
- Final price has been calculated.
- Slot is available.

---

## Main Flow

1. Customer selects payment method.
2. System creates a payment request.
3. Customer is redirected to the payment gateway.
4. Gateway processes the transaction.

---

## Exceptions

- Gateway unavailable
- Network timeout
- Invalid payment method

---

## Acceptance Criteria

Payment request is successfully initiated through the configured payment gateway.

---

# FR-032 Payment Verification

## Priority

Critical

---

## Description

The system shall verify the payment result before creating a booking.

---

## Functional Behaviour

The backend shall verify:

- Transaction ID
- Payment status
- Amount paid
- Payment signature (if supported)

---

## Business Rules

Bookings shall never be created solely based on client-side success.

Payment verification shall occur server-side.

---

## Acceptance Criteria

Only verified successful payments result in booking creation.

---

# FR-033 Payment Failure Handling

## Priority

Critical

---

## Description

The system shall gracefully handle failed payment attempts.

---

## Failure Reasons

- Payment declined
- User cancelled payment
- Gateway timeout
- Bank failure
- Technical error

---

## System Behaviour

- Booking shall not be created.
- Customer shall receive an appropriate error message.
- Customer may retry payment.

---

## Acceptance Criteria

Failed payments shall not create duplicate or partial bookings.

---

# FR-034 Payment Record Management

## Priority

Critical

---

## Description

The system shall maintain a complete record of every payment transaction.

---

## Stored Information

- Payment ID
- Booking ID
- Customer ID
- Amount
- Currency
- Payment Method
- Gateway Transaction ID
- Status
- Timestamp

---

## Business Rules

Payment records are immutable except for status updates resulting from gateway callbacks.

---

# FR-035 Booking Invoice

## Priority

High

---

## Description

The system shall generate an invoice for every successful booking.

---

## Invoice Contents

- Booking ID
- Customer Name
- Vehicle Details
- Booking Date
- Service Location
- Amount Paid
- Tax Inclusive Price
- Payment Status

---

## Business Rules

Invoices are read-only after generation.

---

# FR-036 Customer Refund Initiation

## Priority

Critical

---

## Description

The system shall initiate refunds according to platform cancellation and dispute policies.

---

## Refund Triggers

- Customer cancellation
- Platform cancellation
- Replacement failure
- Approved dispute
- Administrative override

---

## Business Rules

Refund eligibility depends on booking status.

---

## Acceptance Criteria

Only eligible bookings may receive refunds.

---

# FR-037 Refund Calculation

## Priority

Critical

---

## Description

The system shall calculate the correct refundable amount.

---

## Inputs

- Booking Amount
- Booking Status
- Travel Compensation
- Administrative Adjustments

---

## Business Rules

Refund amount shall never exceed the amount paid.

Travel compensation shall only apply when:

- Washer marked "On The Way"

---

## Acceptance Criteria

Refund calculations follow configured business policies.

---

# FR-038 Refund Processing

## Priority

Critical

---

## Description

The system shall submit approved refunds through the payment gateway.

---

## Main Flow

1. Refund approved.
2. Refund request sent to gateway.
3. Gateway confirms acceptance.
4. Refund status updated.

---

## Business Rules

Refund status shall be tracked until completion.

---

# FR-039 Travel Compensation

## Priority

High

---

## Description

The system shall compensate washers for verified travel effort when applicable.

---

## Preconditions

- Booking cancelled by customer.
- Washer marked "On The Way."
- Wash not started.

---

## Business Rules

Travel compensation:

- Configurable
- Deducted from refund
- Paid to washer

---

## Acceptance Criteria

Travel compensation is never paid unless eligibility conditions are met.

---

# FR-040 Weekly Earnings Calculation

## Priority

Critical

---

## Description

The system shall calculate washer earnings eligible for payout.

---

## Eligibility Rules

Booking must satisfy:

- Completed
- Mandatory evidence uploaded
- Dispute window expired
- No active dispute

---

## Business Rules

Pending bookings shall not contribute to payout calculations.

---

# FR-041 Weekly Payout Generation

## Priority

Critical

---

## Description

The system shall generate weekly payout batches.

---

## Functional Behaviour

For every eligible washer:

- Calculate total earnings.
- Apply adjustments.
- Generate payout record.

---

## Business Rules

Payout schedule is administrator configurable.

---

# FR-042 Payout Processing

## Priority

Critical

---

## Description

Administrators shall process weekly payouts.

---

## Functional Behaviour

The system shall:

- Display pending payouts.
- Display completed bookings.
- Allow payout approval.
- Record payout completion.

---

## Acceptance Criteria

Every payout is linked to completed eligible bookings.

---

# FR-043 Payout History

## Priority

High

---

## Description

Washers shall view historical payout information.

---

## Displayed Information

- Payout Date
- Booking Count
- Gross Earnings
- Adjustments
- Final Amount
- Status

---

## Business Rules

Historical payouts are read-only.

---

# FR-044 Financial Audit Log

## Priority

Critical

---

## Description

The system shall maintain an immutable audit trail for all financial operations.

---

## Logged Events

- Payment Initiated
- Payment Verified
- Refund Approved
- Refund Processed
- Travel Compensation Applied
- Payout Generated
- Payout Approved
- Administrative Override

---

## Business Rules

Audit records cannot be modified or deleted through normal administrative operations.

---

# Financial Business Rules

The following business rules apply to every financial operation:

- Customers always pay before booking creation.
- Platform controls all customer pricing.
- Washers cannot edit pricing.
- Refund eligibility depends on booking state.
- Travel compensation applies only after "On The Way."
- Payouts occur only after the dispute window closes.
- Every financial transaction shall be traceable.
- Administrative overrides shall always be audited.

---

# End of Payment, Refund & Payout Management Module

---

# Module 4 — Dispute, Rating & Trust Management

This module governs customer disputes, administrative resolution, rating systems, trust scoring, fraud detection, and disciplinary actions.

The objective is to ensure fairness, maintain service quality, and preserve confidence in the platform.

---

# FR-045 Raise Dispute

## Priority

Critical

## Actors

- Customer

---

## Description

The system shall allow customers to raise a dispute against a completed booking.

---

## Preconditions

- Booking status is Completed.
- Booking is within the dispute window.
- Customer owns the booking.

---

## Main Flow

1. Customer opens completed booking.
2. Customer selects "Raise Issue."
3. Customer selects dispute category.
4. Customer enters description.
5. Customer uploads supporting evidence (optional).
6. Customer submits dispute.
7. System records the dispute.
8. Booking status changes to **Dispute**.
9. Washer payout is placed on hold.

---

## Dispute Categories

- Wash quality issue
- Vehicle not washed
- Wrong vehicle washed
- Property damage
- Incomplete service
- Washer misconduct
- Other

---

## Exceptions

- Dispute window expired
- Duplicate dispute
- Invalid booking

---

## Business Rules

Only one active dispute may exist for a booking.

---

## Acceptance Criteria

Eligible customers can successfully create disputes.

---

# FR-046 Dispute Validation

## Priority

Critical

---

## Description

The system shall validate disputes before accepting them.

---

## Validation Rules

The system shall verify:

- Booking ownership
- Booking status
- Dispute window
- Duplicate disputes
- Mandatory fields

---

## Business Rules

Invalid disputes shall be rejected immediately.

---

# FR-047 Evidence Submission

## Priority

High

---

## Description

Customers may upload supporting evidence.

---

## Supported Evidence

- Images
- Written explanation

Video support may be introduced in future versions.

---

## Validation

Images shall satisfy:

- Supported file type
- Maximum file size
- Malware scan (future)

---

# FR-048 Administrative Dispute Review

## Priority

Critical

## Actors

- Administrator

---

## Description

Administrators shall review submitted disputes.

---

## Available Information

Customer Information

- Complaint
- Uploaded evidence

Washer Information

- Before photo
- After photo
- GPS location
- Timestamp
- Customer unreachable evidence (if applicable)

Booking Information

- Timeline
- Status history
- Payment history

---

## Business Rules

Administrative decisions shall be recorded permanently.

---

# FR-049 Dispute Resolution

## Priority

Critical

---

## Description

Administrators shall resolve disputes.

---

## Possible Outcomes

- Booking Approved
- Full Refund
- Partial Refund
- No Refund
- Partial Washer Compensation
- Full Washer Compensation
- Warning Issued
- Suspension Recommended

---

## Post Conditions

Booking leaves dispute state.

Payout eligibility updated accordingly.

---

## Acceptance Criteria

Every dispute receives exactly one final decision.

---

# FR-050 Customer Rating

## Priority

High

---

## Description

Customers shall rate completed bookings.

---

## Rating Scale

1 Star

2 Stars

3 Stars

4 Stars

5 Stars

---

## Optional Fields

- Written review

---

## Business Rules

One rating per booking.

Ratings cannot be edited after submission.

---

# FR-051 Washer Rating Calculation

## Priority

High

---

## Description

The system shall maintain an average washer rating.

---

## Inputs

- Customer ratings
- Completed bookings

---

## Business Rules

Average ratings update automatically.

---

## Acceptance Criteria

Latest rating immediately affects washer average.

---

# FR-052 Washer Trust Score

## Priority

Critical

---

## Description

The platform shall maintain an internal trust score for every washer.

This score is not visible to customers.

---

## Inputs

Trust score may consider:

- Completion rate
- Cancellation rate
- Average rating
- Disputes
- Fraud history
- Administrative actions
- Platform experience

---

## Usage

Trust score may influence:

- Future booking capacity
- Operational monitoring
- Administrative review
- Future intelligent assignment

---

## Business Rules

Trust score calculation remains platform controlled.

---

# FR-053 Customer Reliability Score

## Priority

Medium

---

## Description

The platform shall maintain an internal reliability profile for customers.

---

## Inputs

- Cancellation frequency
- Fraud attempts
- Customer unreachable incidents
- Repeated disputes
- Administrative actions

---

## Business Rules

Reliability score remains private.

Washers cannot access this information.

---

# FR-054 Fraud Detection

## Priority

High

---

## Description

The platform shall identify potentially fraudulent behaviour.

---

## Fraud Indicators

Customer

- Repeated fake disputes
- Excessive cancellations
- Payment abuse

Washer

- Fake completion
- Duplicate photographs
- GPS manipulation
- Repeated customer unreachable reports
- Excessive cancellations

---

## Functional Behaviour

Suspicious activity shall generate internal alerts for administrators.

Automatic suspension rules may be introduced in future versions.

---

# FR-055 Administrative Actions

## Priority

Critical

---

## Description

Administrators shall manage disciplinary actions.

---

## Available Actions

Customer

- Warning
- Temporary suspension
- Permanent suspension

Washer

- Warning
- Capacity reduction
- Temporary suspension
- One-day suspension
- Permanent suspension

---

## Business Rules

Every disciplinary action shall include:

- Reason
- Administrator
- Timestamp
- Notes

---

# FR-056 Administrative Override

## Priority

Critical

---

## Description

Administrators may override automated system decisions in exceptional circumstances.

---

## Override Examples

- Force booking cancellation
- Manual refund
- Partial refund
- Manual payout adjustment
- Restore suspended account
- Reverse disciplinary action

---

## Business Rules

Every override shall be:

- Audited
- Timestamped
- Linked to the administrator
- Include a mandatory reason

Overrides are exceptional and should not replace standard workflows.

---

# Trust & Safety Business Rules

The following principles apply throughout the platform:

- Customers may raise disputes only within the configured dispute window.
- One dispute per booking.
- Washer payouts remain pending during active disputes.
- Ratings are permanent after submission.
- Internal trust metrics are never exposed publicly.
- Fraud detection shall assist administrators but not replace human judgment.
- Administrative decisions are final unless superseded by a higher operational authority.
- All disciplinary actions and overrides shall be fully auditable.

---

# End of Dispute, Rating & Trust Management Module

---

# Module 5 — Administrative Management

This module defines the functional requirements of the Administrative Web Portal.

The Admin Portal is the operational control center of the platform and provides authorized administrators with tools to manage users, bookings, pricing, payouts, disputes, service areas, and platform configuration.

---

# FR-057 Administrator Dashboard

## Priority

Critical

## Actors

- Administrator

---

## Description

The system shall provide administrators with a centralized dashboard summarizing operational and business metrics.

---

## Dashboard Widgets

- Total Customers
- Active Customers
- Approved Washers
- Pending Washer Approvals
- Today's Bookings
- Completed Bookings
- Active Disputes
- Pending Refunds
- Pending Weekly Payouts
- Revenue Summary
- Recent Activity Feed

---

## Business Rules

Dashboard data shall reflect near real-time platform activity.

---

# FR-058 Washer Application Review

## Priority

Critical

---

## Description

Administrators shall review newly submitted washer applications.

---

## Available Information

- Personal Details
- Mobile Number
- Identity Document
- Selfie
- Home Base
- Service Area
- Registration Date

---

## Available Actions

- Approve
- Reject
- Request Resubmission (Future)
- Suspend

---

## Business Rules

Only approved washers may receive bookings.

Every decision shall be logged.

---

# FR-059 Washer Management

## Priority

Critical

---

## Description

Administrators shall manage washer accounts.

---

## Available Functions

- Search Washers
- View Profile
- Edit Information
- Suspend Account
- Reactivate Account
- Modify Capacity
- View Earnings
- View Booking History
- View Ratings
- View Trust Score

---

## Business Rules

Suspended washers shall not receive new bookings.

---

# FR-060 Customer Management

## Priority

High

---

## Description

Administrators shall manage customer accounts.

---

## Available Functions

- Search Customers
- View Profile
- View Booking History
- View Payment History
- Suspend Account
- Reactivate Account
- View Reliability Score

---

## Business Rules

Customer suspension prevents new bookings but preserves historical records.

---

# FR-061 Booking Management

## Priority

Critical

---

## Description

Administrators shall manage platform bookings.

---

## Available Functions

- Search Bookings
- View Booking Details
- View Booking Timeline
- Cancel Booking
- Force Complete (Exceptional)
- Reassign Booking (Exceptional)
- View Completion Evidence

---

## Business Rules

Administrative modifications shall be recorded in audit logs.

---

# FR-062 Pricing Management

## Priority

Critical

---

## Description

Administrators shall configure platform pricing.

---

## Configurable Parameters

- Two Wheeler Base Price
- Four Wheeler Base Price
- Distance Pricing Rules
- Platform Service Fee
- Travel Compensation Amount
- Tax Configuration

---

## Business Rules

Pricing changes affect only future bookings.

Existing bookings retain their original price.

---

# FR-063 Time Slot Management

## Priority

Critical

---

## Description

Administrators shall configure available booking time slots.

---

## Functions

- Create Slot
- Edit Slot
- Disable Slot
- Delete Future Slot

---

## Business Rules

Existing bookings remain unaffected by slot changes.

---

# FR-064 Booking Capacity Management

## Priority

Critical

---

## Description

Administrators shall define booking capacity for each washer.

---

## Configurable Fields

- Maximum Bookings Per Slot
- Effective Date

---

## Business Rules

Capacity changes apply only to future booking assignments.

---

# FR-065 Service Area Management

## Priority

Critical

---

## Description

Administrators shall manage service coverage.

---

## Functions

- View Coverage
- Edit Coverage
- Approve Washer Coverage
- Restrict Coverage
- Disable Coverage

---

## Supported Coverage Models

- Polygon
- Radius (Future Support)

---

## Business Rules

Only serviceable areas may receive bookings.

---

# FR-066 Refund Management

## Priority

Critical

---

## Description

Administrators shall review and process refund requests.

---

## Available Information

- Booking Details
- Payment Details
- Cancellation Reason
- Dispute Status
- Refund Eligibility

---

## Available Actions

- Full Refund
- Partial Refund
- Reject Refund
- Administrative Override

---

## Business Rules

Refund decisions shall generate audit records.

---

# FR-067 Weekly Payout Management

## Priority

Critical

---

## Description

Administrators shall manage washer payouts.

---

## Functions

- View Eligible Earnings
- Generate Weekly Batch
- Approve Batch
- Mark Paid
- Export Payout Report

---

## Business Rules

Only eligible bookings contribute to payouts.

---

# FR-068 Dispute Management

## Priority

Critical

---

## Description

Administrators shall review and resolve customer disputes.

---

## Available Information

- Booking Timeline
- Customer Evidence
- Washer Evidence
- Photos
- GPS Data
- Previous Disputes

---

## Available Actions

- Approve Refund
- Reject Refund
- Partial Refund
- Issue Warning
- Suspend Washer
- Close Dispute

---

# FR-069 Notification Management

## Priority

Medium

---

## Description

Administrators shall configure platform notifications.

---

## Functions

- Enable Notification Types
- Disable Notification Types
- Configure Notification Templates
- Send Broadcast Announcement

---

## Business Rules

Notification configuration affects future notifications only.

---

# FR-070 Platform Configuration

## Priority

Critical

---

## Description

Administrators shall configure global platform settings.

---

## Configurable Settings

- Dispute Window Duration
- Travel Compensation Amount
- Customer Waiting Time
- Booking Capacity Defaults
- Tax Settings
- Platform Fees
- Supported Vehicle Categories
- Weekly Payout Day

---

## Business Rules

Configuration changes shall not invalidate active bookings.

---

# FR-071 Reports & Analytics

## Priority

High

---

## Description

Administrators shall access operational and financial reports.

---

## Available Reports

- Revenue Report
- Booking Report
- Refund Report
- Dispute Report
- Washer Performance
- Customer Activity
- Payout Report

---

## Business Rules

Reports may be filtered by:

- Date Range
- City (Future)
- Washer
- Booking Status

---

# FR-072 Audit Log Management

## Priority

Critical

---

## Description

The system shall maintain an immutable log of administrative activities.

---

## Logged Events

- Login
- Logout
- Pricing Changes
- Refund Decisions
- Payout Approval
- Capacity Changes
- Account Suspension
- Configuration Changes
- Administrative Overrides

---

## Business Rules

Audit records shall:

- Include timestamp
- Include administrator identity
- Include previous value
- Include new value (where applicable)
- Include reason (where required)

Audit logs shall be read-only.

---

# FR-073 Role & Permission Management

## Priority

Medium

---

## Description

The system shall support role-based permissions for administrative users.

---

## Default Roles

- Super Administrator
- Operations Administrator
- Support Administrator
- Finance Administrator

---

## Business Rules

Permissions shall be configurable.

Users may only perform actions explicitly granted to their role.

---

# Administrative Business Rules

The following principles apply to the Admin Portal:

- Administrators are responsible for marketplace governance.
- Administrative actions shall be auditable.
- Pricing changes affect future bookings only.
- Configuration changes shall not retroactively modify completed bookings.
- Manual overrides are exceptional and require justification.
- Historical records shall never be physically deleted.
- Suspended users retain historical data.
- Financial operations require traceability.
- Global configuration shall be centralized and versioned where practical.

---

# End of Administrative Management Module

---

# 12. Non-Functional Requirements

This chapter defines the quality attributes that the Mobile Vehicle Wash Marketplace Platform shall satisfy.

Unlike Functional Requirements, these requirements specify how the system should perform rather than what features it provides.

These requirements apply to all software components unless explicitly stated otherwise.

---

# NFR-001 Performance

## Objective

The platform shall provide a responsive and smooth user experience under expected operating conditions.

---

## Requirements

- API responses should typically complete within **500 ms** under normal load.
- Payment-related APIs should typically complete within **2 seconds**, excluding third-party gateway latency.
- Dashboard pages should load within **3 seconds**.
- Booking confirmation should be displayed immediately after successful payment verification.
- Image upload processing should begin immediately after upload completion.

---

## Performance Goals

- Support concurrent users without noticeable degradation.
- Minimize unnecessary network requests.
- Optimize database queries.
- Use asynchronous processing for long-running tasks where appropriate.

---

# NFR-002 Availability

## Objective

The platform should remain available to users with minimal downtime.

---

## Requirements

- Target annual uptime: **99.9%**
- Planned maintenance should be scheduled during low-traffic periods.
- Critical backend services should support graceful recovery after failures.

---

# NFR-003 Reliability

## Objective

The platform shall maintain consistent and correct behavior.

---

## Requirements

- Financial transactions shall never be processed more than once.
- Booking status shall remain consistent across all applications.
- Failed operations shall not leave data in an inconsistent state.
- Retry mechanisms should be idempotent where applicable.

---

# NFR-004 Scalability

## Objective

The architecture shall support future growth.

---

## Requirements

The system should scale to support:

- Multiple cities
- Thousands of daily bookings
- Thousands of active users
- Additional vehicle categories
- Additional service types

The architecture should support horizontal scaling of backend services.

---

# NFR-005 Security

## Objective

Protect customer, washer, and platform data from unauthorized access.

---

## Requirements

- All communication shall use HTTPS.
- Authentication tokens shall be securely generated.
- Passwords (where applicable) shall never be stored in plain text.
- Sensitive information shall be encrypted where appropriate.
- Administrative operations shall require authentication and authorization.

---

## Security Principles

- Least Privilege
- Defense in Depth
- Secure by Default
- Principle of Minimum Exposure

---

# NFR-006 Privacy

## Objective

Protect personally identifiable information (PII).

---

## Requirements

The platform shall protect:

- Mobile numbers
- Addresses
- Identity documents
- GPS coordinates
- Payment references

Sensitive information shall only be accessible to authorized users.

---

# NFR-007 Maintainability

## Objective

The software should be easy to understand, modify, and extend.

---

## Requirements

- Modular architecture.
- Clear separation of concerns.
- Reusable business logic.
- Consistent coding standards.
- Automated testing support.

---

# NFR-008 Extensibility

## Objective

Future features should require minimal architectural changes.

---

## Examples

Future support may include:

- Subscription plans
- Fleet management
- Live tracking
- AI-based booking assignment
- Dynamic pricing
- Referral programs
- Loyalty rewards
- Corporate customers

---

# NFR-009 Configurability

## Objective

Business rules should be configurable wherever practical.

---

## Configurable Items

- Pricing
- Capacity
- Time slots
- Travel compensation
- Dispute duration
- Notification templates
- Tax configuration
- Payout schedule

Changes should not require source code modification.

---

# NFR-010 Usability

## Objective

Applications shall remain simple and intuitive.

---

## Requirements

- Minimize user input.
- Reduce unnecessary screens.
- Provide meaningful error messages.
- Ensure consistent navigation.
- Use familiar UI patterns.

---

# NFR-011 Accessibility

## Objective

Applications should remain usable for the widest possible audience.

---

## Requirements

- Support scalable text sizes.
- Maintain sufficient color contrast.
- Provide descriptive labels for interactive elements.
- Ensure touch targets are appropriately sized.

---

# NFR-012 Compatibility

## Objective

Support commonly used platforms.

---

## Customer App

- Android (Primary)
- iOS (Future)

---

## Washer App

- Android (Primary)
- iOS (Future)

---

## Admin Portal

Modern desktop browsers supporting current standards.

---

# NFR-013 Logging

## Objective

Record important operational events.

---

## Logged Events

- Authentication
- Booking lifecycle changes
- Payment events
- Refund events
- Administrative actions
- System errors

---

## Business Rules

Logs shall include:

- Timestamp
- User ID (where applicable)
- Event type
- Result
- Correlation/Request ID

---

# NFR-014 Monitoring

## Objective

Enable proactive operational monitoring.

---

## Monitor

- API health
- Server health
- Database performance
- Payment failures
- Notification failures
- Background job failures

Alerts should be generated for critical failures.

---

# NFR-015 Backup & Recovery

## Objective

Protect platform data against accidental loss.

---

## Requirements

- Scheduled database backups.
- Secure backup storage.
- Recovery procedures documented and periodically tested.
- Recovery should preserve transactional integrity.

---

# NFR-016 Error Handling

## Objective

Provide consistent handling of unexpected conditions.

---

## Requirements

- User-friendly error messages.
- Internal logging of technical details.
- No exposure of sensitive implementation details.
- Standardized API error format.

---

# NFR-017 Internationalization

## Objective

Support future localization.

---

## Requirements

- Externalize user-facing text.
- Support multiple languages in the future.
- Support locale-specific formatting for dates, numbers, and currency.

---

# NFR-018 Auditability

## Objective

Support investigation and compliance.

---

## Requirements

The following actions shall be auditable:

- Pricing changes
- Refund decisions
- Payout approvals
- User suspensions
- Configuration updates
- Administrative overrides

Audit records shall be immutable.

---

# NFR-019 Data Integrity

## Objective

Ensure correctness and consistency of stored data.

---

## Requirements

- Primary keys shall be unique.
- Foreign key relationships shall remain valid.
- Transactions shall maintain atomicity.
- Duplicate bookings shall be prevented where applicable.

---

# NFR-020 Disaster Recovery

## Objective

Restore critical services after catastrophic failures.

---

## Requirements

- Recovery procedures shall be documented.
- Critical backups shall be geographically redundant where feasible.
- Recovery testing should be performed periodically.

---

# Non-Functional Requirement Summary

The platform shall prioritize the following quality attributes:

- Performance
- Reliability
- Availability
- Security
- Privacy
- Scalability
- Maintainability
- Extensibility
- Configurability
- Auditability
- Data Integrity
- Monitoring
- Disaster Recovery
- Usability
- Accessibility

These requirements shall guide all architectural, implementation, deployment, and operational decisions throughout the lifecycle of the platform.

---

# 13. System State Machines

This chapter defines the lifecycle of major entities within the platform.

State machines ensure that entities transition only through valid states and prevent inconsistent system behavior.

Every state transition shall be validated by the backend.

---

# 13.1 Booking State Machine

## Objective

The Booking State Machine defines every valid status a booking may enter during its lifecycle.

---

## Booking States

1. Awaiting Acceptance
2. Accepted
3. On The Way
4. Wash Started
5. Completed (Dispute Window Active)
6. Dispute
7. Closed
8. Cancelled

---

## State Transition Diagram

```text
Customer Creates Booking
            │
            ▼
 Awaiting Acceptance
            │
            ▼
       Accepted
            │
            ▼
      On The Way
            │
            ▼
     Wash Started
            │
            ▼
 Completed (Dispute Window)
      │                 │
      │                 ▼
      │             Dispute
      │                 │
      └────────────┬────┘
                   ▼
                Closed

Customer Cancel
      │
      ▼
 Cancelled
```

---

## State Descriptions

### Awaiting Acceptance

Booking has been created after successful payment.

No washer has accepted yet.

---

### Accepted

A washer has accepted responsibility for the booking.

---

### On The Way

The washer has started traveling toward the customer's location.

Travel compensation policies become applicable from this state.

---

### Wash Started

The washer has begun performing the wash.

Customer cancellation is no longer eligible for a refund.

Washer cancellation is prohibited.

---

### Completed

The washer has uploaded mandatory evidence and marked the booking complete.

The dispute window begins.

---

### Dispute

Customer has raised an issue within the dispute window.

Washer payout is paused until resolution.

---

### Closed

The booking is finalized.

Possible reasons include:

- Dispute resolved
- Dispute window expired without issue

---

### Cancelled

Booking terminated before completion.

Refund policy depends on booking stage.

---

## Invalid Transitions

The system shall reject invalid transitions.

Examples include:

- Completed → Wash Started
- Closed → Accepted
- Cancelled → Wash Started
- Dispute → On The Way
- Accepted → Awaiting Acceptance

---

# 13.2 Payment State Machine

---

## States

- Initiated
- Pending
- Successful
- Failed
- Refunded
- Partially Refunded

---

## State Flow

```text
Initiated
     │
     ▼
 Pending
  │      │
  ▼      ▼
Success Failed
   │
   ▼
Refunded / Partially Refunded
```

---

## Business Rules

Only successful payments create bookings.

Refund states require administrator approval or automated eligibility.

---

# 13.3 Washer Application State Machine

---

## States

- Draft
- Submitted
- Pending Review
- Approved
- Rejected
- Suspended

---

## State Flow

```text
Draft
   │
   ▼
Submitted
   │
   ▼
Pending Review
  │         │
  ▼         ▼
Approved Rejected
   │
   ▼
Suspended
```

---

## Business Rules

Only Approved washers may receive booking requests.

Rejected applications may require a new submission if reapplication is supported in the future.

---

# 13.4 Dispute State Machine

---

## States

- Open
- Under Review
- Resolved
- Closed

---

## Flow

```text
Open
 │
 ▼
Under Review
 │
 ▼
Resolved
 │
 ▼
Closed
```

---

## Business Rules

Every dispute shall receive exactly one final resolution.

Closed disputes cannot be reopened through standard workflows.

---

# 13.5 Refund State Machine

---

## States

- Requested
- Under Review
- Approved
- Rejected
- Processing
- Completed
- Failed

---

## Flow

```text
Requested
    │
    ▼
Under Review
  │        │
  ▼        ▼
Approved Rejected
   │
   ▼
Processing
 │      │
 ▼      ▼
Completed Failed
```

---

## Business Rules

Refund processing depends on payment gateway confirmation.

Failed refunds require administrative investigation.

---

# 13.6 Payout State Machine

---

## States

- Pending Eligibility
- Eligible
- Scheduled
- Processing
- Paid
- Failed

---

## Flow

```text
Pending Eligibility
         │
         ▼
      Eligible
         │
         ▼
     Scheduled
         │
         ▼
     Processing
      │      │
      ▼      ▼
    Paid   Failed
```

---

## Business Rules

Bookings contribute to payouts only after:

- Completion
- Dispute window expiration
- No active dispute

---

# 13.7 Washer Availability State Machine

---

## States

- Offline
- Available
- Busy
- Suspended

---

## Flow

```text
Offline
   │
   ▼
Available
   │
   ▼
 Busy
   │
   ▼
Available

Suspended
```

---

## Business Rules

Busy washers may still receive bookings if their configured slot capacity has not been reached.

Suspended washers cannot receive booking requests.

---

# 13.8 Notification State Machine

---

## States

- Queued
- Sent
- Delivered
- Failed

---

## Flow

```text
Queued
  │
  ▼
Sent
 │  │
 ▼  ▼
Delivered Failed
```

---

## Business Rules

Notification delivery failures should be logged for operational monitoring.

---

# General State Machine Rules

The following principles apply to all state machines:

- State transitions shall be validated by the backend.
- Invalid transitions shall be rejected.
- Every transition shall be timestamped.
- Critical transitions shall be recorded in audit logs.
- State changes shall trigger notifications where applicable.
- Historical states shall remain queryable for reporting and investigations.

State machines defined in this chapter are authoritative and shall be used by backend services, mobile applications, administrative tools, API implementations, and automated test suites.

---

# 14. Validation Rules & Business Constraints

This chapter defines the validation rules, business constraints, and data integrity requirements applicable throughout the platform.

These rules shall be enforced primarily by the backend to ensure consistent behavior regardless of the client application.

---

# 14.1 General Validation Principles

The following principles apply to all user inputs:

- All required fields shall be validated before processing.
- Client-side validation improves user experience but shall never replace server-side validation.
- Validation error messages shall be user-friendly.
- Invalid requests shall not modify system state.
- Unknown fields shall be ignored or rejected according to API specifications.
- Input sanitization shall be performed before persistence.

---

# 14.2 Customer Validation Rules

## Customer Name

### Constraints

- Required
- Minimum Length: 2 characters
- Maximum Length: 100 characters
- Leading and trailing whitespace shall be removed.

---

## Mobile Number

### Constraints

- Required
- Must be a valid Indian mobile number.
- Unique across customer accounts.
- Immutable after registration (MVP).

---

## Email Address

### Constraints

- Optional
- Must follow standard email format.
- Maximum Length: 255 characters.

---

## Profile Photo

### Constraints

- Optional
- Supported Formats: JPG, JPEG, PNG
- Maximum File Size: 5 MB

---

# 14.3 Washer Validation Rules

## Personal Information

- Name is required.
- Mobile verification is mandatory.
- Home base is mandatory.
- Service area is mandatory.

---

## Identity Verification

Required before approval:

- Government-issued ID
- Selfie photograph

Supported formats:

- JPG
- JPEG
- PNG
- PDF (for documents)

Maximum upload size: 10 MB per file.

---

## Availability

Washers shall define:

- Available slots
- Future availability (up to 30 days)

Unavailable slots shall not receive booking requests.

---

## Capacity

Capacity must be a positive integer.

Administrators may modify capacity at any time.

Capacity changes affect only future assignments.

---

# 14.4 Vehicle Validation Rules

## Vehicle Number

### Constraints

- Required
- Maximum Length: 20 characters
- Unique within the customer's account.

---

## Vehicle Type

Allowed Values

- Two Wheeler
- Four Wheeler

No additional categories are supported in the MVP.

---

## Vehicle Nickname

Optional.

Maximum Length: 50 characters.

---

# 14.5 Address Validation Rules

Required Fields

- Address Label
- Full Address
- Latitude
- Longitude

---

## Latitude

Valid Range:

-90 to +90

---

## Longitude

Valid Range:

-180 to +180

---

## Additional Notes

Optional.

Maximum Length:

500 characters.

---

# 14.6 Booking Validation Rules

A booking may only be created when:

- Customer is authenticated.
- Customer account is active.
- Vehicle exists.
- Address exists.
- Slot exists.
- Slot is available.
- Payment succeeds.

---

## Booking Date

Must not be:

- In the past.
- Beyond the platform booking horizon (configurable).

---

## Booking Slot

Must:

- Exist.
- Be enabled.
- Have available washer capacity.

---

## Multiple Vehicles

The system shall support booking multiple vehicles within a single booking, subject to pricing rules and washer capacity.

---

# 14.7 Payment Validation Rules

Payment Amount

Must exactly match the platform-calculated booking amount.

Client-calculated amounts shall never be trusted.

---

## Payment Status

Allowed Values

- Pending
- Successful
- Failed
- Refunded
- Partially Refunded

---

## Gateway Verification

Every successful payment shall be verified server-side.

---

# 14.8 Photo Validation Rules

Applicable to:

- Completion Photos
- Profile Photos
- Identity Documents
- Dispute Evidence

---

## Supported Formats

- JPG
- JPEG
- PNG

---

## Maximum Size

10 MB

---

## Completion Photos

Mandatory:

- Before Photo
- After Photo

Optional:

- Vehicle Photo

---

# 14.9 Dispute Validation Rules

A dispute is valid only when:

- Booking is completed.
- Dispute window is active.
- Customer owns the booking.
- No active dispute already exists.

---

## Description

Required.

Maximum Length:

1000 characters.

---

## Evidence

Optional but recommended.

---

# 14.10 Rating Validation Rules

Rating

Allowed Values:

- 1
- 2
- 3
- 4
- 5

---

Review

Optional.

Maximum Length:

1000 characters.

---

One rating per completed booking.

---

# 14.11 Administrative Validation Rules

Administrative actions requiring justification include:

- Refund Approval
- Partial Refund
- Manual Payout Adjustment
- Suspension
- Administrative Override
- Pricing Modification

Reason field is mandatory.

---

# 14.12 Business Constraints

The following business constraints apply throughout the system.

---

## Customer Constraints

- One mobile number per account.
- Multiple vehicles supported.
- Multiple addresses supported.
- Online payment only.
- One active dispute per booking.

---

## Washer Constraints

- Manual approval required before accepting bookings.
- Capacity controlled by administrators.
- Wash cannot be cancelled after "Wash Started."
- Mandatory completion evidence required.

---

## Booking Constraints

- Booking exists only after successful payment.
- One assigned washer at a time.
- Silent completion workflow.
- Dispute window required before payout.
- Booking history is immutable.

---

## Payment Constraints

- Platform controls pricing.
- Washers cannot modify customer pricing.
- Refunds follow platform policy.
- Weekly payouts only.

---

## Administrative Constraints

- Critical actions require audit logs.
- Manual overrides require reasons.
- Historical records shall never be physically deleted.

---

# 14.13 Data Integrity Rules

The system shall ensure:

- Unique primary keys.
- Referential integrity.
- Atomic financial transactions.
- Prevention of duplicate bookings due to repeated requests.
- Prevention of duplicate payment processing.
- Prevention of duplicate payout generation.

---

# 14.14 Concurrency Rules

The backend shall safely handle concurrent operations.

Examples include:

- Multiple washers attempting to accept the same booking.
- Duplicate payment callbacks.
- Simultaneous administrative updates.
- Repeated customer requests due to network retries.

Appropriate locking, transactions, or optimistic concurrency mechanisms shall be implemented to prevent inconsistent system state.

---

# Validation Summary

All validation rules and business constraints defined in this chapter are mandatory unless explicitly superseded by future platform revisions.

These rules form the basis for API validation, database constraints, frontend validation, automated testing, and operational consistency.

---

# 15. Standard Error Codes

This chapter defines the standardized error responses returned by the platform.

All APIs shall return consistent error structures to enable predictable handling by client applications.

The backend shall never expose internal implementation details, stack traces, database errors, or sensitive information.

---

# 15.1 Standard Error Response Format

Every failed API response shall follow a consistent structure.

Example:

```json
{
  "success": false,
  "error": {
    "code": "BOOKING_SLOT_UNAVAILABLE",
    "message": "The selected booking slot is no longer available.",
    "requestId": "REQ-8F3A12C7"
  }
}
```

---

## Response Fields

| Field | Description |
|--------|-------------|
| success | Indicates request success or failure |
| error.code | Machine-readable error identifier |
| error.message | Human-readable error message |
| requestId | Unique request identifier for debugging and support |

---

# 15.2 Authentication Errors

| Error Code | Description |
|------------|-------------|
| AUTH_INVALID_OTP | Invalid OTP provided |
| AUTH_OTP_EXPIRED | OTP has expired |
| AUTH_TOO_MANY_ATTEMPTS | OTP request limit exceeded |
| AUTH_ACCOUNT_SUSPENDED | Account is suspended |
| AUTH_ACCOUNT_NOT_FOUND | Account does not exist |
| AUTH_UNAUTHORIZED | Authentication required |
| AUTH_FORBIDDEN | Insufficient permissions |
| AUTH_SESSION_EXPIRED | Session has expired |
| AUTH_INVALID_TOKEN | Invalid authentication token |

---

# 15.3 Customer Errors

| Error Code | Description |
|------------|-------------|
| CUSTOMER_NOT_FOUND | Customer account not found |
| CUSTOMER_ALREADY_EXISTS | Customer already registered |
| CUSTOMER_INACTIVE | Customer account inactive |
| CUSTOMER_PROFILE_INCOMPLETE | Required profile information missing |

---

# 15.4 Washer Errors

| Error Code | Description |
|------------|-------------|
| WASHER_NOT_FOUND | Washer account not found |
| WASHER_PENDING_APPROVAL | Washer awaiting approval |
| WASHER_REJECTED | Washer application rejected |
| WASHER_SUSPENDED | Washer account suspended |
| WASHER_CAPACITY_REACHED | Washer has reached booking capacity |
| WASHER_NOT_AVAILABLE | Washer unavailable |
| WASHER_INVALID_SERVICE_AREA | Booking location outside approved service area |

---

# 15.5 Booking Errors

| Error Code | Description |
|------------|-------------|
| BOOKING_NOT_FOUND | Booking not found |
| BOOKING_ALREADY_ACCEPTED | Booking already accepted |
| BOOKING_ALREADY_COMPLETED | Booking already completed |
| BOOKING_ALREADY_CANCELLED | Booking already cancelled |
| BOOKING_SLOT_UNAVAILABLE | Selected slot unavailable |
| BOOKING_INVALID_STATUS | Invalid booking state transition |
| BOOKING_DUPLICATE_REQUEST | Duplicate booking request detected |
| BOOKING_DISPUTE_ACTIVE | Booking currently under dispute |
| BOOKING_NOT_ELIGIBLE_FOR_CANCELLATION | Booking cannot be cancelled |

---

# 15.6 Payment Errors

| Error Code | Description |
|------------|-------------|
| PAYMENT_FAILED | Payment unsuccessful |
| PAYMENT_TIMEOUT | Payment timed out |
| PAYMENT_VERIFICATION_FAILED | Payment verification failed |
| PAYMENT_ALREADY_PROCESSED | Payment already processed |
| PAYMENT_INVALID_AMOUNT | Payment amount mismatch |
| PAYMENT_GATEWAY_UNAVAILABLE | Payment gateway unavailable |

---

# 15.7 Refund Errors

| Error Code | Description |
|------------|-------------|
| REFUND_NOT_ALLOWED | Refund not permitted |
| REFUND_ALREADY_PROCESSED | Refund already completed |
| REFUND_PENDING | Refund already in progress |
| REFUND_PROCESSING_FAILED | Refund processing failed |

---

# 15.8 Payout Errors

| Error Code | Description |
|------------|-------------|
| PAYOUT_NOT_ELIGIBLE | Booking not eligible for payout |
| PAYOUT_ALREADY_GENERATED | Payout already generated |
| PAYOUT_ALREADY_PAID | Payout already completed |
| PAYOUT_PROCESSING_FAILED | Payout processing failed |

---

# 15.9 Dispute Errors

| Error Code | Description |
|------------|-------------|
| DISPUTE_ALREADY_EXISTS | Active dispute already exists |
| DISPUTE_WINDOW_EXPIRED | Dispute window has expired |
| DISPUTE_NOT_FOUND | Dispute not found |
| DISPUTE_ALREADY_RESOLVED | Dispute already resolved |
| DISPUTE_INVALID_STATUS | Invalid dispute status |

---

# 15.10 Vehicle Errors

| Error Code | Description |
|------------|-------------|
| VEHICLE_NOT_FOUND | Vehicle not found |
| VEHICLE_ALREADY_EXISTS | Vehicle already exists |
| VEHICLE_IN_ACTIVE_BOOKING | Vehicle linked to an active booking |
| VEHICLE_INVALID_TYPE | Unsupported vehicle type |

---

# 15.11 Address Errors

| Error Code | Description |
|------------|-------------|
| ADDRESS_NOT_FOUND | Address not found |
| ADDRESS_OUTSIDE_SERVICE_AREA | Address not serviceable |
| ADDRESS_IN_ACTIVE_BOOKING | Address linked to an active booking |
| ADDRESS_INVALID_LOCATION | Invalid latitude or longitude |

---

# 15.12 Validation Errors

| Error Code | Description |
|------------|-------------|
| VALIDATION_REQUIRED_FIELD | Required field missing |
| VALIDATION_INVALID_FORMAT | Invalid input format |
| VALIDATION_INVALID_LENGTH | Invalid input length |
| VALIDATION_INVALID_FILE | Unsupported file type |
| VALIDATION_FILE_TOO_LARGE | Uploaded file exceeds maximum size |
| VALIDATION_INVALID_DATE | Invalid date |
| VALIDATION_INVALID_SLOT | Invalid booking slot |

---

# 15.13 Administrative Errors

| Error Code | Description |
|------------|-------------|
| ADMIN_OPERATION_NOT_ALLOWED | Operation not permitted |
| ADMIN_CONFIGURATION_INVALID | Invalid configuration |
| ADMIN_OVERRIDE_REQUIRED | Administrative override required |
| ADMIN_AUDIT_REQUIRED | Audit information missing |

---

# 15.14 System Errors

| Error Code | Description |
|------------|-------------|
| SYSTEM_INTERNAL_ERROR | Unexpected internal error |
| SYSTEM_DATABASE_ERROR | Database operation failed |
| SYSTEM_SERVICE_UNAVAILABLE | Service temporarily unavailable |
| SYSTEM_RATE_LIMIT_EXCEEDED | Request rate limit exceeded |
| SYSTEM_DEPENDENCY_FAILURE | External service failure |
| SYSTEM_TIMEOUT | Request processing timed out |

---

# 15.15 HTTP Status Code Mapping

The platform shall use standard HTTP status codes.

| HTTP Status | Usage |
|-------------|-------|
| 200 OK | Successful request |
| 201 Created | Resource created successfully |
| 204 No Content | Successful request with no response body |
| 400 Bad Request | Invalid request |
| 401 Unauthorized | Authentication required |
| 403 Forbidden | Permission denied |
| 404 Not Found | Resource not found |
| 409 Conflict | Duplicate resource or invalid state |
| 422 Unprocessable Entity | Validation failure |
| 429 Too Many Requests | Rate limit exceeded |
| 500 Internal Server Error | Unexpected server error |
| 502 Bad Gateway | Upstream service error |
| 503 Service Unavailable | Service temporarily unavailable |
| 504 Gateway Timeout | Upstream timeout |

---

# 15.16 Error Handling Principles

The following principles apply to all errors:

- Error messages shall be consistent across all client applications.
- Internal implementation details shall never be exposed.
- Every error response shall include a request identifier.
- Validation errors should clearly indicate the field requiring correction.
- Errors shall be logged for operational monitoring.
- Repeated occurrences of critical errors should trigger administrative alerts.

---

# 15.17 Localization

User-facing error messages should support localization in future platform versions.

The `error.code` values shall remain stable and language-independent to ensure compatibility across clients and integrations.

---

# Error Code Summary

All platform APIs shall return standardized error responses using the error codes defined in this chapter.

These codes shall serve as the authoritative reference for:

- Backend implementation
- Mobile applications
- Admin Portal
- API documentation
- Automated testing
- Monitoring and alerting
- Customer support

---

# 16. Acceptance Criteria Matrix

## Objective

This chapter defines the measurable acceptance criteria for the functional requirements specified in this document.

Acceptance criteria provide a common understanding between Product Management, Development, QA, and Stakeholders regarding when a feature is considered complete.

A requirement shall be considered implemented only when all associated acceptance criteria have been satisfied.

---

# 16.1 Authentication & Account Management

| Requirement ID | Acceptance Criteria |
|---------------|---------------------|
| FR-001 Customer Registration | Customer can successfully register using a valid mobile number and OTP. Duplicate registrations are rejected. |
| FR-002 Customer Login | Registered customers can log in using OTP. Invalid or expired OTPs are rejected. |
| FR-003 Customer Logout | User session is terminated and protected resources become inaccessible. |
| FR-004 Edit Customer Profile | Profile changes are saved immediately after successful validation. |
| FR-005 Vehicle Management | Customers can add, edit, and delete vehicles unless linked to an active booking. |
| FR-006 Address Management | Customers can manage multiple addresses and select one during booking. |
| FR-007 Washer Registration | Washer applications remain pending until administrator approval. |
| FR-008 Washer Login | Only approved washers can authenticate successfully. |
| FR-009 Washer Profile Management | Editable profile fields update successfully while protected fields require approval. |
| FR-010 Admin Authentication | Only valid administrators can access the Admin Portal. |
| FR-011 Session Management | Expired or invalid sessions are rejected automatically. |
| FR-012 Role-Based Access Control | Users cannot access resources outside their assigned role. |

---

# 16.2 Booking Management

| Requirement ID | Acceptance Criteria |
|---------------|---------------------|
| FR-013 Create Booking | Booking can be initiated only with valid customer, vehicle, address, slot, and payment information. |
| FR-014 Price Calculation | Displayed price matches platform pricing configuration. |
| FR-015 Slot Availability | Only available slots are selectable. |
| FR-016 Payment Before Booking | Booking is not created until payment succeeds. |
| FR-017 Booking Creation | Successful payment generates a unique booking. |
| FR-018 Eligible Washer Discovery | Only eligible washers receive booking requests. |
| FR-019 Booking Broadcast | Booking notifications are sent only to eligible washers. |
| FR-020 Booking Acceptance | First eligible washer successfully claims the booking. |
| FR-021 Booking Capacity Validation | Washer capacity limits are enforced. |
| FR-022 Booking Assignment | Accepted booking disappears from other washer queues. |
| FR-023 Washer On The Way | Booking status updates correctly and customer receives notification. |
| FR-024 Wash Started | Booking enters operational state and cancellation restrictions apply. |
| FR-025 Wash Completion Evidence | Mandatory completion evidence is required before completion. |
| FR-026 Mark Booking Completed | Booking enters dispute window after successful completion. |
| FR-027 Silent Completion | Booking closes automatically after dispute window if no dispute exists. |
| FR-028 Booking History | Historical bookings are displayed accurately. |
| FR-029 Booking Search & Filter | Search and filters return matching bookings. |
| FR-030 Booking Status Tracking | Current booking status reflects the backend state accurately. |

---

# 16.3 Payment, Refund & Payout

| Requirement ID | Acceptance Criteria |
|---------------|---------------------|
| FR-031 Initiate Payment | Payment request is successfully sent to the gateway. |
| FR-032 Payment Verification | Booking is created only after server-side payment verification. |
| FR-033 Payment Failure Handling | Failed payments do not create bookings. |
| FR-034 Payment Record Management | Every payment is recorded with complete transaction details. |
| FR-035 Booking Invoice | Invoice is generated for successful bookings. |
| FR-036 Customer Refund Initiation | Eligible refunds can be initiated. |
| FR-037 Refund Calculation | Refund amount matches configured business rules. |
| FR-038 Refund Processing | Refund status updates according to gateway response. |
| FR-039 Travel Compensation | Eligible washers receive configured travel compensation. |
| FR-040 Weekly Earnings Calculation | Eligible bookings contribute to weekly earnings. |
| FR-041 Weekly Payout Generation | Weekly payout batches contain only eligible bookings. |
| FR-042 Payout Processing | Approved payouts update washer payout history. |
| FR-043 Payout History | Historical payouts are displayed correctly. |
| FR-044 Financial Audit Log | Financial events are permanently recorded. |

---

# 16.4 Dispute, Rating & Trust

| Requirement ID | Acceptance Criteria |
|---------------|---------------------|
| FR-045 Raise Dispute | Eligible customers can submit one dispute per booking. |
| FR-046 Dispute Validation | Invalid disputes are rejected. |
| FR-047 Evidence Submission | Supported evidence uploads successfully. |
| FR-048 Administrative Dispute Review | Administrators can access all dispute evidence. |
| FR-049 Dispute Resolution | Every dispute receives one final resolution. |
| FR-050 Customer Rating | Customers can rate completed bookings once. |
| FR-051 Washer Rating Calculation | Average rating updates automatically. |
| FR-052 Washer Trust Score | Trust score updates according to internal rules. |
| FR-053 Customer Reliability Score | Reliability profile updates based on customer behavior. |
| FR-054 Fraud Detection | Suspicious activity generates administrative alerts. |
| FR-055 Administrative Actions | Administrative actions update account status correctly. |
| FR-056 Administrative Override | Overrides require justification and are audited. |

---

# 16.5 Administrative Management

| Requirement ID | Acceptance Criteria |
|---------------|---------------------|
| FR-057 Administrator Dashboard | Dashboard displays current operational metrics. |
| FR-058 Washer Application Review | Administrators can approve or reject washer applications. |
| FR-059 Washer Management | Washer accounts can be managed according to permissions. |
| FR-060 Customer Management | Customer accounts can be managed according to permissions. |
| FR-061 Booking Management | Administrators can view and manage bookings. |
| FR-062 Pricing Management | Future bookings reflect updated pricing. |
| FR-063 Time Slot Management | Slot configuration affects future bookings only. |
| FR-064 Booking Capacity Management | Updated capacities apply to future assignments. |
| FR-065 Service Area Management | Service coverage updates correctly. |
| FR-066 Refund Management | Refund decisions follow business rules and are audited. |
| FR-067 Weekly Payout Management | Eligible payouts can be processed successfully. |
| FR-068 Dispute Management | Administrators can resolve disputes correctly. |
| FR-069 Notification Management | Notification settings affect future notifications. |
| FR-070 Platform Configuration | Platform settings update without affecting completed bookings. |
| FR-071 Reports & Analytics | Reports return accurate filtered data. |
| FR-072 Audit Log Management | Administrative actions are permanently recorded. |
| FR-073 Role & Permission Management | Role permissions are enforced consistently. |

---

# 16.6 General Acceptance Requirements

The following conditions apply to every functional requirement unless otherwise specified.

## Functional Correctness

- The feature behaves according to the documented requirements.
- Invalid inputs are handled correctly.
- Business rules are enforced.

---

## Security

- Unauthorized users cannot access protected resources.
- Sensitive information is protected.
- Role-based permissions are enforced.

---

## Reliability

- Operations remain consistent after retries.
- Duplicate requests do not create duplicate data.
- Transactions maintain data integrity.

---

## Performance

- Feature performance complies with Non-Functional Requirements.
- User interactions remain responsive under expected load.

---

## Auditability

Where applicable, critical operations generate audit records including:

- User
- Timestamp
- Action
- Result

---

## User Experience

Features shall:

- Display meaningful success messages.
- Display understandable validation errors.
- Prevent accidental destructive actions where appropriate.

---

# 16.7 Acceptance Process

A functional requirement shall be considered complete only when:

1. Development implementation is complete.
2. Unit tests pass.
3. Integration tests pass.
4. Acceptance criteria are satisfied.
5. QA approves the implementation.
6. Product Owner approves the feature.
7. No critical defects remain unresolved.

---

# Acceptance Criteria Summary

The acceptance criteria defined in this chapter establish the minimum standard required before any feature may be considered production-ready.

These criteria serve as the authoritative reference for quality assurance, release management, and stakeholder acceptance throughout the software development lifecycle.

---

# 17. Requirements Traceability Matrix (RTM)

## Objective

The Requirements Traceability Matrix (RTM) establishes traceability between Business Requirements, Functional Requirements, System Components, Test Cases, and Future Implementation.

Its purpose is to ensure that:

- Every business requirement is implemented.
- Every functional requirement is testable.
- Every implemented feature has a business justification.
- No requirement is unintentionally omitted.
- Changes can be tracked throughout the software lifecycle.

---

# 17.1 Traceability Principles

Every requirement shall have:

- A unique identifier.
- A clear business objective.
- One or more functional requirements.
- One or more test cases.
- A corresponding implementation component.

Traceability shall be maintained throughout the software development lifecycle.

---

# 17.2 Business Requirement to Functional Requirement Mapping

| Business Requirement | Functional Requirements |
|----------------------|-------------------------|
| Customer Account Management | FR-001 to FR-006 |
| Washer Onboarding & Verification | FR-007 to FR-009, FR-058, FR-059 |
| Administrator Authentication | FR-010 to FR-012 |
| Booking Lifecycle | FR-013 to FR-030 |
| Payment Processing | FR-031 to FR-035 |
| Refund Management | FR-036 to FR-039 |
| Washer Weekly Payout | FR-040 to FR-043 |
| Financial Audit | FR-044 |
| Dispute Management | FR-045 to FR-049 |
| Rating & Trust | FR-050 to FR-055 |
| Administrative Operations | FR-057 to FR-073 |

---

# 17.3 Functional Requirement to System Component Mapping

| Functional Area | Primary System Component |
|-----------------|-------------------------|
| Authentication | Authentication Service |
| Customer Management | Customer Service |
| Washer Management | Washer Service |
| Booking Management | Booking Service |
| Slot Management | Booking Service |
| Pricing | Pricing Engine |
| Payment | Payment Service |
| Refunds | Payment Service |
| Weekly Payout | Payout Service |
| Disputes | Dispute Service |
| Ratings | Rating Service |
| Notifications | Notification Service |
| File Upload | Media Service |
| Administrative Portal | Admin Service |
| Reporting | Reporting Service |
| Audit Logs | Audit Service |

---

# 17.4 Functional Requirement to Database Entity Mapping

| Functional Area | Primary Entities |
|-----------------|------------------|
| Customer | Customer |
| Washer | Washer |
| Vehicle | Vehicle |
| Address | Address |
| Booking | Booking |
| Booking Timeline | BookingStatusHistory |
| Slot | TimeSlot |
| Pricing | PricingConfiguration |
| Payment | PaymentTransaction |
| Refund | Refund |
| Payout | WeeklyPayout |
| Dispute | Dispute |
| Rating | Rating |
| Notification | Notification |
| Audit | AuditLog |
| Platform Configuration | SystemConfiguration |

---

# 17.5 Functional Requirement to API Mapping

| Functional Area | Example API Group |
|-----------------|------------------|
| Authentication | /auth |
| Customer | /customers |
| Vehicles | /vehicles |
| Addresses | /addresses |
| Washers | /washers |
| Bookings | /bookings |
| Slots | /slots |
| Payments | /payments |
| Refunds | /refunds |
| Payouts | /payouts |
| Disputes | /disputes |
| Ratings | /ratings |
| Notifications | /notifications |
| Administration | /admin |
| Reports | /reports |

API endpoints will be defined in the API Specification document.

---

# 17.6 Functional Requirement to UI Mapping

## Customer Mobile Application

Features include:

- Authentication
- Profile
- Vehicle Management
- Address Management
- Booking
- Booking History
- Payments
- Ratings
- Disputes

---

## Washer Mobile Application

Features include:

- Authentication
- Profile
- Availability
- Booking Queue
- Booking Timeline
- Completion Evidence
- Earnings
- Weekly Payout History

---

## Administrative Portal

Features include:

- Dashboard
- Customer Management
- Washer Management
- Booking Management
- Pricing Configuration
- Service Areas
- Capacity Configuration
- Refund Management
- Payout Management
- Dispute Resolution
- Reporting
- Audit Logs
- Platform Settings

---

# 17.7 Functional Requirement to Test Case Mapping

Each Functional Requirement shall have corresponding test cases.

Example:

| Functional Requirement | Test Case |
|------------------------|-----------|
| FR-001 | TC-AUTH-001 |
| FR-002 | TC-AUTH-002 |
| FR-013 | TC-BOOK-001 |
| FR-020 | TC-BOOK-007 |
| FR-031 | TC-PAY-001 |
| FR-037 | TC-REF-003 |
| FR-045 | TC-DISP-001 |
| FR-058 | TC-ADMIN-005 |

The complete Test Case Specification shall be maintained as a separate document.

---

# 17.8 Requirement Status Tracking

During implementation, each requirement should maintain a lifecycle status.

| Status | Description |
|--------|-------------|
| Proposed | Requirement identified but not approved |
| Approved | Accepted for implementation |
| In Development | Currently being implemented |
| Implemented | Development complete |
| Under Testing | QA validation in progress |
| Accepted | Approved by Product Owner |
| Deferred | Postponed to a future release |
| Deprecated | No longer applicable |

---

# 17.9 Change Management

Requirement modifications shall follow a controlled change process.

Each change shall record:

- Requirement ID
- Change Description
- Business Justification
- Request Date
- Requested By
- Approved By
- Version Number
- Implementation Status

Major changes affecting business logic should trigger review of:

- BRD
- SRS
- API Specification
- Database Design
- Test Cases
- UI Designs

---

# 17.10 Version History

The SRS shall maintain version history.

| Version | Date | Description | Author |
|---------|------|-------------|--------|
| 1.0 | Initial Release | Complete Software Requirements Specification | Product Team |

Future revisions shall increment the version number and document all significant changes.

---

# 17.11 Assumptions

The current SRS is based on the following assumptions:

- Initial launch supports India only.
- Vehicle categories are limited to Two Wheeler and Four Wheeler.
- Pricing is controlled entirely by the platform.
- Online payment is mandatory.
- Weekly washer payouts are used.
- Polygon-based service coverage is supported.
- Manual washer verification is required.
- Silent completion workflow is implemented.
- One dispute per booking is permitted.
- Future enhancements will extend, not replace, the architecture.

---

# 17.12 Out of Scope (Version 1)

The following features are intentionally excluded from Version 1:

- Live GPS tracking
- Real-time washer location sharing
- Subscription plans
- Corporate accounts
- Fleet management
- Dynamic surge pricing
- Promotional coupons
- Referral system
- Loyalty rewards
- AI-based booking assignment
- In-app chat
- Voice support
- Multi-country support
- Multi-currency support
- Washer-defined pricing
- Additional service add-ons

These may be introduced in future platform versions without requiring significant architectural redesign.

---

# 17.13 Document Conclusion

This Software Requirements Specification (SRS) defines the complete functional and non-functional requirements for the Mobile Vehicle Wash Marketplace Platform.

The document serves as the authoritative reference for:

- Product Management
- Software Architecture
- Backend Development
- Mobile Development
- Web Development
- Database Design
- API Design
- Quality Assurance
- DevOps
- Future Maintenance

Any implementation should conform to the requirements defined within this document unless superseded by an approved revision.

---

# End of Software Requirements Specification
