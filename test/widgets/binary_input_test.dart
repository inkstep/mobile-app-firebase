import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:mockito/mockito.dart';

class MockController extends Mock implements PageController {}

void main() {
  group('Binary Input', () {
    testWidgets('renders text properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: BinaryInput(
            label: 'label',
            currentState: buttonState.Unset,
            callback: (text) {},
          )),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('label'), findsOneWidget);
      expect(find.text('Yes'), findsOneWidget);
      expect(find.text('No'), findsOneWidget);
    });
  });
}
