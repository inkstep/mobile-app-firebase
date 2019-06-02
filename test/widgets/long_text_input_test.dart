import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/long_text_input.dart';
import 'package:mockito/mockito.dart';

class MockController extends Mock implements PageController {}

void main() {
  group('Long Text Input', () {
    testWidgets('renders label and hint properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LongTextInput(
              callback: (x) {},
              hint: 'hint',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('label'), findsOneWidget);
      expect(find.text('hint'), findsOneWidget);
    });
  });
}
