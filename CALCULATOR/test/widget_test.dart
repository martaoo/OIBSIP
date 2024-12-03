import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/main.dart'; // Import the correct file

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CalculatorApp());

    // Verify that the initial state or behavior matches the test requirements.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap a button with a '+' icon and trigger a frame.
    // Update this logic if your app doesn't have a '+' button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the counter incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
