# System Architecture Document

## Version

1.0

---

# Purpose

This document defines the complete technical architecture of the Mobile Vehicle Wash Marketplace Platform.

It describes how the platform will be designed, implemented, deployed, scaled, secured, and maintained.

Unlike the BRD and SRS, which describe business and software requirements, this document specifies the engineering architecture required to satisfy those requirements.

This document serves as the authoritative reference for:

- Backend Engineers
- Mobile Developers
- Frontend Developers
- DevOps Engineers
- QA Engineers
- Security Engineers
- Technical Architects

---

# Table of Contents

1. Architectural Principles
2. High-Level Architecture
3. Technology Stack
4. System Components
5. Application Architecture
6. Backend Modules
7. Database Architecture
8. API Design Principles
9. Authentication & Authorization
10. File Storage
11. Background Jobs
12. Notifications
13. Deployment Architecture
14. Security
15. Logging & Monitoring
16. Scalability Strategy
17. Disaster Recovery
18. Future Evolution

---

# 1. Architectural Principles

The platform shall be designed according to the following engineering principles.

---

## 1.1 Simplicity First

The first production release shall prioritize:

- Maintainability
- Readability
- Reliability

over premature optimization.

Complex infrastructure shall only be introduced when justified by measurable business growth.

---

## 1.2 Modular Monolith First

The initial backend shall be implemented as a **Modular Monolith**, not as Microservices.

### Rationale

The expected launch conditions include:

- One development team.
- Limited operational staff.
- Low to moderate traffic.
- Rapid feature iteration.

A Modular Monolith provides:

- Simpler deployments.
- Easier debugging.
- Lower infrastructure cost.
- Faster development.
- Strong transactional consistency.
- Reduced operational complexity.

Each business domain shall remain internally modular to enable future extraction into microservices if required.

---

## 1.3 Domain-Driven Design (DDD)

The system shall be organized by business domains rather than technical layers.

Example domains include:

- Authentication
- Customer
- Washer
- Booking
- Pricing
- Payment
- Refund
- Dispute
- Notification
- Administration
- Reporting

Each domain shall own its business rules and data access.

---

## 1.4 API-First Development

All business functionality shall be exposed through well-defined APIs.

Both the Customer App and Washer App shall consume the same backend APIs.

The Admin Portal shall use separate administrative APIs where appropriate.

---

## 1.5 Backend as the Source of Truth

The backend shall be responsible for:

- Business rules
- Validation
- Authorization
- Pricing
- Capacity checks
- State transitions
- Refund calculations
- Payout calculations

No client application shall implement authoritative business logic.

---

## 1.6 Stateless Application Servers

Application servers shall remain stateless.

No user session data shall be stored in application memory.

This enables:

- Horizontal scaling
- Load balancing
- Rolling deployments
- Failure recovery

---

## 1.7 Configuration over Code

Business rules that frequently change shall be configurable.

Examples:

- Travel compensation
- Booking capacity
- Dispute duration
- Slot timings
- Pricing
- Platform fees
- Weekly payout day

Changes should not require redeployment whenever possible.

---

## 1.8 Security by Design

Security shall be incorporated into every architectural decision.

The platform shall follow:

- Principle of Least Privilege
- Defense in Depth
- Secure Defaults
- Zero Trust between components where applicable

---

# 2. High-Level Architecture

The platform consists of six primary applications.

```text
                    +----------------------+
                    |    Customer App      |
                    +----------+-----------+
                               |
                               |
                    +----------v-----------+
                    |      API Layer       |
                    +----------+-----------+
                               |
     -------------------------------------------------------
        │       ├── notification/
        │       ├── media/
        │       ├── admin/
        │       ├── reporting/
        │       ├── audit/
        │       ├── platformconfig/
        │       ├── common/
        │       └── config/    |
+----v---+ +---v----+ +---v----+ +---v----+ +--v-----+ +----v----+
| Auth   | |Booking | |Payment | |Dispute | |Notify  | | Admin   |
| Module | | Module | | Module | | Module | | Module | | Module  |
+----+---+ +---+----+ +---+----+ +---+----+ +---+----+ +----+----+
     |         |          |          |          |            |
     ----------------------------------------------------------
                              |
                     +--------v---------+
                     | PostgreSQL DB    |
                     +--------+---------+
                              |
                     +--------v---------+
                     | Object Storage   |
                     | (Photos/Docs)    |
                     +------------------+
```

---

# 3. Why This Architecture?

This architecture was selected because it provides:

- Low operational complexity
- Fast development speed
- Easy debugging
- Strong transactional consistency
- Lower cloud costs
- Straightforward testing
- Easier onboarding of future developers

As the platform grows, individual modules can be extracted into independent microservices without significant redesign due to the modular domain boundaries established from the outset.

---

# 4. Architectural Goals

The architecture shall satisfy the following quality attributes:

## Performance

Typical API response time:

- Less than 500 ms under normal load.

---

## Availability

Target:

99.9%

---

## Scalability

Support future expansion to:

- Multiple cities
- Multiple states
- Additional service categories
- Increased booking volume

---

## Reliability

The platform shall ensure:

- No duplicate bookings.
- No duplicate payments.
- No inconsistent booking states.
- Atomic financial operations.

---

## Maintainability

The codebase shall be organized into independent business modules with minimal coupling.

Each module should be understandable in isolation.

---

## Extensibility

Future features should integrate with minimal changes to existing modules.

Examples include:

- Subscription plans
- Corporate accounts
- Fleet management
- Dynamic pricing
- AI-based assignment
- Promotions
- Loyalty programs
- Multi-country expansion

---

---

# 5. Technology Stack

The technology stack has been selected based on the following priorities:

- High developer productivity
- Strong community support
- Excellent performance
- Long-term maintainability
- Easy hiring
- Proven scalability

The stack should remain stable throughout Version 1 unless significant business requirements change.

---

# 5.1 Overall Stack

| Layer | Technology |
|--------|------------|
| Customer Mobile App | Flutter |
| Washer Mobile App | Flutter |
| Admin Portal | React + TypeScript |
| Backend API | Java + Spring Boot |
| Build Tool | Maven |
| ORM | Spring Data JPA + Hibernate |
| Database | PostgreSQL |
| Cache | Redis |
| Object Storage | AWS S3 / Azure Blob Storage (Provider Abstraction) |
| Authentication | JWT + Refresh Tokens |
| Push Notifications | Firebase Cloud Messaging (FCM) |
| Payment Gateway | Razorpay |
| Background Jobs | Spring Scheduler (MVP) |
| Logging | Logback |
| Monitoring | Spring Boot Actuator + Prometheus + Grafana |
| Reverse Proxy | Nginx |
| Containerization | Docker |
| CI/CD | GitHub Actions |
| API Documentation | OpenAPI (Swagger) |

---

# 5.2 Why Flutter?

Both Customer and Washer applications shall use Flutter.

## Advantages

- Single codebase
- Native performance
- Android support from Day 1
- iOS support with minimal additional effort
- Faster feature development
- Large ecosystem
- Strong community support

---

# 5.3 Why React for Admin?

The Admin Portal is a desktop-oriented application.

React provides:

- Mature ecosystem
- Excellent TypeScript support
- Rich component libraries
- Easy integration with REST APIs
- Large hiring pool

---

# 5.4 Why Spring Boot?

The backend shall be implemented using Spring Boot.

## Reasons

- Enterprise maturity
- Excellent documentation
- Dependency Injection
- Spring Security
- Spring Data JPA
- Robust transaction management
- Easy testing
- Huge ecosystem
- Long-term maintainability

The backend should target Java LTS (currently Java 21).

---

# 5.5 Why PostgreSQL?

PostgreSQL shall serve as the primary database.

## Reasons

- ACID compliance
- Excellent transactional integrity
- Rich indexing
- JSON support
- GIS extensions (future)
- Mature replication support
- Strong community

---

# 5.6 Why Redis?

Redis shall be introduced from Version 1.

## Responsibilities

- OTP storage
- Rate limiting
- Frequently accessed configuration
- Temporary booking locks
- Short-lived caches

Redis shall **not** be the source of truth for business data.

---

# 5.7 Object Storage

Photos and documents shall never be stored inside PostgreSQL.

Instead they shall be stored in object storage.

Examples include:

- Before photos
- After photos
- KYC documents
- Profile photos
- Dispute evidence

The database shall store only metadata and file URLs.

---

# 5.8 Authentication

Authentication shall use:

- JWT Access Token
- Refresh Token

Access tokens should remain short-lived.

Refresh tokens should be securely rotated.

---

# 5.9 Payment Gateway

Initial provider:

- Razorpay

The payment module shall be designed behind an abstraction layer so that additional gateways (Cashfree, PhonePe, Stripe, etc.) can be integrated later without affecting business logic.

---

# 5.10 Push Notifications

Firebase Cloud Messaging (FCM) shall deliver push notifications.

Notification sending shall occur asynchronously to avoid delaying API responses.

---

# 5.11 Logging

Application logging shall use Logback.

Every log entry should include:

- Timestamp
- Log level
- Service name
- Request ID
- User ID (if available)

Sensitive information shall never appear in logs.

---

# 5.12 Monitoring

Production monitoring shall include:

- API latency
- Error rates
- CPU usage
- Memory usage
- Database health
- Redis health
- Queue health (future)
- Payment gateway failures

Dashboards shall be created using Grafana.

---

# 5.13 Containerization

Every application shall run inside Docker containers.

Benefits include:

- Consistent environments
- Easier deployment
- Simplified scaling
- Reproducible builds

---

# 5.14 CI/CD

GitHub Actions shall automate:

- Build
- Unit Tests
- Static Analysis
- Docker Image Build
- Deployment (Staging)
- Deployment (Production with approval)

---

# 5.15 API Documentation

Every REST endpoint shall be documented using OpenAPI.

Documentation shall include:

- Request schema
- Response schema
- Authentication requirements
- Error responses
- Example payloads

Swagger UI shall be available in non-production environments.

---

# 6. Repository Strategy

## Recommendation: Monorepo

The project shall use a single Git repository.

### Proposed Structure

```text
vehicle-wash-platform/
│
├── apps/
│   ├── customer-app/
│   ├── washer-app/
│   └── admin-portal/
│
├── backend/
│
├── docs/
│
├── infrastructure/
│
└── scripts/
```

---

## Why Monorepo?

Advantages:

- Easier dependency management
- Atomic commits across applications
- Simplified onboarding
- Shared documentation
- Unified CI/CD
- Easier versioning

Given the expected team size for the MVP, a monorepo provides more benefits than a polyrepo.

---

# 7. Development Workflow

The recommended Git workflow is GitHub Flow.

```text
main
 │
 ├── feature/customer-booking
 │
 ├── feature/payment-module
 │
 ├── feature/dispute-system
 │
 └── hotfix/payment-timeout
```

Every feature branch shall:

- Pass automated tests
- Pass code review
- Be merged via Pull Request

Direct commits to `main` shall be prohibited.

---

# 8. Environment Strategy

The platform shall maintain separate environments.

## Development

Purpose:

- Local development
- Debugging
- Feature implementation

---

## Staging

Purpose:

- QA testing
- UAT
- Integration testing
- Release validation

Should closely mirror production.

---

## Production

Purpose:

- Live customer traffic

Production deployments should:

- Require approval
- Be monitored
- Support rollback
- Preserve zero data loss

---

# 9. Application Architecture

## 9.1 Architectural Style

The backend shall be implemented as a **Modular Monolith** following **Domain-Driven Design (DDD)** principles.

Each business domain shall be isolated into its own module with clearly defined responsibilities and interfaces.

Modules shall communicate through service interfaces rather than directly accessing each other's internal implementation.

---

# 9.2 Backend Package Structure

The backend project shall follow a feature-based package organization.

```text
backend/
└── src/
    └── main/
        ├── java/
        │   └── com/vehiclewash/
        │       ├── auth/
        │       ├── customer/
        │       ├── washer/
        │       ├── booking/
        │       ├── assignment/
        │       ├── pricing/
        │       ├── payment/
        │       ├── payout/
        │       ├── dispute/
        │       ├── notification/
        │       ├── media/
        │       ├── admin/
        │       ├── reporting/
        │       ├── audit/
        │       ├── platformconfig/
        │       ├── common/
        │       └── config/
        │
        └── resources/
```

Each module owns its own business logic.

No module shall directly modify another module's internal data.

---

# 9.3 Internal Structure of a Module

Every business module should follow a consistent structure.

Example:

```text
booking/
│
├── controller/
├── service/
├── repository/
├── entity/
├── dto/
├── mapper/
├── validator/
├── exception/
├── event/
├── scheduler/
└── util/
```

### Responsibilities

| Folder | Responsibility |
|---------|----------------|
| controller | REST API endpoints |
| service | Business logic |
| repository | Database access |
| entity | JPA entities |
| dto | API request/response models |
| mapper | Entity ↔ DTO conversion |
| validator | Business validations |
| exception | Domain-specific exceptions |
| event | Internal domain events |
| scheduler | Background scheduled tasks |
| util | Module-specific utilities |

---

# 9.4 Domain Responsibilities

## Authentication Module

Responsible for:

- OTP generation
- OTP verification
- JWT generation
- Refresh token management
- Login
- Logout
- Session validation

This module shall never contain booking logic.

---

## Customer Module

Responsible for:

- Customer profile
- Vehicles
- Addresses
- Customer preferences
- Customer history

---

## Washer Module

Responsible for:

- Washer profile
- Verification status
- Home base
- Service area
- Availability
- Weekly earnings summary

---

## Booking Module

Responsible for:

- Booking creation
- Slot validation
- Booking lifecycle
- Status transitions
- Booking history

This module is the core of the platform for managing booking state.

---

## Assignment Module

Responsible for:

- Finding eligible washers
- Capacity checks
- Service area filtering
- Distance calculations
- Ranking candidate washers
- Broadcasting booking requests
- Handling reassignment

This separation keeps the Booking module focused purely on the booking lifecycle, while Assignment serves as the matching engine.

---

## Pricing Module

Responsible for:

- Base pricing
- Distance pricing
- Vehicle pricing
- GST calculation
- Travel compensation

---

## Payment Module

Responsible for:

- Payment initiation
- Payment verification
- Refunds
- Gateway callbacks
- Financial records

Business rules remain outside the payment gateway integration layer.

---

## Payout Module

Responsible for:

- Weekly payout calculation
- Payout batches
- Earnings reports
- Settlement history

---

## Dispute Module

Responsible for:

- Dispute creation
- Evidence management
- Administrative resolution
- Refund recommendations
- Payout hold logic

---

## Notification Module

Responsible for:

- Push notifications
- Future SMS
- Future Email
- Notification templates
- Notification history

Notification sending should be asynchronous.

---

## Media Module

Responsible for:

- Image upload
- Image validation
- Document upload
- Object storage integration

The Media Module should not contain booking logic.

---

## Admin Module

Responsible for:

- Administrative operations
- Washer approval
- Dashboard

---

## Platform Configuration Module

Responsible for:

- Global business configuration (Pricing rules, Slots, Capacity defaults, GST settings, Travel fee, etc.)
- Configuration versioning
- Audit of configuration changes
- Runtime configuration caching
- Feature flags
- Future A/B testing support

---

## Reporting Module

Responsible for:

- Analytics
- Reports
- Export functionality

---

## Audit Module

Responsible for:

- Audit logging
- Administrative audit
- Financial audit
- Security audit

Audit records must be immutable.

---

# 9.5 Module Dependency Rules

Allowed dependencies:

```text
Booking
   ↓
Pricing

Booking
   ↓
Assignment

Assignment
   ↓
Notification

Booking
   ↓
Payment
```

Example:

Booking may request price calculation from Pricing.

Booking shall **not** calculate prices itself.

---

Forbidden dependencies:

```text
Pricing
   ↓
Booking
```

Pricing should never know about booking state.

---

Another example:

```text
Notification
     ↓
Booking
```

Notification should never directly read booking tables.

Instead:

```text
Booking
     ↓
NotificationService.send()
```

---

# 9.6 Transaction Management

Transactions shall remain small.

Recommended transactional boundaries:

✔ Create Booking

✔ Accept Booking

✔ Start Wash

✔ Complete Wash

✔ Refund

✔ Weekly Payout

Large transactions spanning unrelated modules shall be avoided.

---

# 9.7 Event-Driven Internal Communication

Even though the application is a modular monolith, modules should communicate through internal domain events where appropriate.

Examples:

Booking Created

↓

Notification Sent

↓

Audit Logged

↓

Analytics Updated

Example:

```
BookingCompletedEvent

↓

Notification Module

↓

Payout Module

↓

Audit Module
```

Initially these events may execute synchronously.

Future versions may migrate to asynchronous event processing.

---

# 9.8 Shared Common Module

The Common module shall contain reusable components.

Examples:

- API response wrapper
- Exception hierarchy
- Constants
- Enums
- Base entity
- Utility classes
- Pagination
- Validation annotations
- Date utilities

Business logic shall never reside inside the Common module.

---

# 9.9 Infrastructure Configuration Module

Application infrastructure configuration shall be centralized in the `config` module.

Examples:

- Security
- Database
- JWT
- Redis
- Swagger
- Scheduling
- CORS
- Logging

Note: Business configuration (pricing, slots, capacity defaults, feature flags) shall be managed dynamically via the database using the dedicated `Platform Configuration Module`.

---

# 9.10 Coding Standards

The project shall follow consistent engineering standards.

## Naming

Classes:

```
BookingService
CustomerController
PaymentRepository
```

Methods:

```
createBooking()

calculatePrice()

verifyPayment()

completeBooking()
```

Variables:

```
customerId

bookingStatus

travelFee
```

Constants:

```
MAX_SLOT_CAPACITY

JWT_EXPIRATION

DEFAULT_DISPUTE_WINDOW
```

---

# 9.11 Dependency Injection

All services shall use constructor injection.

Field injection shall not be used.

Example:

```java
public BookingService(
    BookingRepository repository,
    PricingService pricingService,
    PaymentService paymentService
)
```

Benefits:

- Easier testing
- Immutable dependencies
- Better maintainability

---

# 9.12 Exception Handling

Each module should define domain-specific exceptions.

Example:

```
BookingNotFoundException

InvalidBookingStateException

PaymentVerificationException

WasherCapacityExceededException
```

A centralized exception handler shall convert exceptions into standardized API responses.

---

# 10. Database Architecture

## 10.1 Database Philosophy

PostgreSQL shall be the single source of truth for all persistent business data.

The database shall prioritize:

- Data integrity
- ACID compliance
- Referential consistency
- Maintainability
- Scalability

Business logic shall remain in the application layer rather than in database triggers or stored procedures.

---

# 10.2 Schema Organization

All tables shall reside within a single PostgreSQL database.

Schemas may be introduced later for organizational purposes if required.

Primary domains include:

- Authentication
- Customer
- Washer
- Booking
- Assignment
- Pricing
- Payment
- Refund
- Payout
- Dispute
- Notification
- Audit
- PlatformConfig

---

# 10.3 Entity Ownership

Every table shall have a single owning module.

| Module | Primary Tables |
|---------|----------------|
| Auth | otp_requests, refresh_tokens |
| Customer | customers, vehicles, addresses |
| Washer | washers, washer_documents, washer_availability |
| Booking | bookings, booking_status_history |
| Assignment | booking_assignments, assignment_attempts |
| Pricing | pricing_rules |
| Payment | payments, refunds |
| Payout | payout_batches, payout_items |
| Dispute | disputes, dispute_evidence |
| Notification | notifications |
| Audit | audit_logs |
| PlatformConfig | system_configurations |

Only the owning module may perform writes to its tables.

---

# 10.4 Primary Key Strategy

Every table shall use UUID as the primary key.

Example:

```
booking_id

customer_id

washer_id

payment_id
```

Advantages:

- Globally unique
- Easier distributed scaling
- Safer external exposure
- Prevents predictable IDs

---

# 10.5 Audit Fields

Every business table shall contain standard audit fields.

```text
id
created_at
updated_at
created_by
updated_by
version
```

The `version` field shall support optimistic locking.

---

# 10.6 Soft Delete Policy

Business records shall generally not be physically deleted.

Instead:

```text
is_deleted
deleted_at
deleted_by
```

Examples:

- Customers
- Washers
- Vehicles
- Addresses

Financial records shall never be deleted.

---

# 10.7 Indexing Strategy

Indexes shall be created for:

- Foreign keys
- Frequently filtered columns
- Frequently sorted columns
- Booking status
- Washer availability
- Customer mobile number
- Booking slot
- Payment status
- Dispute status

Composite indexes should be used where beneficial.

Example:

```
(status, slot_start_time)
```

---

# 10.8 Database Constraints

The database shall enforce:

- NOT NULL
- UNIQUE
- FOREIGN KEY
- CHECK constraints where appropriate

Business workflows shall still be validated in the backend.

---

# 10.9 Transaction Rules

Transactions should remain short-lived.

Allowed:

- Booking creation
- Payment verification
- Booking acceptance
- Wash completion
- Refund creation

Avoid:

- Long-running transactions
- User interaction inside transactions
- External API calls inside database transactions

---

# 10.10 Optimistic Locking

Frequently updated entities shall use optimistic locking.

Examples:

- Booking
- Payment
- Washer Availability
- Pricing Configuration

This prevents lost updates during concurrent requests.

---

# 10.11 Historical Data

Historical information shall never overwrite operational data.

Examples:

- Booking status history
- Payment history
- Refund history
- Payout history
- Audit history

Every significant state transition shall be recorded.

---

# 11. Caching Strategy

## Philosophy

Caching exists to improve performance.

It must never become the primary source of business truth.

---

# 11.1 Redis Responsibilities

Redis shall store:

- OTP codes
- Rate limits
- Active JWT blacklist (if required)
- Frequently accessed configuration
- Temporary assignment locks
- Short-lived availability cache

Redis shall not store:

- Bookings
- Payments
- Refunds
- Payouts

---

# 11.2 Cache Expiration

Recommended TTL values:

| Data | TTL |
|------|-----|
| OTP | 5 minutes |
| Rate Limit Counters | 1 minute |
| Pricing Cache | 10 minutes |
| Availability Cache | 2 minutes |
| Platform Configuration | 30 minutes |

---

# 11.3 Cache Invalidation

Whenever administrators update:

- Pricing
- Capacity
- Slot configuration
- Travel compensation

Relevant cache entries shall be invalidated immediately.

---

# 12. API Design Principles

All APIs shall follow REST principles.

---

# 12.1 URI Style

Use nouns rather than verbs.

Good:

```
POST /bookings

GET /customers/{id}

POST /payments
```

Avoid:

```
/createBooking

/getCustomer

/updateProfile
```

---

# 12.2 Versioning

API version shall be included in the URI.

Example:

```
/api/v1/bookings

/api/v1/customers
```

Future breaking changes shall introduce `/v2`.

---

# 12.3 Response Format

Successful response:

```json
{
  "success": true,
  "data": {},
  "timestamp": "...",
  "requestId": "..."
}
```

Error response:

```json
{
  "success": false,
  "error": {
    "code": "...",
    "message": "..."
  },
  "requestId": "..."
}
```

---

# 12.4 Pagination

All list APIs shall support:

```
?page=0

&size=20

&sort=createdAt,desc
```

Response:

```json
{
  "content": [],
  "page": 0,
  "size": 20,
  "totalElements": 100,
  "totalPages": 5
}
```

---

# 12.5 Idempotency

Critical APIs shall support idempotency.

Examples:

- Payment confirmation
- Refund creation
- Booking creation (where applicable)

Idempotency keys shall prevent duplicate processing.

---

# 13. Authentication & Authorization

## Authentication Flow

Customer:

```
Mobile Number

↓

OTP

↓

JWT Access Token

↓

Refresh Token
```

The same flow applies to washers.

Administrators shall authenticate through a separate mechanism with stronger security requirements.

---

# 13.1 Access Token

Recommended lifetime:

15–30 minutes

Purpose:

- API authentication

---

# 13.2 Refresh Token

Recommended lifetime:

30 days

Stored securely.

Rotated after each successful refresh.

---

# 13.3 Authorization

Role-based access control shall define permissions.

Roles include:

- CUSTOMER
- WASHER
- ADMIN
- SUPER_ADMIN

Each endpoint shall explicitly declare required roles.

---

# 13.4 API Security

All authenticated APIs shall require:

- HTTPS
- JWT validation
- Role validation
- Request validation

Sensitive endpoints should also enforce rate limiting.

---

# 13.5 Rate Limiting

Rate limiting shall be applied to:

- OTP requests
- Login attempts
- Booking creation
- Payment initiation
- File uploads

Redis shall be used to implement rate limiting.

---

# 14. Object Storage & Media Management

## 14.1 Purpose

The platform stores various media assets generated by customers, washers, and administrators.

Examples include:

- Before wash photos
- After wash photos
- Vehicle photos
- Washer profile photos
- KYC documents
- Dispute evidence
- Future invoice PDFs

Media files shall **never** be stored inside PostgreSQL.

Instead, they shall be stored in an object storage service.

---

# 14.2 Supported Storage Providers

The Media Module shall abstract the underlying storage provider.

Initial supported providers:

- AWS S3
- Azure Blob Storage

Future providers may include:

- Google Cloud Storage
- MinIO (Self-hosted)
- Cloudflare R2

The application should depend on a storage interface rather than a specific cloud provider.

---

# 14.3 Upload Flow

The upload process shall follow this sequence:

```text
Client
    │
    ▼
Backend validates request
    │
    ▼
Generate Pre-signed Upload URL
    │
    ▼
Client uploads directly to Object Storage
    │
    ▼
Client sends uploaded file reference to Backend
    │
    ▼
Backend validates metadata and stores record in PostgreSQL
```

### Why Pre-signed URLs?

Advantages:

- Backend bandwidth is reduced.
- Faster uploads.
- Better scalability.
- Lower server costs.
- Improved upload reliability.

---

# 14.4 File Validation

Before accepting media references, the backend shall validate:

- File type
- File size
- Ownership
- Upload completion
- MIME type
- Allowed extensions

Unsupported files shall be rejected.

---

# 14.5 Allowed File Types

| Category | Allowed Formats |
|----------|-----------------|
| Images | JPG, JPEG, PNG, WEBP |
| Documents | PDF |

Future formats require administrative approval.

---

# 14.6 Maximum File Sizes

| File Type | Maximum Size |
|-----------|--------------|
| Images | 10 MB |
| Documents | 20 MB |

Values should remain configurable.

---

# 14.7 Storage Organization

Example directory structure:

```text
/customer/
    profile/

/washer/
    profile/
    kyc/

/booking/
    before/
    after/
    vehicle/

/dispute/
    evidence/

/invoice/
```

File names should use UUIDs to prevent collisions.

---

# 14.8 Media Security

Media access shall follow these rules:

- Files remain private by default.
- Public URLs shall not be exposed.
- Access shall require backend authorization.
- Expiring signed download URLs should be generated when needed.

Sensitive KYC documents shall never be publicly accessible.

---

# 15. Background Jobs & Scheduling

## Philosophy

Background jobs shall execute work that does not require immediate user response.

The objective is to reduce API response time and improve reliability.

---

# 15.1 Scheduled Jobs

Version 1 shall use Spring Scheduler.

Future versions may migrate to Quartz or distributed schedulers if required.

---

# 15.2 Scheduled Tasks

The following scheduled jobs are required.

| Job | Frequency |
|------|-----------|
| Expire OTP | Every minute |
| Close expired dispute windows | Every 10 minutes |
| Generate weekly payouts | Weekly |
| Send payout notifications | Weekly |
| Cleanup expired refresh tokens | Daily |
| Cleanup temporary upload records | Daily |
| Archive old notifications | Weekly |
| Health monitoring tasks | Every minute |

---

# 15.3 Event-Based Background Tasks & Internal Event Bus

Certain operations should execute asynchronously using an Internal Event Bus.

Instead of direct service calls (e.g., `BookingService` calling `NotificationService`), modules shall publish domain events.

Example Workflow:
```text
BookingService
      │
      ▼
BookingCompletedEvent
      │
      ├────────► Notification Module
      ├────────► Audit Module
      ├────────► Payout Module
      └────────► Analytics Module
```

Benefits:
- Adheres to the Open/Closed Principle.
- Decouples core domains from side-effects.
- Allows new features (loyalty, ML, referrals) to subscribe without modifying existing booking logic.
- Prevents delays in user-facing APIs.

These tasks should never delay the primary database transaction.

---

# 15.4 Retry Strategy

Transient failures shall be retried.

Recommended retry policy:

- Retry Count: 3
- Exponential backoff
- Log every failure
- Alert after final failure

---

# 16. Notification Architecture

## Philosophy

Notifications improve transparency without exposing unnecessary operational details.

The platform shall only communicate information relevant to the user.

Internal operational changes (such as reassignment to another washer) shall remain hidden from customers.

---

# 16.1 Notification Channels

Version 1:

- Push Notifications (FCM)
- In-app Notifications

Future:

- SMS
- Email
- WhatsApp

---

# 16.2 Notification Types

### Customer

- Booking Created
- Booking Confirmed
- Washer On The Way
- Wash Completed
- Refund Processed
- Dispute Updated
- Booking Cancelled

---

### Washer

- New Booking Available
- Booking Assigned
- Booking Cancelled
- Weekly Payout Ready
- Weekly Payout Processed
- Verification Approved
- Verification Rejected

---

### Administrator

- New Washer Registration
- High Priority Dispute
- Failed Weekly Payout
- Payment Gateway Failure
- System Alerts

---

# 16.3 Notification Templates

Notification content shall be template-driven.

Example:

```text
Title:

Booking Confirmed

Body:

Your vehicle wash has been successfully assigned.
Expected completion: 11:00 AM.
```

Templates shall support localization in future versions.

---

# 16.4 Delivery Guarantees

The platform should aim for:

- At least one successful delivery attempt.
- Retry failed push notifications.
- Record delivery status.
- Prevent duplicate notifications.

---

# 16.5 Notification History

Users shall be able to view previous notifications.

Each notification record should include:

- Title
- Body
- Timestamp
- Read status
- Delivery status

Notification history should remain available for a configurable retention period.

---

# 17. Deployment Architecture

## 17.1 Deployment Philosophy

The deployment architecture shall prioritize:

- Simplicity
- Reliability
- Low operational cost
- High availability
- Easy rollback
- Future scalability

Version 1 shall be deployable by a single DevOps engineer without requiring Kubernetes.

---

# 17.2 Production Architecture

```text
                         Internet
                             │
                             ▼
                    +------------------+
                    |      Nginx       |
                    | Reverse Proxy    |
                    +---------+--------+
                              │
          +-------------------+-------------------+
          │                                       │
          ▼                                       ▼
 +---------------------+               +----------------------+
 | Spring Boot Backend |               | Spring Boot Backend  |
 | Instance A          |               | Instance B           |
 +----------+----------+               +----------+-----------+
            │                                     │
            +----------------+--------------------+
                             │
                             ▼
                    +------------------+
                    |    PostgreSQL    |
                    +------------------+
                             │
          +------------------+-------------------+
          │                                      │
          ▼                                      ▼
    +-------------+                    +----------------+
    |    Redis    |                    | Object Storage |
    +-------------+                    +----------------+
```

Initially a single backend instance is acceptable.

Horizontal scaling shall be supported without architectural changes.

---

# 17.3 Environment Configuration

Each environment shall maintain independent:

- Database
- Redis
- Object Storage Bucket
- Secrets
- Payment Credentials
- Notification Credentials

No production credentials shall exist in development environments.

---

# 17.4 Secret Management

Secrets shall never be committed to source control.

Examples:

- JWT Secret
- Database Password
- Razorpay Keys
- Firebase Credentials
- SMTP Passwords
- Storage Credentials

Recommended solutions:

- GitHub Secrets
- Azure Key Vault
- AWS Secrets Manager

---

# 17.5 Docker Strategy

Each deployable component shall have its own Docker image.

Example:

```text
backend/

admin/

nginx/
```

Development images and production images should remain separate.

---

# 17.6 Reverse Proxy

Nginx responsibilities:

- HTTPS termination
- Compression
- Static asset delivery
- Request forwarding
- Rate limiting (basic)
- Security headers

Business logic shall never reside in Nginx.

---

# 17.7 CI/CD Pipeline

Every merge to the main branch shall trigger:

1. Compile project
2. Run unit tests
3. Static code analysis
4. Build Docker image
5. Publish artifact
6. Deploy to Staging

Production deployment shall require manual approval.

---

# 17.8 Rollback Strategy

Every deployment shall support rollback.

Rollback requirements:

- Previous Docker image retained
- Database migrations reversible where possible
- Deployment logs preserved
- No customer data loss

---

# 18. Logging & Monitoring

## 18.1 Logging Principles

Logs shall help engineers answer:

- What happened?
- When?
- Who initiated it?
- Which request caused it?
- What was the outcome?

---

# 18.2 Log Levels

| Level | Purpose |
|--------|----------|
| TRACE | Detailed debugging |
| DEBUG | Development diagnostics |
| INFO | Business events |
| WARN | Recoverable problems |
| ERROR | Failures requiring attention |

Production should avoid DEBUG unless troubleshooting.

---

# 18.3 Structured Logging

Logs should be machine-readable.

Every request should include:

- Request ID
- User ID
- Booking ID (if applicable)
- IP Address
- Endpoint
- Response Time

---

# 18.4 Metrics

The platform shall expose metrics for:

- API latency
- API throughput
- Error rate
- Active bookings
- Completed bookings
- Failed payments
- Refund count
- Weekly payouts
- Redis usage
- Database connections
- CPU usage
- Memory usage

---

# 18.5 Monitoring Dashboard

Recommended dashboards:

- System Health
- Booking Activity
- Financial Activity
- Payment Success Rate
- Washer Activity
- Customer Activity
- API Performance
- Infrastructure Health

---

# 18.6 Alerting

Critical alerts include:

- Database unavailable
- Redis unavailable
- Payment gateway failures
- High API error rate
- Low disk space
- High CPU usage
- High memory usage
- Failed weekly payout generation

Alerts should integrate with:

- Email
- Slack (future)
- Microsoft Teams (future)

---

# 19. Security Architecture

## 19.1 Security Principles

The platform shall follow:

- Least Privilege
- Defense in Depth
- Secure Defaults
- Zero Trust

---

# 19.2 Data Encryption

Sensitive communication shall use HTTPS.

Sensitive data at rest should be encrypted where supported.

Passwords (if introduced in future) shall use strong hashing algorithms such as BCrypt or Argon2.

---

# 19.3 Input Validation

Every API shall validate:

- Required fields
- Data types
- Length
- Formats
- Business rules

Validation shall occur on the backend regardless of frontend validation.

---

# 19.4 SQL Injection Prevention

Only parameterized queries or ORM-generated queries shall be used.

Dynamic SQL string concatenation is prohibited.

---

# 19.5 Cross-Site Request Forgery (CSRF)

Admin Portal protections shall be evaluated based on the chosen authentication mechanism.

Appropriate CSRF protection shall be enabled where applicable.

---

# 19.6 Cross-Site Scripting (XSS)

All user-generated content displayed in web interfaces shall be properly escaped or sanitized.

---

# 19.7 Rate Limiting

Sensitive APIs:

- OTP
- Login
- Booking Creation
- File Upload
- Payment

shall be protected by rate limiting.

---

# 19.8 Audit Logging

The following actions shall always be audited:

- Refunds
- Payouts
- Pricing changes
- Capacity changes
- Admin login
- Admin overrides
- Washer approval
- Washer suspension
- Customer suspension

Audit records shall be immutable.

---

# 20. Scalability Strategy

## Phase 1

Expected scale:

- One city
- Few hundred washers
- Thousands of bookings per month

Architecture:

- Modular Monolith
- Single PostgreSQL
- Redis
- Object Storage

---

## Phase 2

Expected scale:

- Multiple cities

Enhancements:

- Multiple backend instances
- Load balancer
- Read replicas
- Improved monitoring

---

## Phase 3

Expected scale:

- Nationwide

Potential additions:

- Kafka/Event Streaming
- Dedicated Assignment Service
- Dedicated Notification Service
- Search Service
- Analytics Pipeline

---

## Phase 4

Global scale (future)

Possible additions:

- Multi-region deployment
- CDN
- Geo-replication
- Multi-country pricing
- Multi-currency support

---

# 21. Microservice Migration Strategy

The system is intentionally designed for gradual migration.

Candidate modules for future extraction:

1. Notification
2. Media
3. Assignment
4. Payment
5. Reporting
6. Analytics

Migration should occur only when justified by measurable business growth.

Premature microservices are discouraged.

---

# 22. Backup & Disaster Recovery

## Database

- Daily full backup
- Hourly incremental backups (if supported)
- Point-in-time recovery where available

---

## Object Storage

- Enable versioning
- Lifecycle policies
- Cross-region replication (future)

---

## Recovery Objectives

| Metric | Target |
|---------|---------|
| Recovery Time Objective (RTO) | < 2 hours |
| Recovery Point Objective (RPO) | < 15 minutes |

---

# 23. Production Readiness Checklist

Before launch, confirm:

- All APIs documented.
- Automated tests passing.
- Security review completed.
- Backup strategy verified.
- Monitoring dashboards operational.
- Alerts configured.
- HTTPS enabled.
- Secrets externalized.
- Logging verified.
- Database migrations tested.
- Rollback tested.
- Payment gateway tested.
- Push notifications tested.
- Weekly payout simulation completed.
- Disaster recovery drill completed.

---

# 24. Architecture Decision Records (ADR)

Significant architectural decisions should be documented separately as ADRs.

Example ADRs:

- ADR-001: Choose Modular Monolith over Microservices
- ADR-002: Use PostgreSQL as Primary Database
- ADR-003: Adopt Flutter for Mobile Applications
- ADR-004: Platform-Controlled Pricing
- ADR-005: Weekly Washer Payouts
- ADR-006: Event-Driven Internal Communication
- ADR-007: Centralized Platform Configuration Module

Each ADR should include:

- Context
- Decision
- Alternatives Considered
- Consequences
- Date
- Status

---

# End of System Architecture Document
