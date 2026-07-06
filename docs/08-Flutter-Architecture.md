# Flutter Architecture

Version 1.0

---

# Purpose

This document defines the architecture, coding standards, folder structure, state management strategy, navigation, networking, dependency injection, offline handling, and feature organization for both Flutter applications.

The architecture shall ensure:

- High maintainability
- Feature modularity
- Scalability
- Testability
- Code reuse
- Consistent UI behavior
- Easy onboarding for new developers

This document applies to:

- Customer App
- Washer App

---

# Multi-App Strategy (Monorepo)

Instead of building one monolithic Flutter project with conditional role-based logic, the project shall be structured as three separate packages within a monorepo:

```text
vehicle_wash_customer/   (The Customer App)
vehicle_wash_washer/     (The Washer App)
vehicle_wash_shared/     (Shared Dart Package)
```

The `vehicle_wash_shared` package contains:
- API client configuration (Dio interceptors, etc.)
- Data Transfer Objects (DTOs)
- Common Models
- Authentication logic
- Core Utilities and Constants
- Shared Theme tokens and basic UI widgets
- Error handling logic

This structure ensures smaller app sizes, clean separate release cycles, easier permission management, and no duplicated networking or business models.

---

# Technology Stack

## Flutter

Flutter Stable (Latest LTS)

---

## Language

Dart 3.x

---

## State Management

Riverpod

Reason:

- Compile-time safety
- Easy testing
- No BuildContext dependency
- Better scalability than Provider
- Simpler than Bloc for this project

---

## Routing

GoRouter

Reasons:

- Declarative navigation
- Deep linking support
- Route guards
- Nested navigation
- Shell routes

---

## HTTP Client

Dio

Reasons:

- Interceptors
- Better error handling
- Retry support
- Multipart uploads
- Download progress

---

## JSON Serialization

json_serializable

Avoid manual JSON parsing.

---

## Local Storage

Hive

Store:

- JWT
- Refresh Token
- User Preferences
- Cached Configurations
- Last Selected Vehicle
- Last Selected Address

Never store sensitive business data permanently.

---

## Secure Storage

flutter_secure_storage

Store:

- Access Token
- Refresh Token

Never store tokens in Hive.

---

## Image Picker

image_picker

Future:

camera

---

## Push Notifications

Firebase Cloud Messaging (FCM)

---

## Maps

Google Maps Flutter

Used for:

- Customer addresses
- Washer home base
- Booking location
- Service areas (future)

---

# Architecture Style

Feature-First Architecture

NOT

Layer-first.

Each feature owns everything required.

---

# Root Folder Structure

(Applies to both `vehicle_wash_customer` and `vehicle_wash_washer`)

```
lib/

core/

shared/

features/

routes/

theme/

main.dart
```

---

# Core Package

Contains reusable infrastructure.

```
core/

api/

storage/

network/

config/

exceptions/

security/

constants/

utils/

services/
```

No business logic belongs here.

---

# Shared Package

Contains reusable UI.

```
shared/

widgets/

dialogs/

extensions/

components/

animations/

models/
```

Used across all features.

---

# Features Package

Every business feature is isolated.

Example

```
features/

authentication/

booking/

vehicle/

address/

payment/

history/

profile/

notification/

dispute/
```

Each feature owns:

- UI
- Provider
- Repository
- DTO
- API
- Widgets

---

# Feature Structure

Example

booking

```
booking/

presentation/

pages/

widgets/

providers/

domain/

entities/

repositories/

usecases/

data/

datasources/

models/

repository_impl/

```

Every feature follows the same structure.

---

# Layer Responsibilities

Presentation

↓

Use Case

↓

Repository

↓

Datasource

↓

API

---

# Presentation Layer

Contains

- Screens
- Widgets
- Providers
- UI State

Never perform HTTP calls directly.

---

# Domain Layer

Contains

Business logic.

Use Cases.

Entities.

Repository Contracts.

Pure Dart.

No Flutter dependency.

---

# Data Layer

Contains

API

Models

Repository Implementations

Datasource

JSON Parsing

---

# State Management

Riverpod

Types

Provider

FutureProvider

StateNotifierProvider

AsyncNotifierProvider

Family Providers

Choose the simplest provider that satisfies the use case.

---

# Dependency Injection

Use Riverpod Providers.

Avoid global singletons where possible.

Example

Repository

↓

Injected into

↓

Use Case

↓

Injected into

↓

UI

---

# Navigation Strategy

The application shall use GoRouter.

Navigation must be declarative.

Avoid:

```
Navigator.push()
```

except for temporary dialogs and bottom sheets.

---

## Root Navigation

Customer App

```
Splash

↓

Authentication

↓

Home

├── Book Wash

├── Booking History

├── Notifications

├── Profile
```

---

Washer App

```
Splash

↓

Authentication

↓

Dashboard

├── Booking Requests

├── Today's Jobs

├── Availability

├── Earnings

├── Profile
```

---

## Route Guards

Unauthenticated users

↓

Only

```
Login

OTP
```

Authenticated users

↓

Cannot navigate back to Login.

Suspended washers

↓

Automatically redirected to

```
Suspended Screen
```

---

# Authentication Flow

Application Launch

↓

Splash

↓

Check Secure Storage

↓

Access Token exists?

↓

YES

↓

Validate expiry

↓

Expired?

↓

Refresh Token

↓

Refresh Success

↓

Home

↓

Refresh Failed

↓

Logout

↓

Login

---

# API Layer

Every API call must pass through Dio.

No feature shall instantiate its own Dio instance.

```
UI

↓

Repository

↓

Datasource

↓

ApiClient

↓

Dio

↓

Backend
```

---

## ApiClient Responsibilities

- Base URL
- Authentication header
- Logging
- Retry
- Timeout
- Error mapping
- Token refresh
- Multipart upload

---

# Dio Interceptors

Interceptors shall handle:

Request

↓

Attach JWT

↓

Response

↓

401?

↓

Refresh Token

↓

Retry Request

↓

Return Response

---

Interceptors shall also

- Add Request ID
- Add Platform Header
- Log request duration

---

# Repository Pattern

UI never knows API implementation.

```
BookingRepository

↓

BookingRepositoryImpl

↓

BookingDatasource

↓

API
```

Repository is the only source of truth.

---

# Offline Strategy

Supported Offline

- Last profile
- Booking history cache
- Static pricing config
- Theme
- Last selected address
- Last selected vehicle

Not Supported Offline

- Booking Creation
- Payment
- Assignment
- Availability Updates
- Wash Completion

Show clear UI when internet is unavailable.

---

# Network State

Use

```
connectivity_plus
```

Network changes should update UI automatically.

States

```
Connected

Disconnected

Slow Network
```

---

# UI State

Every screen shall support

Loading

Success

Empty

Error

Refreshing

No screen shall display blank content.

---

## Loading

Skeleton loaders preferred.

Avoid unnecessary spinners.

---

## Empty States

Example

Booking History

```
No bookings yet.

Book your first wash.
```

---

## Error States

Show

Friendly message

Retry button

Technical details hidden.

---

# Refresh Strategy

Support Pull-To-Refresh

For

History

Notifications

Dashboard

Booking Requests

Profile

---

# Pagination

Infinite scrolling.

Page size

20

Backend controlled.

---

# Search

Debounce

300 milliseconds.

Avoid API call on every keystroke.

---

# Image Upload

Flow

Camera

↓

Crop

↓

Compress

↓

Preview

↓

Upload

↓

Display Success

---

Maximum Upload

10 MB

Compress before upload.

---

# File Naming

Never expose original names.

Backend returns storage URL.

---

# Error Handling

Centralized.

No screen handles DioException directly.

Convert into

```
AppException
```

Types

```
NetworkException

UnauthorizedException

ValidationException

BusinessException

ServerException

UnknownException
```

---

# Retry Policy

Retry automatically

Network Timeout

↓

Maximum

2 retries

Never retry

Payment

Booking Creation

Refund

Dispute Submission

Financial APIs require explicit user action.

---

# Theme

Single source of truth.

```
AppTheme

↓

Light Theme

↓

Dark Theme (Future)
```

---

Colors

Typography

Spacing

Radius

Animations

Icons

shall all come from theme.

Never hardcode colors.

---

# Typography

Single typography file.

Examples

```
Headline

Title

Subtitle

Body

Caption

Button
```

---

# Responsive Design

Support

Phones

Large Phones

Tablets (Future)

Avoid fixed pixel sizes.

Use

MediaQuery

LayoutBuilder

Flexible

Expanded

---

# Internationalization

Architecture shall support localization.

Initial Language

English

Future

Hindi

No hardcoded strings inside widgets.

---

# Accessibility

Support

Large Fonts

Screen Readers

Semantic Labels

Contrast

Touch Targets

Minimum

48dp

---

# Form Validation

Validate immediately.

Show inline errors.

Never wait until submit for obvious validation.

---

# Dialog Strategy

Use reusable dialogs.

Examples

Confirmation

Delete

Logout

Cancel Booking

Dispute Warning

Never duplicate dialog code.

---

# Bottom Sheets

Use modal bottom sheets for

Vehicle Selection

Address Selection

Filters

Photo Source

Never create custom implementations repeatedly.

---

# Snackbars

Reserved for

Success

Warnings

Informational messages

Critical errors use dialogs.

---

# Permissions

Customer App

Location

Notifications

Camera (future)

---

Washer App

Camera

Location

Notifications

Storage (if required)

Request permissions only when needed.

Never request all permissions on first launch.

---

# Notification Handling

Push Notifications

↓

FCM

↓

Notification Service

↓

Navigate to relevant screen

Examples

Booking Accepted

↓

Booking Detail

Dispute Resolved

↓

Dispute Screen

Weekly Payout

↓

Earnings

---

# Analytics

Abstract analytics.

Never call Firebase directly from UI.

```
AnalyticsService

↓

Firebase (Current)

↓

Mixpanel (Future)

↓

Amplitude (Future)
```

---

# Logging

Development

Verbose logs

Production

Minimal logs

Never log

JWT

OTP

Customer documents

Payment signatures

---

# Crash Reporting

Use Firebase Crashlytics.

Record

Unhandled Exceptions

Flutter Errors

Platform Exceptions

Non-fatal Errors

---

# Testing Strategy

Widget Tests

Repository Tests

Golden Tests

Integration Tests

Critical booking flow must have integration tests.

---

# Performance Targets

Cold Start

<2 seconds

API Response Rendering

<300 ms

Image Upload

<10 seconds

Screen Transition

<300 ms

App Size

As small as reasonably possible.

---

# Definition of Done (Flutter)

A feature is complete only if

✓ UI implemented

✓ Responsive

✓ Loading state

✓ Empty state

✓ Error state

✓ Offline behavior

✓ Repository implemented

✓ API integrated

✓ Unit tests written

✓ Widget tests written

✓ Accessibility checked

✓ Localization ready

✓ Reviewed

✓ No analyzer warnings

✓ No hardcoded strings

✓ No hardcoded colors

---

# Design System Strategy

Instead of scattering reusable widgets inside a shared app package, the UI components will be housed in a dedicated independent package:

```text
packages/
  vehicle_wash_design_system/
```

This package will contain:
- Buttons
- TextFields
- Cards
- Dialogs
- BottomSheets
- Typography
- Spacing
- Colors
- Icons
- Loading Widgets
- Empty States
- Animations

Both `vehicle_wash_customer` and `vehicle_wash_washer` will depend on this package. This guarantees perfect visual consistency across the platform, simplifies branding changes, and ensures all frontend developers work from the same unified component library.

---

# End of Flutter Architecture Document
