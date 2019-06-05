import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:mockito/mockito.dart';

class MockController extends Mock implements PageController {}

void main() {
  group('Binary Input', ()
  {
    testWidgets('renders text properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: BinaryInput(
                label: 'label',
                controller: null,
                currentState: buttonState.Unset,
                callback: (text) {},
              )
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('label'), findsOneWidget);
      expect(find.text('Yes'), findsOneWidget);
      expect(find.text('No'), findsOneWidget);
    });

    testWidgets('Pressing Yes advances', (WidgetTester tester) async {
      final PageController controller = MockController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: BinaryInput(
                label: 'label',
                controller: controller,
                currentState: buttonState.Unset,
                callback: (text) {},
              )
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Yes'));
      await tester.pump();

      verify(controller.nextPage(
          duration: anyNamed('duration'), curve: anyNamed('curve'))
      );
    });

    testWidgets('Pressing No advances', (WidgetTester tester) async {
      final PageController controller = MockController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: BinaryInput(
                label: 'label',
                controller: controller,
                currentState: buttonState.Unset,
                callback: (text) {},
              )
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('No'));
      await tester.pump();

      verify(controller.nextPage(
          duration: anyNamed('duration'), curve: anyNamed('curve'))
      );
    });
  });
}