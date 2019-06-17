import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/short_text_input_form_element.dart';
import 'package:mockito/mockito.dart';

class MockController extends Mock implements PageController {}

void main() {
  group('Short Text Input Form Element', () {
    testWidgets('renders label and hint properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShortTextInputFormElement(
                textController: null,
                label: 'label',
                hint: 'hint'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('label'), findsOneWidget);
      expect(find.text('hint'), findsOneWidget);
    });

    testWidgets('transitions to next view on enter',
        (WidgetTester tester) async {
      final PageController controller = MockController();

      final inputKey = UniqueKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShortTextInputFormElement(
                key: inputKey,
                textController: null,
                label: 'label',
                hint: 'hint'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(inputKey), 'matthew');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('matthew'), findsOneWidget);

      verify(controller.nextPage(
          duration: anyNamed('duration'), curve: anyNamed('curve'))
      );
    });

    testWidgets('max length works correct', (WidgetTester tester) async {
      final inputKey = UniqueKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ShortTextInputFormElement(
              key: inputKey,
              textController: null,
              label: 'label',
              hint: 'hint',
              maxLength: 4,
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
