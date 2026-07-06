# API Specification Document

## Version

1.0

---

# Purpose

This document defines the complete REST API contract for the Mobile Vehicle Wash Marketplace Platform.

It specifies:

- API endpoints
- HTTP methods
- Authentication requirements
- Request bodies
- Response bodies
- Validation rules
- Error responses
- Status codes
- Pagination
- Versioning

This document serves as the single source of truth between the Backend, Customer App, Washer App, and Admin Portal.

---

# Base URL

Development

```
http://localhost:8080/api/v1
```

Production

```
https://api.yourdomain.com/api/v1
```

---

# API Design Principles

The API follows REST principles.

- Stateless
- Resource-oriented
- JSON only
- UTF-8 encoding
- HTTPS only (Production)

---

# Standard Success Response

```json
{
  "success": true,
  "data": {},
  "timestamp": "2026-07-10T10:00:00Z",
  "requestId": "a5d2b4..."
}
```

---

# Standard Error Response

```json
{
  "success": false,
  "error": {
    "code": "BOOKING_NOT_FOUND",
    "message": "Booking does not exist."
  },
  "timestamp": "2026-07-10T10:00:00Z",
  "requestId": "a5d2b4..."
}
```

---

# Authentication

The platform uses

- JWT Access Token
- Refresh Token

Every authenticated request must include

```
Authorization: Bearer <JWT>
```

---

# Roles

```
CUSTOMER

WASHER

ADMIN

SUPER_ADMIN
```

Every endpoint explicitly defines allowed roles.

---

# HTTP Status Codes

| Code | Meaning |
|------|----------|
|200|Success|
|201|Created|
|204|No Content|
|400|Validation Error|
|401|Unauthorized|
|403|Forbidden|
|404|Not Found|
|409|Conflict|
|422|Business Rule Violation|
|429|Rate Limited|
|500|Internal Server Error|

---

# Pagination

List endpoints accept

```
?page=0

&size=20

&sort=createdAt,desc
```

---

# Module 1 — Authentication

Authentication uses OTP-based login.

No passwords are stored for Customers or Washers.

Admins authenticate separately.

The backend uses a single authentication API for all users. The system determines the roles associated with the authenticated mobile number and issues a JWT with those claims.

---

# Request OTP

POST

```
/auth/request-otp
```

Authentication

```
Public
```

Request

```json
{
  "mobileNumber": "9876543210"
}
```

Validation

- Valid Indian mobile number
- Rate limited
- OTP expiry = 5 minutes

Response

```json
{
  "success": true,
  "data": {
    "otpExpiresInSeconds": 300
  }
}
```

Errors

```
OTP_RATE_LIMIT_EXCEEDED

INVALID_MOBILE_NUMBER
```

---

# Verify OTP

POST

```
/auth/verify-otp
```

Authentication

Public

Request

```json
{
  "mobileNumber": "9876543210",
  "otp": "384721"
}
```

Response

```json
{
  "success": true,
  "data": {
    "accessToken": "...",
    "refreshToken": "...",
    "expiresIn": 1800,
    "roles": ["CUSTOMER"]
  }
}
```

Errors

```
INVALID_OTP

OTP_EXPIRED

USER_BLOCKED
```

---

# Refresh Token

POST

```
/auth/refresh
```

Authentication

Refresh Token

Response

```json
{
  "success": true,
  "data": {
    "accessToken": "...",
    "refreshToken": "..."
  }
}
```

---

# Logout

POST

```
/auth/logout
```

Authentication

JWT Required

Action

- Invalidates refresh token
- Revokes session

Response

HTTP 204

---

# Module 2 — Customer Profile

Requires Role

```
CUSTOMER
```

---

# Get Profile

GET

```
/customers/me
```

Response

```json
{
  "id": "...",
  "fullName": "...",
  "mobileNumber": "...",
  "email": "...",
  "reliabilityScore": 100
}
```

---

# Update Profile

PUT

```
/customers/me
```

Request

```json
{
  "fullName": "...",
  "email": "..."
}
```

Validation

- Name required
- Email optional
- Email format

---

# Get Vehicles

GET

```
/customers/me/vehicles
```

Returns

```
List<Vehicle>
```

---

# Add Vehicle

POST

```
/customers/me/vehicles
```

Request

```json
{
  "vehicleType": "FOUR_WHEELER",
  "vehicleNumber": "DL01AB1234",
  "brand": "Hyundai",
  "model": "Creta",
  "color": "White"
}
```

Validation

- Vehicle number format
- Duplicate prevention

Response

HTTP 201

---

# Update Vehicle

PUT

```
/customers/me/vehicles/{vehicleId}
```

---

# Delete Vehicle

DELETE

```
/customers/me/vehicles/{vehicleId}
```

Soft delete.

---

# Get Addresses

GET

```
/customers/me/addresses
```

---

# Add Address

POST

```
/customers/me/addresses
```

Request

```json
{
  "label": "Home",
  "address": "...",
  "latitude": 28.45,
  "longitude": 77.08
}
```

Validation

Coordinates required.

---

# Update Address

PUT

```
/customers/me/addresses/{addressId}
```

---

# Delete Address

DELETE

```
/customers/me/addresses/{addressId}
```

Soft delete.

---

# Set Default Vehicle

PATCH

```
/customers/me/vehicles/{vehicleId}/default
```

---

# Set Default Address

PATCH

```
/customers/me/addresses/{addressId}/default
```

---

# Module 3 — Washer APIs

The Washer Module manages:

- Registration
- Profile
- Verification (KYC)
- Availability
- Service Areas
- Booking Requests
- Booking Execution
- Earnings
- Weekly Payouts

All endpoints require the role:

```
WASHER
```

unless stated otherwise.

---

# Get My Profile

GET

```
/washers/me
```

Authentication

JWT Required

Response

```json
{
  "id": "...",
  "fullName": "Rahul Sharma",
  "mobileNumber": "9876543210",
  "verificationStatus": "APPROVED",
  "averageRating": 4.91,
  "trustScore": 98.2,
  "totalCompletedJobs": 427,
  "homeBase": {
      "address":"...",
      "latitude":28.61,
      "longitude":77.20
  }
}
```

---

# Complete Registration

Used only once after first login.

POST

```
/washers/me/register
```

Request

```json
{
    "fullName":"Rahul Sharma",
    "homeAddress":"...",
    "latitude":28.61,
    "longitude":77.20
}
```

Validation

- Name mandatory
- Home location mandatory

Response

```
201 Created
```

---

# Update Profile

PUT

```
/washers/me
```

Request

```json
{
    "fullName":"Rahul Sharma"
}
```

---

# Upload Verification Document

POST

```
/washers/me/documents
```

Multipart Form Data

Fields

```
documentType

file
```

Allowed Types

```
AADHAR

PAN

DRIVING_LICENSE

SELFIE
```

Response

```
201 Created
```

---

# Get Verification Status

GET

```
/washers/me/verification
```

Response

```json
{
    "status":"UNDER_REVIEW",
    "documents":[]
}
```

Possible Status

```
NOT_SUBMITTED

UNDER_REVIEW

APPROVED

REJECTED
```

---

# Update Home Base

PUT

```
/washers/me/home-base
```

Request

```json
{
    "address":"...",
    "latitude":28.45,
    "longitude":77.08
}
```

Updating home base automatically affects future distance calculations.

---

# Get Availability

GET

```
/washers/me/availability
```

Query Parameters

```
fromDate

toDate
```

Returns

Availability for the requested date range.

---

# Update Availability

PUT

```
/washers/me/availability
```

Request

```json
{
  "date":"2026-08-10",
  "slots":[
      {
          "slotId":"...",
          "available":true
      },
      {
          "slotId":"...",
          "available":false
      }
  ]
}
```

Validation

Cannot modify availability for past dates.

Maximum future window:

30 Days

---

# Get Service Areas

GET

```
/washers/me/service-areas
```

Returns

Assigned service areas.

---

# Update Service Areas

PUT

```
/washers/me/service-areas
```

Request

```json
{
   "serviceAreaIds":[
      "...",
      "..."
   ]
}
```

Validation

Only administrator-created service areas may be selected.

---

# Get Available Booking Requests

GET

```
/washers/me/booking-requests
```

Returns

Bookings currently available for acceptance.

Each booking includes:

```json
{
    "bookingId":"...",
    "slot":"09:00-11:00",
    "vehicleType":"FOUR_WHEELER",
    "estimatedDistanceKm":4.2,
    "estimatedPayout":280
}
```

Customer personal details are hidden until accepted.

Exact customer location is shown before acceptance as per business rules.

---

# Accept Booking

POST

```
/washers/bookings/{bookingId}/accept
```

Validation

- Washer approved
- Slot available
- Capacity not exceeded
- Booking still open

Response

```
200 OK
```

Errors

```
BOOKING_ALREADY_ACCEPTED

BOOKING_EXPIRED

CAPACITY_EXCEEDED

BOOKING_CANCELLED
```

---

# Reject Booking

POST

```
/washers/bookings/{bookingId}/reject
```

Optional Request

```json
{
    "reason":"Too far"
}
```

---

# Mark On The Way

POST

```
/washers/bookings/{bookingId}/on-the-way
```

Purpose

Records that the washer has started travelling.

This event determines eligibility for travel compensation if the customer cancels before wash start.

Response

```
200 OK
```

---

# Mark Wash Started

POST

```
/washers/bookings/{bookingId}/start
```

Validation

- Booking assigned
- On The Way completed
- Booking not cancelled

Automatically records

- Start Timestamp
- GPS Location

---

# Upload Booking Media

POST

```
/washers/bookings/{bookingId}/media
```

Multipart Form Data

Fields:
- `mediaType`
- `file`

Allowed media types:
```
BEFORE_PHOTO
AFTER_PHOTO
VEHICLE_PHOTO
DISPUTE_EVIDENCE
```

Validation

- Requires at least one `BEFORE_PHOTO` before wash complete.
- Requires at least one `AFTER_PHOTO` before wash complete.
- Maximum file size per photo.

Response

```
201 Created
```

---

# Mark Wash Completed

POST

```
/washers/bookings/{bookingId}/complete
```

Validation

Required:

✓ Wash Started

✓ Before Photo uploaded via Media API

✓ After Photo uploaded via Media API

Automatically records

- Completion Time
- GPS
- Dispute Window Start

Response

```
200 OK
```

---

# Customer Not Reachable

POST

```
/washers/bookings/{bookingId}/customer-not-reachable
```

Request

```json
{
    "remarks":"Customer did not answer calls."
}
```

Required Evidence

- Current GPS
- Vehicle-area photo
- Call attempt log

Automatically creates a dispute.

---

# Vehicle Not Found

POST

```
/washers/bookings/{bookingId}/vehicle-not-found
```

Required

- GPS
- Area Photo
- Remarks

Creates dispute.

---

# Get Weekly Earnings

GET

```
/washers/me/earnings
```

Query

```
weekStart

weekEnd
```

Response

```json
{
    "completedJobs":28,
    "estimatedPayout":8420
}
```

---

# Get Payout History

GET

```
/washers/me/payouts
```

Returns

```
List<Payout>
```

Each payout includes

- Week
- Amount
- Status
- Transaction Reference

---

# Get Booking History

GET

```
/washers/me/bookings
```

Supports

```
status

date

page

size
```

---

# Module 4 — Booking APIs

The Booking Module is responsible for the complete booking lifecycle.

Responsibilities:

- Booking Creation
- Price Calculation
- Booking Retrieval
- Booking Cancellation
- Booking Tracking
- Booking History
- Booking Completion
- Dispute Window

All endpoints require the role:

```
CUSTOMER
```

unless stated otherwise.

---

# Calculate Booking Price

Before creating a booking, the customer may request an estimated price.

POST

```
/bookings/calculate-price
```

Authentication

JWT Required

Request

```json
{
    "vehicleId":"...",
    "addressId":"..."
}
```

Backend Calculates

- Base Price
- Distance
- Travel Charge
- GST
- Platform Price

Response

```json
{
    "basePrice":250,
    "distanceKm":3.4,
    "travelCharge":20,
    "gst":48.60,
    "totalPrice":318.60
}
```

This endpoint performs no payment and creates no booking.

---

# Create Booking

POST

```
/bookings
```

Authentication

JWT Required

Request

```json
{
    "vehicleId":"...",
    "addressId":"...",
    "bookingDate":"2026-08-12",
    "slotId":"..."
}
```

Backend Flow

1. Validate customer.
2. Validate slot.
3. Validate address.
4. Calculate pricing.
5. Create booking.
6. Create payment order.
7. Return payment details.

Response

```json
{
    "bookingId":"...",
    "paymentOrderId":"...",
    "amount":318.60,
    "currency":"INR"
}
```

---

# Payment Verification (Webhook)

Payment verification is handled entirely asynchronously via the payment gateway's webhook (e.g. Razorpay). 

The mobile application should poll the booking status or subscribe to notifications. No direct client-facing `/payments/verify` endpoint is provided, removing the risk of failed verification due to network drops on the client side.

---

# Get Booking

GET

```
/bookings/{bookingId}
```

Returns

```json
{
    "bookingId":"...",
    "status":"ASSIGNED",
    "slot":"09:00-11:00",
    "bookingDate":"...",
    "vehicle":{
    },
    "price":{
    }
}
```

Internal assignment details remain hidden.

---

# Get My Bookings

GET

```
/bookings
```

Supports

```
status

fromDate

toDate

page

size
```

Returns paginated booking history.

---

# Cancel Booking

POST

```
/bookings/{bookingId}/cancel
```

Business Rules

### Before Slot Starts

Full Refund

---

### Slot Started

If

```
Wash NOT Started
```

↓

Full Refund

minus

Admin-configurable Travel Compensation

only if washer marked

```
ON_THE_WAY
```

---

If

```
WASH_STARTED
```

↓

Cancellation Rejected.

---

Response

```json
{
    "refundAmount":270,
    "travelCompensation":50
}
```

---

# Booking Timeline

GET

```
/bookings/{bookingId}/timeline
```

Returns customer-visible events only.

Example

```json
[
    {
        "status":"CONFIRMED",
        "time":"..."
    },
    {
        "status":"ON_THE_WAY",
        "time":"..."
    },
    {
        "status":"COMPLETED",
        "time":"..."
    }
]
```

Internal reassignment events remain hidden.

---

# Booking Invoice

GET

```
/bookings/{bookingId}/invoice
```

Initially returns

Tax-inclusive payment summary.

Future

Downloadable GST Invoice.

---

# Raise Dispute

POST

```
/bookings/{bookingId}/dispute
```

Validation

Booking must be completed.

Dispute window still open.

Request

```json
{
    "type":"BAD_WASH",
    "description":"Vehicle still dirty."
}
```

Optional

Upload evidence.

Response

```
201 Created
```

---

# Get Dispute

GET

```
/disputes/{disputeId}
```

Returns

- Status
- Submitted Evidence
- Resolution

---

# Upload Dispute Evidence

POST

```
/disputes/{disputeId}/media
```

Multipart Upload

Supports

```
PHOTO

DOCUMENT
```

---

# Close Dispute Window

Automatic Background Job

No public API.

Occurs

6–12 hours after completion.

Booking becomes final.

Eligible for weekly payout.

---

# Module 5 — Assignment APIs

The Assignment Module is internal.

Customers never interact directly.

Washers interact only through Booking Request APIs.

Administrator APIs exist for monitoring.

---

# Internal Assignment Flow

Booking Confirmed

↓

Find Eligible Washers

↓

Distance Filter

↓

Availability Filter

↓

Capacity Filter

↓

Trust Score

↓

Ranking

↓

Assignment Request

↓

Accepted

↓

Booking Assigned

If no washer accepts before the booking slot ends:

- Booking marked as FAILED
- Full customer refund initiated automatically

---

# Internal Assignment States

```
SEARCHING

SENT

WAITING

ACCEPTED

DECLINED

TIMED_OUT

FAILED

COMPLETED
```

No external REST APIs are exposed for this workflow.

---

# Module 6 — Payment APIs

Customer-facing APIs

---

# Payment Status

GET

```
/payments/{bookingId}
```

Response

```json
{
    "status":"CAPTURED",
    "amount":318.60
}
```

---

# Refund Status

GET

```
/refunds/{bookingId}
```

Response

```json
{
    "status":"PROCESSING",
    "refundAmount":318.60
}
```

---

No payment initiation endpoints are exposed besides booking creation.

All payment creation occurs through the Booking Module.

---

# Module 7 — Admin APIs

The Admin Portal is responsible for platform operations.

Only users with the following roles may access these APIs:

```
ADMIN

SUPER_ADMIN
```

Every admin action shall generate an Audit Log entry.

---

# Dashboard

GET

```
/admin/dashboard
```

Returns

```json
{
    "todayBookings":124,
    "activeWashers":58,
    "completedBookings":109,
    "pendingDisputes":6,
    "todayRevenue":28450.75
}
```

---

# Customer Management

## Get Customers

GET

```
/admin/customers
```

Supports

```
search

status

page

size
```

---

## Get Customer Details

GET

```
/admin/customers/{customerId}
```

Returns

- Profile
- Vehicles
- Addresses
- Booking History
- Reliability Score

---

## Update Customer Status

POST

```
/admin/customers/{customerId}/status
```

Request

```json
{
    "status": "SUSPENDED",
    "reason": "Repeated fraudulent bookings"
}
```

Allowed states:
```
ACTIVE
SUSPENDED
```

---

# Washer Management

## Get Washers

GET

```
/admin/washers
```

Supports

```
verificationStatus

search

page

size
```

---

## Get Washer Details

GET

```
/admin/washers/{washerId}
```

Returns

- Profile
- Verification Documents
- Ratings
- Completed Jobs
- Cancellation History
- Service Areas
- Availability

---

## Update Washer Status

POST

```
/admin/washers/{washerId}/status
```

Request

```json
{
    "status": "SUSPENDED",
    "reason": "Repeated cancellations",
    "days": 7
}
```

Allowed states:
```
UNDER_REVIEW
APPROVED
REJECTED
SUSPENDED
```

---

# Booking Management

## Get All Bookings

GET

```
/admin/bookings
```

Supports

```
status

date

washer

customer

slot

page

size
```

---

## Get Booking Details

GET

```
/admin/bookings/{bookingId}
```

Returns complete internal booking information.

---

## Cancel Booking

POST

```
/admin/bookings/{bookingId}/cancel
```

Admin Override.

---

# Dispute Management

## Get Disputes

GET

```
/admin/disputes
```

Supports

```
status

type

page

size
```

---

## Get Dispute Details

GET

```
/admin/disputes/{disputeId}
```

Returns

- Booking
- Evidence
- Photos
- Timeline
- Notes

---

## Resolve Dispute

POST

```
/admin/disputes/{disputeId}/resolve
```

Request

```json
{
    "resolution":"Partial Refund",
    "refundPercentage":50,
    "washerPayoutPercentage":50,
    "adminNotes":"Customer unreachable after washer arrived."
}
```

Validation

Percentages must total 100.

---

# Weekly Payouts

## Generate Weekly Batch

POST

```
/admin/payouts/generate
```

Creates payout batch.

---

## Get Payout Batches

GET

```
/admin/payouts
```

---

## Get Batch Details

GET

```
/admin/payouts/{batchId}
```

---

## Mark Batch Paid

POST

```
/admin/payouts/{batchId}/complete
```

---

# Pricing Management

## Get Pricing Rules

GET

```
/admin/pricing
```

---

## Create Pricing Rule

POST

```
/admin/pricing
```

---

## Update Pricing Rule

PUT

```
/admin/pricing/{ruleId}
```

---

## Disable Pricing Rule

DELETE

```
/admin/pricing/{ruleId}
```

Soft delete only.

---

# Slot Management

## Get Slots

GET

```
/admin/slots
```

---

## Create Slot

POST

```
/admin/slots
```

---

## Update Slot

PUT

```
/admin/slots/{slotId}
```

---

## Disable Slot

DELETE

```
/admin/slots/{slotId}
```

---

# Platform Configuration

All configurable business rules are managed centrally.

---

## Get Configurations

GET

```
/admin/configurations
```

---

## Update Configuration

PUT

```
/admin/configurations/{configKey}
```

Example

```json
{
    "value":"50"
}
```

Examples

- Default Capacity
- Travel Compensation
- GST Percentage
- Dispute Window
- Assignment Timeout

---

# Reports

## Revenue Report

GET

```
/admin/reports/revenue
```

---

## Booking Report

GET

```
/admin/reports/bookings
```

---

## Washer Performance

GET

```
/admin/reports/washers
```

---

## Cancellation Report

GET

```
/admin/reports/cancellations
```

---

## Dispute Report

GET

```
/admin/reports/disputes
```

---

# Analytics APIs

GET

```
/admin/analytics
```

Returns

```json
{
    "averageAcceptanceRate":87.4,
    "averageCompletionTimeMinutes":42,
    "averageCustomerRating":4.82,
    "refundRate":2.1
}
```

---

# Notification APIs

## Send Manual Notification

POST

```
/admin/notifications
```

---

## Notification History

GET

```
/admin/notifications
```

---

# Module 8 — Webhooks

## Payment Gateway Webhook

POST

```
/webhooks/payment
```

Authentication

Gateway Signature Verification

Purpose

- Payment Success
- Payment Failure
- Refund Events

---

# Health Check

GET

```
/health
```

Public

Returns

```json
{
    "status":"UP"
}
```

---

# Rate Limits

| Endpoint | Limit |
|----------|-------|
| Request OTP | 5 / hour / mobile |
| Verify OTP | 10 / hour |
| Booking Creation | 10 / hour |
| File Upload | 30 / hour |
| Admin Login | 20 / hour |
| Public APIs | Configurable |

---

# Validation Rules

General

- Request body required where applicable.
- Unknown JSON fields rejected.
- UUIDs validated.
- Dates must use ISO-8601.
- Mobile numbers must be Indian format.
- Monetary values rounded to two decimal places.
- Coordinates validated.

---

# Error Codes

Authentication

```
INVALID_OTP

OTP_EXPIRED

USER_BLOCKED

TOKEN_EXPIRED

INVALID_TOKEN
```

Booking

```
BOOKING_NOT_FOUND

INVALID_SLOT

BOOKING_ALREADY_CANCELLED

BOOKING_ALREADY_COMPLETED

CAPACITY_EXCEEDED

NO_WASHER_AVAILABLE
```

Payment

```
PAYMENT_FAILED

PAYMENT_NOT_FOUND

REFUND_FAILED
```

Disputes

```
DISPUTE_WINDOW_EXPIRED

DISPUTE_ALREADY_EXISTS

INVALID_EVIDENCE
```

Administration

```
INSUFFICIENT_PERMISSION

CONFIGURATION_NOT_FOUND

INVALID_CONFIGURATION

WASHER_NOT_APPROVED
```

---

# API Versioning

Versioning shall be URI-based.

Example

```
/api/v1/bookings
```

Future versions

```
/api/v2/bookings
```

Older versions shall remain supported for a defined deprecation period.

---

# API Documentation

All APIs shall be documented using OpenAPI 3.1.

Swagger UI shall be available in non-production environments.

Example

```
/swagger-ui

/api-docs
```

---

# End of API Specification Document
