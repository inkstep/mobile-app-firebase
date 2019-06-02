import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/long_text_input_form_element.dart';
import 'package:mockito/mockito.dart';

class MockController extends Mock implements PageController {}

void main() {
  group('Short Text Input', () {
    testWidgets('renders label and hint properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LongTextInputFormElement(
                controller: null,
                callback: (x) {},
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
            body: LongTextInputFormElement(
                key: inputKey,
                controller: controller,
                callback: (x) {},
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
          duration: anyNamed('duration'),
          curve: anyNamed('curve'))
      );
    });
  });
}
