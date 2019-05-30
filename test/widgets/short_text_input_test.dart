import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

void main() {
  group('Short Text Input', () {
    testWidgets('renders label and hint properly', (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(
              home: Scaffold(
                  body: ShortTextInput(
                      null,
                      label: 'label',
                      hint: 'hint')
              )
          )
      );
      await tester.pumpAndSettle();
      expect(find.text('label'), findsOneWidget);
      expect(find.text('hint'), findsOneWidget);
    });
  });
}
