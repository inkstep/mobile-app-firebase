import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';

void main() {
  group('Bold Call To Action', ()
  {
    testWidgets('renders text properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BoldCallToAction(
              label: 'label',
              onTap: () {},
            )
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('label'), findsOneWidget);
    });
  });
}
