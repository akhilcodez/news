import 'package:flutter_test/flutter_test.dart';
import 'package:agroworld_flutter/main.dart';

void main() {
  testWidgets('AgroWorldApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AgroWorldApp());
    expect(find.byType(AgroWorldApp), findsOneWidget);
    // Advance timers so splash animation and navigation timer complete cleanly
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();
  });
}
