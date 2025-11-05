import 'package:flutter_test/flutter_test.dart';
import 'package:pulsex/main.dart';

void main() {
  testWidgets('Feed screen shows news cards', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PulseXApp());
    
    // TODO: Add proper tests for feed loading and display
    expect(find.text('PulseX'), findsOneWidget);
  });
}