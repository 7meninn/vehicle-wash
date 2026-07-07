import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vehicle_wash_customer/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Customer E2E Journey', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Login Screen
    expect(find.text('Welcome'), findsOneWidget);
    
    // Enter mobile number
    await tester.enterText(find.bySemanticsLabel('Mobile Number'), '+1234567890');
    await tester.pumpAndSettle();
    
    // Tap Continue
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // OTP Screen
    expect(find.text('Verification'), findsOneWidget);
    
    // Enter OTP
    await tester.enterText(find.bySemanticsLabel('OTP Code'), '123456');
    await tester.pumpAndSettle();

    // Tap Verify & Login
    await tester.tap(find.text('Verify & Login'));
    await tester.pumpAndSettle();

    // Home Screen
    expect(find.text('Welcome Back'), findsOneWidget);

    // Tap Book Wash
    await tester.tap(find.text('Book a Wash'));
    await tester.pumpAndSettle();

    // Select Vehicle
    expect(find.text('Select Vehicle'), findsWidgets);
    await tester.tap(find.text('Toyota Camry'));
    await tester.pumpAndSettle();
    
    await tester.tap(find.text('Continue to Address'));
    await tester.pumpAndSettle();

    // Select Address
    expect(find.text('Select Address'), findsWidgets);
    await tester.tap(find.text('Home').first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue to Schedule'));
    await tester.pumpAndSettle();

    // Select Time
    expect(find.text('Select Time'), findsWidgets);
    await tester.tap(find.text('Today, Oct 24'));
    await tester.pumpAndSettle();
    
    await tester.tap(find.text('09:00 AM'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('View Estimate'));
    await tester.pumpAndSettle();

    // Price Estimate
    expect(find.text('Price Estimate'), findsWidgets);
    await tester.tap(find.text('Confirm Booking'));
    await tester.pumpAndSettle();

    // Mock Payment
    expect(find.text('Simulate Payment'), findsWidgets);
    await tester.tap(find.text('Pay Success'));
    await tester.pumpAndSettle();
  });
}
