# Business Requirements Document (BRD)

# Mobile Vehicle Wash Marketplace Platform

**Document Version:** 1.0

**Status:** Finalized Business Requirements

**Project Type:** Mobile Marketplace Platform

**Target Platform:** Android, iOS, Web Admin Portal

**Primary Market:** India

---

# Document Purpose

This Business Requirements Document (BRD) defines the business objectives, operational policies, user journeys, platform rules, and functional expectations for the Mobile Vehicle Wash Marketplace Platform.

This document serves as the single source of truth for all business decisions before technical implementation begins. It intentionally focuses on business behaviour and platform policies rather than software architecture, database design, APIs, or implementation details.

The objective is to ensure that every stakeholder—including founders, product managers, designers, developers, testers, and future team members—shares the same understanding of how the platform is expected to operate.

Any future feature, workflow, or technical implementation must comply with the business rules defined within this document unless formally revised.

---

# Vision

To build India's most trusted on-demand vehicle washing marketplace that connects customers with verified professional washers while providing a seamless, transparent, and reliable booking experience.

The platform should remove the inconvenience of traditional vehicle washing by allowing customers to schedule professional washes at their preferred location and time while enabling independent washers to generate income through a structured digital platform.

---

# Mission

Provide a simple, reliable, and scalable marketplace where:

- Customers can easily schedule professional vehicle washes.
- Verified washers receive a steady flow of service requests.
- The platform ensures quality, trust, transparency, and operational efficiency.
- Administrative staff can monitor, manage, and resolve operational issues with minimal friction.

---

# Product Overview

The platform is an on-demand marketplace connecting customers requiring vehicle washing services with independently verified washers.

Customers schedule a wash by selecting their vehicle, location, date, and available time slot. The platform assigns the booking to an eligible washer operating within the selected service area.

The platform manages:

- Customer onboarding
- Washer onboarding
- KYC verification
- Booking lifecycle
- Payments
- Refunds
- Disputes
- Weekly washer payouts
- Pricing configuration
- Availability management
- Service area management
- Administrative oversight

The customer interacts only with the platform.

Operational changes occurring behind the scenes (such as Silent Reassignment) remain abstracted unless customer communication is necessary.

---

# Product Goals

The primary objectives of the platform are:

- Provide a frictionless customer booking experience.
- Build customer trust through verified washers.
- Eliminate manual coordination between customers and washers.
- Ensure predictable pricing.
- Prevent fraud from either party.
- Create a scalable operational model.
- Minimize customer interaction during service completion.
- Allow business policies to be configurable through the Admin Portal whenever practical.
- Maintain operational flexibility while keeping customer experience simple.

---

# Business Objectives

The business aims to:

1. Digitize local vehicle washing services.

2. Build a marketplace with low operational overhead.

3. Standardize pricing across supported regions.

4. Improve washer utilization.

5. Maximize successful booking completion.

6. Reduce booking cancellations.

7. Provide transparent refund handling.

8. Maintain high customer satisfaction.

9. Provide sustainable earnings for washers.

10. Create an operational model that can later support subscriptions, recurring services, detailing, fleet servicing, apartment societies, and corporate customers.

---

# Target Market

Initial Launch Region:

India

Future expansion into additional cities will occur after operational validation.

The platform is designed primarily for urban and semi-urban customers who prefer scheduled doorstep vehicle washing.

---

# Stakeholders

## Platform Owner

Responsible for:

- Business decisions
- Pricing policies
- Platform growth
- Operational management
- Financial management

---

## Customer

A customer is an individual booking vehicle washing services through the platform.

Customers own one or more vehicles and may save multiple service locations.

Customers interact only with the mobile application.

---

## Washer

A washer is an independently verified service provider registered on the platform.

Washers are responsible for:

- Maintaining availability
- Accepting bookings
- Performing washes
- Uploading completion evidence
- Maintaining service quality

Washers do not determine customer pricing.

---

## Platform Administrator

Administrators manage operational aspects of the platform including:

- Washer approval
- KYC verification
- Pricing
- Service areas
- Refunds
- Disputes
- Platform configuration
- Weekly payouts
- Capacity limits
- Operational monitoring

---

# Business Model

The platform operates as a managed marketplace.

Customers purchase vehicle washing services from the platform.

The platform is responsible for:

- Pricing
- Booking assignment
- Payment collection
- Refund handling
- Customer support
- Dispute resolution

Verified washers perform the physical washing service on behalf of the platform.

Washers receive weekly payouts according to completed bookings after the applicable dispute window has elapsed.

---

# Revenue Model

Revenue is generated through platform-controlled pricing.

The customer pays the displayed service price at the time of booking.

Platform earnings are derived from the difference between customer charges and washer payouts, along with any configurable platform fees.

The platform retains complete control over pricing strategy.

Washers cannot independently modify customer-facing prices.

---

# Service Model

The platform provides doorstep vehicle washing services.

Customers select:

- Vehicle(s)
- Service location
- Booking date
- Available time slot

The assigned washer travels to the selected location and performs the wash.

The customer is not required to visit any physical location.

---

# Marketplace Model

The platform follows a first-accept assignment model.

Only eligible washers receive booking requests.

Eligibility depends upon:

- Approved account
- Active status
- Availability
- Service area coverage
- Booking capacity
- Supported vehicle categories

The first eligible washer who accepts the booking becomes responsible for fulfilling it.

---

# Core Principles

The following principles govern all future product decisions.

## Customer First

The customer experience must remain simple.

Operational complexity should remain hidden behind the platform wherever possible.

---

## Platform Controlled

Critical business decisions remain under platform control.

Examples include:

- Pricing
- Refund rules
- Capacity limits
- Time slots
- Service availability
- Dispute resolution

---

## Trust Over Speed

Whenever business convenience conflicts with customer trust, customer trust takes priority.

Examples include:

- Verified washer onboarding
- Evidence-based completion
- Manual dispute review
- Transparent refunds

---

## Operational Simplicity

The MVP intentionally avoids unnecessary complexity.

Features not essential for launch are deferred.

Examples include:

- Wallet system
- Dynamic pricing
- Customer-selected washers
- Subscription plans
- AI scheduling
- Loyalty programs

---

## Configurable Platform

Business rules should be configurable through the Admin Portal whenever practical.

Examples include:

- Platform fees
- Capacity limits
- Time slots
- Distance slabs
- Refund percentages
- Travel compensation
- Dispute window
- Vehicle pricing

This minimizes future software changes for operational policy updates.

---

# MVP Scope

The initial release includes:

- Customer mobile application
- Washer mobile application
- Administrative web portal
- Online payments
- Doorstep washing
- Booking scheduling
- Time slot management
- Area-based service availability
- KYC verification
- Weekly washer payouts
- Photo-based completion proof
- Customer ratings
- Washer ratings
- Refund management
- Dispute management
- Push notifications

---

# Out of Scope (MVP)

The following features are intentionally excluded from the initial release:

- Customer wallet
- Referral program
- Subscription plans
- Recurring bookings
- Customer-selected washers
- Live washer tracking
- Dynamic surge pricing
- Interior detailing
- Add-on marketplace
- AI route optimization
- Corporate fleet management
- Apartment society management
- Loyalty rewards
- Instant payouts
- Cash payments
- Multi-country support

These features may be introduced in future platform versions after successful validation of the MVP.

---

# Assumptions

The following assumptions are considered true throughout this document unless explicitly revised.

- Customers possess smartphones with internet connectivity.
- Washers possess smartphones with internet connectivity.
- Customers provide an accessible vehicle location.
- Washers bring the required washing equipment.
- Customers complete payment before service assignment.
- Every washer undergoes manual platform approval.
- Service is available only within configured operational areas.
- All pricing displayed to customers is tax-inclusive during the MVP.
- Weekly payouts are processed only after dispute eligibility has expired.
- Every completed wash requires photographic evidence.
- Platform administrators retain final authority in operational disputes.

---

# Guiding Philosophy

The platform prioritizes operational reliability over feature richness.

Business decisions should consistently favour:

- Simplicity over unnecessary complexity.
- Customer trust over operational shortcuts.
- Administrative configurability over hardcoded behaviour.
- Scalable policies over one-off exceptions.
- Long-term maintainability over rapid feature accumulation.

These principles shall guide all future product and engineering decisions throughout the lifecycle of the platform.

---

# User Roles and Responsibilities

The platform consists of three primary user roles:

1. Customer
2. Washer
3. Platform Administrator

Each role has distinct responsibilities, permissions, limitations, and operational expectations. Every workflow throughout the platform is governed by the permissions associated with these roles.

---

# Customer

## Overview

A Customer is an individual who books vehicle washing services through the platform.

Customers interact only with the Customer Mobile Application and do not directly interact with internal platform operations.

The platform is responsible for managing all operational complexity on behalf of the customer.

---

# Customer Objectives

Customers use the platform to:

- Register an account.
- Maintain personal information.
- Save one or more vehicles.
- Save one or more service locations.
- Book vehicle washing services.
- Make online payments.
- Track booking status.
- Receive booking notifications.
- Raise disputes if necessary.
- Rate completed services.

---

# Customer Responsibilities

Customers are responsible for:

- Providing accurate personal information.
- Maintaining valid contact details.
- Keeping saved vehicle information accurate.
- Providing an accessible vehicle location.
- Ensuring the selected vehicle is available during the booked slot.
- Making payment before booking confirmation.
- Responding when necessary if the washer is unable to locate the vehicle.
- Raising disputes only when genuine service issues exist.

---

# Customer Permissions

Customers may:

- Register.
- Login.
- Edit profile.
- Add multiple vehicles.
- Add multiple addresses.
- Select service location.
- Create bookings.
- Cancel bookings according to platform policy.
- View booking history.
- View invoices.
- View payment history.
- Raise disputes.
- Rate completed bookings.

---

# Customer Restrictions

Customers cannot:

- Modify completed bookings.
- Edit bookings after wash has started.
- Directly negotiate pricing with washers.
- Contact washers before booking assignment.
- Choose a specific washer.
- View internal Silent Reassignment.
- Modify platform pricing.
- Modify booking status.
- Override dispute decisions.

---

# Customer Expectations

The platform guarantees:

- Transparent pricing.
- Verified washers.
- Timely booking updates.
- Secure online payment.
- Fair dispute handling.
- Refunds according to platform policy.

The platform does not guarantee:

- A specific washer.
- Exact wash start time within the selected slot.
- Immediate refunds for disputed services.

---

# Customer Business Rules

## Profile

A customer account must contain:

- Full Name
- Mobile Number
- Email Address (optional/configurable)
- Account Status

---

## Vehicles

A customer may save multiple vehicles.

Each vehicle belongs to exactly one customer.

A vehicle may participate in multiple bookings throughout its lifetime.

Vehicle information must remain editable unless currently involved in an active booking.

---

## Addresses

Customers may save multiple addresses.

Each address contains:

- Address Label
- Complete Address
- Landmark
- Geographic Location
- Optional Access Notes

The exact service location is selected during booking.

---

## Booking

Customers may create bookings only if:

- Service exists in their location.
- At least one washer is available.
- Payment succeeds.
- Selected slot remains available.

---

## Cancellation

Customers may cancel bookings according to the platform cancellation policy.

Refund eligibility depends upon:

- Booking state.
- Time of cancellation.
- Washer status.
- Wash progress.

---

## Ratings

Customers may rate completed bookings only once.

Ratings become permanent after submission.

Customers cannot modify ratings after submission.

---

## Disputes

Customers may raise disputes only within the configured dispute window.

After the dispute window expires, bookings become final.

---

# Washer

## Overview

A Washer is an independent service provider approved by the platform to perform vehicle washing services.

Washers operate using the Washer Mobile Application.

Washers are service partners of the platform and must comply with all operational policies defined by the platform.

---

# Washer Objectives

Washers use the platform to:

- Receive booking opportunities.
- Accept eligible bookings.
- Perform vehicle washes.
- Submit completion proof.
- Receive weekly payouts.
- Build a positive service history.

---

# Washer Responsibilities

Washers are responsible for:

- Completing platform verification.
- Maintaining accurate profile information.
- Defining service areas.
- Maintaining availability.
- Accepting only manageable workloads.
- Arriving within booked slot.
- Performing quality service.
- Uploading required completion evidence.
- Behaving professionally.
- Protecting customer property.

---

# Washer Permissions

Approved washers may:

- Login.
- Edit profile.
- Configure availability.
- Configure service area.
- Accept bookings.
- Cancel accepted bookings before wash starts.
- Mark travel progress.
- Start wash.
- Upload completion evidence.
- Mark booking completed.
- View earnings.
- View payout history.

---

# Washer Restrictions

Washers cannot:

- Accept bookings before approval.
- Modify customer pricing.
- Edit completed bookings.
- Cancel bookings after wash has started without administrative approval.
- Access bookings outside their configured service area.
- View bookings after reaching configured booking capacity.
- View internal administrative information.
- Access customer payment information.

---

# Washer Verification

Before receiving bookings, every washer must complete platform verification.

Verification includes:

- Mobile number verification.
- Identity verification.
- Selfie verification.
- Address verification.
- Manual administrative review.

Only approved washers become eligible to receive bookings.

---

# Service Area

Every washer defines operational coverage.

Coverage determines:

- Eligible bookings.
- Customer visibility.
- Service assignment.

Bookings outside the configured service area are never shown.

---

# Availability

Washers configure availability for future dates.

Availability is managed using predefined platform time slots.

Unavailable slots never receive booking requests.

---

## Booking Capacity

Each washer is assigned a maximum capacity of simultaneous bookings per time slot by the platform administrators (detailed in Business Processes).

---

# Booking Acceptance

Eligible bookings become visible to available washers.

The first washer who successfully accepts the booking becomes assigned.

Assignment is exclusive.

Once assigned, the booking is removed from all other eligible washers.

---

## On The Way

Washers must indicate when they are travelling to the customer. This triggers specific cancellation and compensation rules defined in the Financial Policies.

---

# Wash Started

Washers must explicitly indicate when washing begins.

This action changes the booking into an active service state.

Once washing has started:

- Customer cancellation refunds no longer apply.
- Washer cancellation is no longer permitted without administrative intervention.

---

# Completion Evidence

Every completed wash requires evidence.

Required evidence includes:

- Before photograph.
- After photograph.
- GPS location.
- Timestamp.

Additional evidence may be introduced in future platform versions.

---

# Booking Completion

After completing the service, the washer submits completion evidence and marks the booking as completed.

Customers receive a notification informing them that service has been completed.

Customers may raise disputes during the configured dispute window.

---

# Earnings

Washers earn according to completed bookings.

Completed earnings remain pending until:

- Dispute window expires.
- No active dispute exists.

Eligible earnings are paid according to the weekly payout schedule.

---

# Washer Business Rules

Repeated operational violations may result in:

- Temporary suspension.
- Reduced booking capacity.
- Administrative warnings.
- Permanent removal from the platform.

Violations include:

- Excessive cancellations.
- Fraudulent completion.
- Poor customer ratings.
- Repeated disputes.
- Unprofessional behaviour.
- Policy violations.

---

# Platform Administrator

## Overview

The Platform Administrator manages the operational health of the marketplace.

Administrators possess the highest operational authority.

Administrative decisions override automated platform behaviour whenever required.

---

# Administrator Objectives

Administrators ensure:

- Platform reliability.
- Service quality.
- Fraud prevention.
- Fair dispute resolution.
- Operational efficiency.
- Marketplace growth.

---

# Administrative Responsibilities

Administrators manage:

- Customer accounts.
- Washer accounts.
- KYC verification.
- Pricing.
- Platform fees.
- Vehicle pricing.
- Booking capacities.
- Service areas.
- Time slots.
- Refunds.
- Disputes.
- Weekly payouts.
- Operational monitoring.
- Notification policies.
- Business configurations.

---

# Administrative Permissions

Administrators may:

- Approve or reject washer applications.
- Suspend accounts.
- Modify booking capacities.
- Configure pricing.
- Configure travel compensation.
- Configure dispute duration.
- Configure cancellation policies.
- Modify time slots.
- Issue refunds.
- Issue partial refunds.
- Hold payouts.
- Release payouts.
- Cancel bookings.
- Override automated decisions where necessary.

---

# Administrative Restrictions

Administrative actions must be logged for auditing purposes.

Critical financial operations should require appropriate authorization according to future internal operational policies.

---

# Administrative Philosophy

Administrative intervention should remain the exception rather than the default.

The platform should automate routine operational decisions wherever possible while allowing administrators to intervene during exceptional circumstances requiring human judgment.

---

# Business Processes and End-to-End Workflows

This section defines the complete operational lifecycle of the platform.

Every booking, payment, cancellation, dispute, refund, and payout must follow the business processes defined below.

These workflows represent the expected business behaviour of the platform and serve as the foundation for future technical implementation.

---

# Customer Registration Process

## Objective

Allow new customers to create an account and access platform services.

---

## Registration Flow

1. Customer installs the mobile application.

2. Customer enters mobile number.

3. OTP verification is completed.

4. Customer enters required profile information.

5. Customer account is created.

6. Customer becomes eligible to use platform services.

---

## Mandatory Information

A customer account shall contain:

- Full Name
- Mobile Number
- Email Address (optional/configurable)
- Profile Photo (optional)
- Account Status
- Registration Date

---

## Business Rules

- One mobile number can be associated with only one customer account.
- Mobile verification is mandatory.
- Suspended customers cannot create bookings.
- Deleted accounts cannot be recovered without administrative intervention.

---

# Customer Vehicle Management

Customers may register multiple vehicles.

Each vehicle shall contain:

- Vehicle Type
- Vehicle Number
- Nickname (optional)
- Default Vehicle Flag

---

## Supported Vehicle Categories (MVP)

- Two Wheeler
- Four Wheeler

Future vehicle categories may be added without affecting existing customers.

---

## Business Rules

- A customer may own multiple vehicles.
- One booking may contain one or more vehicles.
- Vehicle details remain editable unless the vehicle is involved in an active booking.

---

# Customer Address Management

Customers may maintain multiple service addresses.

Each address contains:

- Address Label
- Complete Address
- Geographic Coordinates
- Landmark
- Additional Notes (optional)

Examples:

- Home
- Office
- Society Parking

---

## Business Rules

- Multiple addresses are supported.
- One address is selected during booking.
- Address information remains editable unless currently used in an active booking.

---

# Washer Registration Process

## Objective

Allow service providers to join the platform after verification.

---

## Registration Workflow

1. Washer installs application.

2. Mobile number verification.

3. Profile information submission.

4. Identity document submission.

5. Selfie submission.

6. Home base selection.

7. Service area configuration.

8. Administrative review.

9. Approval or rejection.

---

## Required Information

Every washer profile shall contain:

- Full Name
- Mobile Number
- Identity Document
- Selfie
- Home Base Location
- Service Area
- Availability
- Account Status

---

## Verification States

A washer account may exist in one of the following states:

- Pending Verification
- Under Review
- Approved
- Rejected
- Suspended
- Inactive

Only Approved washers may receive bookings.

---

## Rejection

Rejected washers may resubmit corrected information.

Approval remains entirely under platform control.

---

# Availability Management

Washers define future availability.

Availability is managed using platform-defined time slots.

Example:

Monday

✓ 9 AM – 12 PM

✓ 12 PM – 3 PM

✗ 3 PM – 6 PM

Availability may be configured up to 30 days in advance.

---

## Business Rules

- Only available slots receive bookings.
- Unavailable slots never receive booking requests.
- Availability changes do not affect already accepted bookings.

---

# Service Area Configuration

Every washer must define operational coverage.

Coverage determines where bookings may be accepted.

The platform supports configurable service areas.

Examples include:

- Polygon-based areas.
- Radius-based areas.

Polygon coverage is preferred because it allows exclusion of inaccessible or operationally inefficient locations.

---

## Business Rules

- Customers outside a washer's service area are invisible to that washer.
- Administrators may modify service areas when required.
- Washers may update service areas subject to future operational policies.

---

# Booking Creation Process

## Objective

Allow customers to schedule a vehicle wash.

---

## Booking Workflow

1. Customer selects vehicle(s).

2. Customer selects service location.

3. Customer selects date.

4. Customer selects available time slot.

5. Platform calculates final price.

6. Customer completes payment.

7. Booking is created.

8. Eligible washers receive booking request.

---

## Booking Preconditions

Bookings may only be created if:

- Customer account is active.
- Selected address is serviceable.
- Selected slot is available.
- Payment succeeds.
- At least one eligible washer exists.

---

## Booking Confirmation

A booking is considered successfully created only after successful payment.

Failed payments do not create bookings.

---

# Booking Assignment

The platform identifies eligible washers.

Eligibility depends upon:

- Approved account.
- Active status.
- Availability.
- Service area.
- Remaining booking capacity.
- Supported vehicle category.

Eligible washers receive the booking request.

The first washer who accepts becomes assigned.

The booking immediately disappears from all remaining washers.

---

# Booking Capacity

Each washer has an administrator-configurable booking capacity.

Booking capacity represents the maximum number of bookings a washer may hold within a particular time slot.

The capacity value is managed exclusively through the Admin Portal.

Washers cannot modify this value.

---

## Business Rules

- Booking requests are not shown after capacity is reached.
- Administrators may increase or decrease capacity at any time.
- Capacity changes affect future booking assignments only.

---

# Booking Lifecycle

A booking progresses through the following states.

Draft

↓

Payment Pending

↓

Confirmed

↓

Awaiting Acceptance

↓

Accepted

↓

On The Way

↓

Wash Started

↓

Completed

↓

Dispute Window

↓

Closed

If cancelled, the booking exits this flow according to the applicable cancellation policy.

---

# On The Way

After accepting a booking, the washer may indicate that travel has begun.

This status is used for:

- Operational visibility.
- Customer communication.
- Cancellation policy.
- Travel compensation eligibility.

---

## Business Rules

- On The Way does not indicate service has started.
- Customer cancellation remains possible.
- Travel compensation may apply if cancellation occurs after this point.

---

# Wash Started

The washer explicitly begins the service.

This represents the official start of service execution.

---

## Business Rules

Once Wash Started is recorded:

- Customer cancellation no longer qualifies for refund.
- Washer cancellation is prohibited except through administrative intervention.
- Service is considered operationally active.

---

# Service Execution

The washer performs the vehicle wash according to platform quality standards.

Operational details remain hidden from customers.

Customers are expected to receive completed service before the booked slot concludes.

Internal operational changes, including Silent Reassignment if required before wash commencement, remain platform-managed.

---

# Completion Workflow

Upon finishing the wash:

1. Capture Before Photo (already taken before wash).
2. Capture After Photo.
3. Record GPS location.
4. Record timestamp.
5. Submit completion.
6. Customer receives completion notification.

---

## Mandatory Evidence

Each completed booking requires:

- Before Photograph
- After Photograph
- GPS Location
- Timestamp

Completion without mandatory evidence is not permitted.

---

# Silent Completion

Customers are not required to approve service completion.

Instead, the platform follows a silent completion model.

Customer receives a notification:

"Your vehicle wash has been completed."

Customers may raise issues during the configured dispute window.

If no dispute is raised, the booking automatically becomes final.

---

# Dispute Window

Every completed booking enters a temporary dispute period.

During this period:

- Customer may report issues.
- Washer payout remains pending.
- Administrative review may occur if required.

After expiry:

- Booking becomes final.
- Washer earnings become payout eligible.

The dispute duration is configurable by the platform.

The MVP default is 6–12 hours.

---

# Weekly Payout Eligibility

A booking becomes eligible for payout only after:

- Successful completion.
- No active dispute.
- Dispute window expires.

Eligible earnings are included in the next scheduled weekly payout cycle.

---

# Booking History

Customers and washers retain permanent access to historical bookings.

Historical records remain available for:

- Reference.
- Disputes.
- Financial reporting.
- Customer support.
- Administrative investigation.

---

# Pricing, Payments, Cancellation, Refunds & Financial Policies

This section defines all financial business rules governing pricing, payment collection, cancellations, refunds, disputes, travel compensation, and washer payouts.

Every monetary transaction on the platform must comply with these policies unless formally revised.

---

# Pricing Model

## Pricing Philosophy

The platform follows a **platform-controlled pricing model**.

Customers are charged a standardized price determined by the platform.

Washers are not permitted to set, negotiate, or modify customer-facing prices.

This ensures:

- Consistent customer experience
- Fair pricing
- Easier marketing
- Simpler dispute handling
- Better operational control

---

## Pricing Factors

The final booking price may be calculated using one or more of the following configurable factors:

- Vehicle category
- Number of vehicles
- Distance between washer home base and customer location
- Platform service fee
- Applicable taxes
- Promotional discounts (future)
- Coupons (future)

The exact pricing formula remains configurable through the Admin Portal.

---

## Distance Calculation

Distance shall be calculated from:

**Washer Home Base**

↓

**Customer Service Location**

The calculated distance may influence:

- Washer payout
- Customer pricing
- Future travel compensation

---

## Vehicle Categories (MVP)

The MVP supports only:

- Two Wheeler
- Four Wheeler

Future vehicle categories shall be configurable without redesigning the pricing engine.

---

## Add-on Services

Add-on services are intentionally excluded from the MVP.

Examples include:

- Interior Cleaning
- Wax Polish
- Foam Wash
- Premium Detailing

These may be introduced in future releases.

---

# Payment Policy

## Payment Timing

Customers must complete payment before a booking is created.

No booking shall exist without successful payment.

---

## Supported Payment Methods

The payment gateway shall support digital payment methods including:

- UPI
- Credit Card
- Debit Card
- Net Banking
- Digital Wallets supported by the payment gateway

Cash payments are not supported during the MVP.

---

## Payment Gateway

The platform integrates with a payment gateway for payment processing.

Responsibilities include:

- Payment collection
- Payment confirmation
- Payment failure notifications
- Refund processing

---

## Payment Failure

If payment fails:

- Booking is not created.
- Washer is never notified.
- Customer may retry payment.

---

# Revenue Recognition

Customer payment is collected upfront.

The collected amount remains associated with the booking until:

- Service completion
- Dispute resolution (if any)
- Washer payout eligibility

Platform earnings are derived from the configured pricing model.

Detailed accounting implementation is outside the scope of this document.

---

# Washer Payout Policy

Washers receive earnings through scheduled weekly payouts.

Immediate payouts are not supported.

---

## Payout Eligibility

A completed booking becomes eligible for payout only if:

- Wash completed successfully.
- Mandatory evidence submitted.
- No active dispute exists.
- Dispute window has expired.

Only eligible bookings participate in the weekly payout cycle.

---

## Weekly Payout Schedule

The exact payout day is configurable through the Admin Portal.

Examples:

- Every Monday
- Every Friday

The schedule may change without requiring application updates.

---

# Tax Handling

## MVP Tax Policy

During the MVP:

Customers shall see a **tax-inclusive final price**.

Example:

Vehicle Wash

₹299 (Inclusive of all applicable taxes)

The pricing breakdown shown to customers remains intentionally simple.

---

## Future GST Support

Future platform versions may include:

- GST invoices
- GST number collection
- Business invoices
- Detailed tax breakdown
- Downloadable invoices

These features are outside the MVP scope.

---

# Cancellation Policy

Cancellation policies depend upon the current booking state.

Different rules apply to customers, washers, and the platform.

---

# Customer Cancellation

## Before Washer Acceptance

Customers may cancel freely.

Result:

- Full refund.

---

## After Washer Acceptance

Cancellation depends on washer activity.

---

### Washer has NOT marked "On The Way"

Result:

- Full refund.

---

### Washer marked "On The Way"

Result:

- Full refund

minus

Admin-configurable travel compensation payable to the washer.

This compensates genuine travel effort while remaining fair to customers.

---

### Wash Started

Result:

No refund.

Once washing begins, the service is considered operationally active.

---

# Washer Cancellation

Washers may cancel accepted bookings only before Wash Started.

After Wash Started, washer cancellation is prohibited except through administrative intervention.

---

## Silent Reassignment

If a washer cancels before Wash Started:

- Booking returns to the assignment pool.
- Eligible replacement washers receive the booking request.
- This process remains entirely hidden from the customer (Silent Reassignment).

---

## Replacement Failure

If no replacement washer accepts the booking before the booked slot ends:

- Booking automatically fails.
- Customer receives full refund.
- Washer receives no payout.

---

# Excessive Washer Cancellation

Repeated cancellation after booking acceptance negatively impacts washer reliability.

Administrative actions may include:

- Warning
- Temporary suspension
- Reduced booking capacity
- One-day suspension
- Permanent removal for repeated abuse

The exact thresholds remain configurable by administrators.

---

# Platform Cancellation

The platform may cancel bookings under exceptional circumstances.

Examples include:

- Severe weather
- Public safety concerns
- Government restrictions
- Technical outages
- Fraud detection
- Operational emergencies

---

## Platform Cancellation Outcome

Customer:

- Full refund.

Washer:

- No penalty.

Platform:

- Records cancellation reason.

---

# Customer Unreachable Policy

The platform recognises that genuine situations may occur where:

- Customer cannot be contacted.
- Vehicle cannot be located.
- Vehicle is inaccessible.

---

## Washer Responsibilities

Before reporting Customer Unreachable, the washer must:

- Reach the booking location.
- Attempt customer contact.
- Wait the configured waiting period.
- Capture GPS location.
- Capture surrounding vehicle-area photograph.
- Record communication attempts.

---

## Waiting Period

The default waiting period shall be 15 minutes.

Administrators may modify this value in future.

---

## Booking State

After evidence submission:

Booking enters:

Customer Unreachable

↓

Dispute

↓

Administrative Review

---

## Administrative Decision

The administrator may decide:

- Full refund.
- Partial refund.
- No refund.
- Partial washer compensation.
- Full washer compensation.

The decision depends upon available evidence.

---

# Force Majeure

Force Majeure represents circumstances beyond the control of any participant.

Examples:

- Flood
- Earthquake
- Riot
- Curfew
- Government restrictions
- Severe weather
- Natural disaster

---

## Force Majeure Outcome

Booking may be cancelled by the platform.

Customer:

Full refund.

Washer:

No penalty.

Platform:

Records cancellation reason.

---

# Refund Policy

Refund eligibility depends entirely upon booking state.

The platform shall not process refunds outside the defined business rules except through administrative override.

---

# Refund Matrix

| Booking State | Refund |
|---------------|--------|
| Payment Failed | No charge |
| Before Washer Acceptance | Full refund |
| Accepted (Not On The Way) | Full refund |
| On The Way | Full refund minus travel compensation |
| Wash Started | No refund |
| Platform Cancellation | Full refund |
| Replacement Not Found | Full refund |
| Customer Unreachable | Admin Decision |
| Successful Completion | No refund unless dispute approved |

---

# Travel Compensation

Travel compensation exists to fairly compensate washers who have already begun travelling toward the customer.

Travel compensation:

- Is configurable by administrators.
- Applies only when the washer has marked "On The Way."
- Is deducted from the customer refund.
- Is not applicable after Wash Started because normal refund rules no longer apply.

---

# Administrative Override

Administrators retain authority to override financial decisions in exceptional situations.

Examples include:

- Verified fraud
- Technical payment errors
- Duplicate payments
- Platform malfunction
- Exceptional customer service cases

Every override shall be logged for future auditing.

---

# Financial Principles

The platform follows the following financial principles:

- Customers always pay before booking confirmation.
- Pricing is controlled exclusively by the platform.
- Washers never determine customer pricing.
- Refund rules depend on booking state.
- Washer payouts occur weekly.
- Earnings remain pending during the dispute window.
- Administrative overrides are exceptional and auditable.
- Financial rules should remain configurable wherever operationally practical.

---

# Notifications, Disputes, Ratings, Fraud Prevention & Operational Policies

This section defines how the platform communicates with users, manages disputes, maintains trust, prevents fraud, and measures operational performance.

These policies ensure a consistent customer experience while protecting both customers and washers from misuse of the platform.

---

# Notification Policy

## Objective

The platform shall proactively notify users whenever a significant booking event occurs.

Notifications reduce uncertainty while eliminating unnecessary customer involvement in internal operational activities.

The platform shall use push notifications as the primary communication channel.

SMS and Email may be introduced in future versions where appropriate.

---

# Customer Notifications

Customers shall receive notifications for the following events:

## Account

- Registration successful
- Profile verification (future)

---

## Booking

- Booking confirmed
- Payment successful
- Booking accepted
- Washer is on the way
- Wash completed
- Booking cancelled
- Booking refunded
- Dispute received
- Dispute resolved

---

## Financial

- Refund initiated
- Refund completed
- Invoice available (future)

---

## Promotional (Future)

- Offers
- Coupons
- Referral rewards
- Subscription reminders

---

# Washer Notifications

Washers shall receive notifications for:

- New booking request
- Booking assigned
- Booking cancelled
- Booking reassigned
- Customer unreachable response
- Dispute raised
- Dispute resolved
- Weekly payout processed
- Administrative warning
- Capacity modification
- Account suspension
- Account approval

---

# Administrator Notifications

Administrators may receive operational alerts including:

- New washer registration
- Pending KYC approval
- High dispute volume
- Payment failures
- Failed payout batches
- Fraud alerts
- Customer escalation
- System failures

---

# Notification Principles

Notifications should:

- Be concise.
- Avoid exposing internal platform operations.
- Avoid revealing unnecessary washer information.
- Keep customers informed without overwhelming them.

---

# Dispute Management

## Objective

Disputes provide customers with a structured mechanism to report genuine service issues after booking completion.

Disputes are intended to resolve exceptional situations and are not part of the normal booking workflow.

---

# Dispute Eligibility

Customers may raise disputes only during the configured dispute window.

After the dispute window expires:

- Booking becomes final.
- Washer payout becomes eligible.
- Customer may no longer raise new disputes.

---

# Valid Dispute Examples

Examples include:

- Poor wash quality.
- Wrong vehicle washed.
- Vehicle not washed.
- Property damage.
- Incomplete service.
- Washer misconduct.

---

# Invalid Disputes

Examples include:

- Customer changed their mind after completion.
- Dispute raised after dispute window expiry.
- Requests unrelated to completed service.
- Pricing complaints after payment confirmation.

---

# Evidence

Administrative review may consider:

Customer evidence:

- Photos
- Videos
- Written explanation

Washer evidence:

- Before photo
- After photo
- GPS location
- Timestamp
- Customer unreachable evidence (if applicable)

---

# Administrative Decisions

After reviewing evidence, administrators may choose one of the following outcomes:

- Booking approved.
- Partial refund.
- Full refund.
- Partial washer payout.
- Full washer payout.
- Booking marked as fraudulent.
- Warning issued.
- Suspension initiated.

Administrative decisions are final.

---

# Rating System

The platform maintains independent rating systems for customers and washers.

Ratings help maintain marketplace quality.

---

# Customer Rating of Washer

Customers may rate completed bookings.

Each completed booking may receive one rating.

Ratings become permanent after submission.

Customers cannot edit ratings after submission.

---

# Rating Scale

The platform uses a five-star rating system.

Customers may optionally provide written feedback.

---

# Washer Rating Visibility

Customers may view:

- Average rating.
- Total completed washes.
- Platform verification badge.

Customers shall not view:

- Cancellation history.
- Internal trust score.
- Administrative warnings.
- Internal operational metrics.

---

# Hidden Trust Score

The platform maintains an internal trust score for each washer.

The trust score is not visible to customers.

Factors influencing trust score may include:

- Average rating.
- Booking completion rate.
- Cancellation frequency.
- Disputes.
- Administrative actions.
- Platform experience.

The trust score may influence future operational decisions.

---

# Customer Reputation

Washers do not publicly rate customers.

Instead, the platform maintains a private customer reliability profile.

Factors may include:

- Excessive cancellations.
- Fraud attempts.
- Customer unreachable incidents.
- Repeated disputes.
- Policy violations.

This information remains internal.

---

# Customer Abuse

Customers repeatedly abusing the platform may receive:

- Warning.
- Temporary booking restriction.
- Account suspension.
- Permanent account removal.

Examples include:

- Fraudulent disputes.
- Repeated fake bookings.
- Harassment.
- Payment abuse.
- Repeated customer unreachable incidents.

---

# Washer Abuse

Washers repeatedly violating platform policies may receive:

- Warning.
- Capacity reduction.
- Temporary suspension.
- Permanent removal.

Examples include:

- Fake completion.
- Fraudulent evidence.
- Repeated cancellations.
- Poor quality.
- Customer misconduct.
- Identity sharing.

---

# Fraud Prevention

## Platform Philosophy

Fraud prevention is proactive rather than reactive.

Business processes should discourage fraudulent behaviour before it occurs.

---

# Customer Fraud Examples

Examples include:

- Fake bookings.
- False disputes.
- Intentional cancellation abuse.
- Fake damage claims.
- Payment abuse.

---

# Washer Fraud Examples

Examples include:

- Fake completion.
- Uploading old photographs.
- GPS spoofing.
- Identity misuse.
- Fake customer unreachable reports.
- Accepting bookings without intention to complete them.

---

# Fraud Detection

Potential fraud indicators include:

- High cancellation frequency.
- Repeated disputes.
- Abnormal completion behaviour.
- Duplicate photographic evidence.
- Suspicious GPS patterns.
- Repeated administrative intervention.

The platform may introduce automated fraud detection in future releases.

---

# Administrative Policies

Administrators retain operational authority over the marketplace.

Administrative decisions may override automated workflows when required.

Administrative actions include:

- User suspension.
- Account approval.
- Booking cancellation.
- Refund approval.
- Partial refunds.
- Capacity changes.
- Pricing updates.
- Service area updates.
- Operational announcements.

Critical actions should be logged for auditing purposes.

---

# Operational Policies

The platform follows the following operational principles:

- Customers interact with the platform, not individual washer operations.
- Silent Reassignment remains hidden from customers.
- Business rules should be configurable wherever practical.
- Operational consistency is prioritised over manual exceptions.
- Every completed booking should have sufficient evidence for future review.

---

# Analytics & Key Performance Indicators

The platform should monitor operational performance through business metrics.

Important KPIs include:

## Customer Metrics

- Total Customers
- Active Customers
- New Registrations
- Repeat Customers
- Booking Frequency
- Customer Satisfaction

---

## Washer Metrics

- Approved Washers
- Active Washers
- Completion Rate
- Cancellation Rate
- Average Rating
- Weekly Earnings

---

## Booking Metrics

- Total Bookings
- Completed Bookings
- Cancelled Bookings
- Refund Rate
- Dispute Rate
- Average Booking Value

---

## Financial Metrics

- Gross Revenue
- Platform Earnings
- Weekly Payouts
- Refund Amount
- Tax Collected

---

## Operational Metrics

- Average Acceptance Time
- Average Wash Completion Time
- Average Dispute Resolution Time
- Customer Response Time
- Washer Utilisation

---

# Future Expansion

The architecture and business policies should support future expansion without requiring major redesign.

Potential future capabilities include:

- Subscription Plans
- Recurring Bookings
- Interior Cleaning
- Premium Detailing
- Add-on Services
- Fleet Management
- Corporate Customers
- Apartment Society Management
- Customer Wallet
- Referral Program
- Loyalty Rewards
- Dynamic Pricing
- AI-Based Assignment
- Route Optimisation
- Live Washer Tracking
- GST Invoicing
- Multi-City Expansion
- Multi-Language Support

These features are intentionally excluded from the MVP and shall be evaluated based on business growth.

---

# Business Requirement Summary

The platform shall operate according to the following principles:

- Customers always pay before booking confirmation.
- Pricing is fully controlled by the platform.
- Only verified washers may perform services.
- Internal operational changes remain hidden from customers.
- Every completed wash requires photographic evidence.
- Customers may raise disputes only within the configured dispute window.
- Weekly payouts occur only after dispute eligibility has expired.
- Administrative decisions are authoritative in exceptional situations.
- Business policies should remain configurable wherever operationally practical.
- The MVP prioritises simplicity, trust, operational reliability, and scalability over feature richness.

---

# BRD Approval

This Business Requirements Document represents the approved business behaviour of the Mobile Vehicle Wash Marketplace Platform.

Any future feature, workflow, or implementation shall comply with the policies and business rules defined within this document unless formally revised through version control.

This document serves as the authoritative business reference for all future software design, architecture, implementation, testing, and operational planning.
