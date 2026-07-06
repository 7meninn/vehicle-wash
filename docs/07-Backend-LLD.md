# Backend Low Level Design (LLD)

Version 1.0

---

# Purpose

This document defines the implementation architecture of the backend.

It standardizes:

- package organization
- dependency rules
- coding standards
- transaction management
- service design
- entity mapping
- validation
- exception handling
- asynchronous processing

This document should ensure that every backend developer writes code consistently.

---

# Technology Stack

Language

Java 21 LTS

Framework

Spring Boot 3.x

Security

Spring Security

Database

PostgreSQL

ORM

Spring Data JPA (Hibernate)

Cache

Redis

Object Storage

Azure Blob Storage

Messaging (Future)

Kafka

Documentation

OpenAPI

Testing

JUnit 5

Mockito

Testcontainers

Build Tool

Gradle Kotlin DSL

---

# Architectural Style

The backend shall follow

Modular Monolith Architecture

NOT

Microservices.

Every business module owns:

- controller
- service
- repository
- entity
- mapper
- dto
- validator

Modules communicate only through services.

Never through repositories.

---

# Package Structure

```
com.company.vehiclewash
```

---

# Root Packages

```
config

security

common

customer

washer

booking

assignment

payment

refund

payout

pricing

notification

dispute

audit

admin

platform

storage

scheduler
```

---

# Common Package

Contains reusable infrastructure.

```
common
├── dto
├── entity
├── enums
├── exception
├── mapper
├── response
├── validation
├── util
├── constants
├── events
└── annotations
```

No business logic belongs here.

---

# Module Structure (Vertical Slice Architecture)

Inside each module, we adopt a **Vertical Slice Architecture** (Feature-Based Organization).

Instead of grouping by layer (all controllers together, all services together), we group by feature.

Example for `booking` module:

```
booking
├── createBooking
│      CreateBookingController
│      CreateBookingService
│      CreateBookingRequest
│      CreateBookingResponse
│
├── cancelBooking
│      CancelBookingController
│      CancelBookingService
│      CancelBookingRequest
│
├── getBooking
│      GetBookingController
│      GetBookingService
│      BookingResponse
│
├── entity
│      Booking
│      BookingStatusHistory
│
├── repository
│      BookingRepository
│
├── enums
│      BookingStatus
│
├── mapper
│      BookingMapper
│
└── exception
       BookingNotFoundException
```

Shared components within a module (like Entities, Repositories, Mappers, and specific Exceptions) remain in module-level folders, but all feature-specific logic, controllers, and DTOs are grouped into use-case folders.

---

# Layer Responsibilities

Even within a feature slice, the logical flow remains strict:

Controller
↓
Validation
↓
Service
↓
Repository
↓
Database

Controllers never access repositories.

Repositories never call services.

Entities never call repositories.

---

# Controller Responsibilities

Controllers should only

- receive requests
- validate DTO
- call service
- return response

Maximum controller length

≈100 lines.

No business logic.

---

# Service Responsibilities

Service layer owns

ALL business rules.

Examples

Booking validation

Refund calculation

Capacity validation

Assignment

Pricing

Dispute creation

Notifications

No controller should contain business rules.

---

# Repository Responsibilities

Repositories

ONLY

perform persistence.

Never

- calculate prices
- assign washers
- send notifications
- perform validations

---

# Entity Responsibilities

Entities represent persistence only.

Never place business logic inside entities.

Allowed

Simple helper methods.

Not Allowed

Business workflows.

---

# DTO Strategy

Every endpoint has

Request DTO

Response DTO

Never expose entities directly.

Never return JPA entities.

---

# Mapper Strategy

Use

MapStruct.

Never manually map 200 fields repeatedly.

Each module owns its own mapper.

Example

BookingMapper

CustomerMapper

WasherMapper

---

# Validation Strategy

Validation occurs in

DTO

using

Jakarta Validation.

Example

@NotBlank

@NotNull

@Pattern

@Size

Business validation belongs inside services.

Example

Slot already expired.

Customer suspended.

Washer blocked.

---

# Transaction Strategy

Transaction boundaries shall exist only in the Service Layer.

Controllers, repositories, and utility classes shall never start or manage transactions.

---

## Read Operations

Use:

```java
@Transactional(readOnly = true)
```

Examples:

- Get Booking
- Get Customer
- Search Washers
- Booking History
- Reports

---

## Write Operations

Use:

```java
@Transactional
```

Examples:

- Create Booking
- Cancel Booking
- Approve Washer
- Resolve Dispute
- Generate Weekly Payout

---

## Transaction Rules

One business operation equals one transaction.

Example

```
Create Booking

↓

Create Booking Entity

↓

Create Pricing Snapshot

↓

Create Payment Record

↓

Publish Event

↓

Commit
```

If any step fails before commit:

Entire transaction rolls back.

---

## Never

Never call one @Transactional method internally inside the same class expecting a new transaction.

Instead:

Move the logic to another service.

---

# Exception Handling

The backend shall use centralized exception handling.

No controller shall contain try-catch blocks.

---

## Global Exception Handler

```
@RestControllerAdvice
```

Responsibilities

- Convert exceptions into API responses
- Hide stack traces
- Produce consistent error format

---

## Exception Hierarchy

```
RuntimeException

↓

ApplicationException

↓

BusinessException

↓

ValidationException

↓

ResourceNotFoundException

↓

ConflictException

↓

PaymentException

↓

AuthenticationException

↓

AuthorizationException
```

---

## Business Exception Examples

```
SlotAlreadyStartedException

BookingAlreadyCancelledException

WasherSuspendedException

CapacityExceededException

BookingNotFoundException

PaymentVerificationException

RefundNotAllowedException

DisputeWindowExpiredException
```

---

## Standard Error Response

```json
{
  "success": false,
  "error": {
    "code": "BOOKING_ALREADY_CANCELLED",
    "message": "Booking has already been cancelled."
  },
  "timestamp": "...",
  "requestId": "..."
}
```

---

# Logging Strategy

Use SLF4J.

Never use

```
System.out.println()
```

---

## Log Levels

TRACE

Extremely detailed debugging.

DEBUG

Development diagnostics.

INFO

Business events.

WARN

Recoverable problems.

ERROR

Unexpected failures.

---

## Always Log

Booking Created

Booking Cancelled

Payment Success

Refund Initiated

Dispute Created

Weekly Payout Generated

Admin Override

Configuration Changed

---

## Never Log

Passwords

OTP

JWT Tokens

Payment Signatures

Personal Documents

Aadhaar Numbers

PAN Numbers

---

# Security Layer

Spring Security shall protect every endpoint.

Authentication

↓

Authorization

↓

Business Logic

---

## JWT

Access Token

15–30 minutes

Refresh Token

7–30 days

Configurable.

---

## Authorization

Role-based.

```
CUSTOMER

WASHER

ADMIN

SUPER_ADMIN
```

Use

```
@PreAuthorize
```

Example

```java
@PreAuthorize("hasRole('ADMIN')")
```

---

## Public Endpoints

```
/auth/request-otp

/auth/verify-otp

/health

/swagger/*
```

Development only for Swagger.

---

## Protected Endpoints

Everything else.

---

# Validation Strategy

Validation occurs in two stages.

Stage 1

DTO Validation

Example

```
@NotNull

@NotBlank

@Pattern

@Email

@Size
```

Stage 2

Business Validation

Examples

Booking already cancelled.

Washer suspended.

Slot expired.

Customer blocked.

Vehicle not found.

---

# File Upload Strategy

Supported

JPEG

PNG

Future

PDF

---

Maximum Size

Configurable.

Recommended

10 MB

---

Uploads

↓

Virus Scan (Future)

↓

Azure Blob Storage

↓

Store Storage Key

↓

Return URL

Never store files inside PostgreSQL.

---

# Event-Driven Architecture

Although Version 1 is a Modular Monolith,

modules should communicate through events whenever practical.

---

## Why?

Loose coupling.

Future migration to Kafka becomes easy.

---

## Example

Booking Created

↓

Pricing Module

↓

Payment Module

↓

Assignment Module

↓

Notification Module

Each module reacts independently.

---

# Internal Event Bus

Use Spring Events.

```
ApplicationEventPublisher
```

Future

Replace with Kafka.

Business code should not change.

---

## Event Examples

```
BookingCreatedEvent

BookingCancelledEvent

BookingAssignedEvent

WasherAcceptedBookingEvent

WasherOnTheWayEvent

WashStartedEvent

WashCompletedEvent

PaymentCapturedEvent

RefundCompletedEvent

DisputeCreatedEvent

DisputeResolvedEvent

WeeklyPayoutGeneratedEvent

ConfigurationUpdatedEvent
```

---

## Event Rules

Events should never contain entities.

Only IDs and immutable values.

Example

```java
BookingCreatedEvent

bookingId

customerId

slotId

createdAt
```

---

# Background Jobs

Scheduled Jobs

Use Spring Scheduler.

---

## Daily Jobs

Expire OTP

Remove expired tokens

Delete temporary uploads

Cleanup logs (future)

---

## Hourly Jobs

Assignment timeout checks

Dispute window closure

Notification retries

Refresh cached configurations

---

## Weekly Jobs

Generate payouts

Generate reports

Email payout summaries

Archive completed batches

---

## Monthly Jobs

Analytics aggregation

Database maintenance

Storage cleanup

Audit archival

---

# Async Processing

Use

```
@Async
```

Only for non-critical work.

Examples

Notifications

Email

Analytics

Audit

Image processing

Never for

Payments

Refunds

Booking Creation

Dispute Resolution

Financial operations remain synchronous.

---

# Caching Strategy

Use Redis.

Cache

Platform Configuration

Slot Definitions

Pricing Rules

Service Areas

Frequently accessed read-only data.

Do NOT cache

Payments

Bookings

Refunds

Payouts

Disputes

---

# Configuration Management

Use

@ConfigurationProperties

Never hardcode

URLs

Timeouts

JWT expiry

Redis settings

Payment credentials

Storage credentials

Capacity defaults

Travel compensation

---

# Object Mapping

Use MapStruct.

Never expose Entity classes.

Flow

```
Entity

↓

Mapper

↓

DTO

↓

API
```

---

# Repository Guidelines

One repository per aggregate root.

Examples

BookingRepository

CustomerRepository

PaymentRepository

WasherRepository

Never inject Repository A into Repository B.

Repositories never communicate.

---

# Dependency Rules

Allowed

```
Controller

↓

Service

↓

Repository
```

Forbidden

```
Controller

↓

Repository
```

Forbidden

```
Repository

↓

Service
```

Forbidden

```
Entity

↓

Repository
```

Forbidden

```
Entity

↓

Service
```

---

# Package Dependency Rules

Every module owns its implementation.

Cross-module communication only through public services or domain events.

Never directly access another module's repository.

Correct

BookingService

↓

PaymentService

Wrong

BookingService

↓

PaymentRepository

---

# Optimistic Locking

Every mutable entity shall contain

```java
@Version
private Integer version;
```

This prevents lost updates.

---

# Soft Delete Policy

Business entities

Customer

Vehicle

Address

Washer

Documents

Service Areas

shall support soft delete.

Financial entities

Payment

Refund

Payout

Audit

Status History

shall NEVER be deleted.

---

# Time Handling

Always use UTC internally.

Store timestamps as

```
Instant
```

Convert to local timezone only in presentation.

Never store LocalDateTime for audit timestamps.

---

# Testing Philosophy

Every service should be independently testable.

Recommended coverage

Unit Tests

Business Logic

Repository Tests

Integration Tests

API Tests

End-to-End Tests

Critical financial workflows require integration testing.

---

# Performance Targets

API Response

Average

< 300 ms

Booking Creation

< 2 seconds

Booking Search

< 500 ms

Payment Verification

< 3 seconds

Dashboard Load

< 1 second

---

# Definition of Done (Backend)

A feature is complete only if:

✓ Business logic implemented

✓ Validation implemented

✓ Unit tests written

✓ Integration tests pass

✓ OpenAPI updated

✓ Logging added

✓ Audit added

✓ Security verified

✓ Transactions verified

✓ Events published

✓ Documentation updated

✓ Code reviewed

✓ Sonar issues resolved

✓ No critical vulnerabilities

---

# Command/Query Responsibility Segregation (CQRS-lite)

As the application grows, read operations and write operations must scale and be maintained independently. To support this, modules will adopt a lightweight CQRS structure.

Inside each feature or module (like `booking`), segregate services into `command` and `query` packages.

Example:

```text
booking/
    command/
        CreateBookingService
        CancelBookingService
        CompleteBookingService

    query/
        GetBookingService
        SearchBookingsService
        BookingHistoryService
```

- **Commands** perform mutations, start transactions, and enforce complex business rules.
- **Queries** perform lookups, return read-only DTOs, and do not mutate state. 

This sets up a clean boundary and paves the way for advanced caching or a split database architecture in the future.

---

# End of Backend Low Level Design
