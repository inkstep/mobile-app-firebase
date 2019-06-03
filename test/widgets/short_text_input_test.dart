import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/short_text_input.dart';
import 'package:mockito/mockito.dart';

class MockController extends Mock implements PageController {}

void main() {
  group('Short Text Input', () {
    testWidgets('renders label and hint properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShortTextInput(
              callback: (x) {},
              label: 'label',
              hint: 'hint',
              maxLength: 40,
              controller: null,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('label'), findsOneWidget);
      expect(find.text('hint'), findsOneWidget);
    });

    testWidgets('max length works correct', (WidgetTester tester) async {
      final inputKey = UniqueKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShortTextInput(
              key: inputKey,
              callback: (x) {},
              label: 'label',
              hint: 'hint',
              maxLength: 4,
              controller: null,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(inputKey), 'matthew');

      expect(find.text('matt'), findsOneWidget);
    });
  });
}
