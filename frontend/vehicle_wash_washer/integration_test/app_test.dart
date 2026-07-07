import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vehicle_wash_washer/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Washer E2E Journey', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Login Screen
    expect(find.text('Welcome'), findsOneWidget);
    
    // Enter mobile number
    await tester.enterText(find.byType(TextField), '1234567890');
    await tester.pumpAndSettle();
    
    // Tap Continue
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // OTP Screen
    expect(find.text('Verification'), findsOneWidget);
    
    // Enter OTP
    await tester.enterText(find.byType(TextField), '123456');
    await tester.pumpAndSettle();

    // Tap Verify & Login
    await tester.tap(find.text('Verify & Login'));
    await tester.pumpAndSettle();

    // Onboarding Screen
    expect(find.text('Complete Your Profile'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(0), 'John Doe');
    await tester.enterText(find.byType(TextField).at(1), '1234567890');
    
    await tester.ensureVisible(find.text('Upload Document'));
    await tester.tap(find.text('Upload Document'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Submit Application'));
    await tester.tap(find.text('Submit Application'));
    await tester.pumpAndSettle();

    // Dashboard Screen
    expect(find.text('Dashboard'), findsWidgets);

    // Toggle Availability
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    // Accept incoming booking request
    expect(find.text('Booking Requests'), findsWidgets);
    await tester.tap(find.text('View Request'));
    await tester.pumpAndSettle();

    // Incoming Request Screen
    expect(find.text('New Booking Request!'), findsWidgets);
    await tester.tap(find.text('Accept Job'));
    await tester.pumpAndSettle();

    // Current Job Screen
    expect(find.text('Active Job'), findsWidgets);
    
    await tester.ensureVisible(find.text('Start Navigation'));
    await tester.tap(find.text('Start Navigation'));
    await tester.pumpAndSettle();
    
    await tester.ensureVisible(find.text('Arrived - Start Wash'));
    await tester.tap(find.text('Arrived - Start Wash'));
    await tester.pumpAndSettle();
    
    await tester.ensureVisible(find.text('Finish & Upload Photos'));
    await tester.tap(find.text('Finish & Upload Photos'));
    await tester.pumpAndSettle();

    // Media Upload Screen
    expect(find.text('Upload Photos'), findsWidgets);
    
    // Capture Before Photo
    await tester.tap(find.text('Tap to Capture').first);
    await tester.pumpAndSettle();
    
    // Capture After Photo (Now it's the first again because the previous one says 'Captured')
    await tester.tap(find.text('Tap to Capture').first);
    await tester.pumpAndSettle();
    
    // Submit
    await tester.ensureVisible(find.text('Submit & View Summary'));
    await tester.tap(find.text('Submit & View Summary'));
    await tester.pumpAndSettle();

    // Job Summary Screen
    expect(find.text('Job Completed'), findsWidgets);
    await tester.ensureVisible(find.text('Return to Dashboard'));
    await tester.tap(find.text('Return to Dashboard'));
    await tester.pumpAndSettle();
    
    // Back to Dashboard
    expect(find.text('Dashboard'), findsWidgets);
  });
}
