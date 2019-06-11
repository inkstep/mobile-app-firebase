import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/large_two_part_header.dart';

void main() {
  group('Welcome back header', () {
    testWidgets('renders text properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: LargeTwoPartHeader(
            name: 'Jimmy',
            taskStatus: 27,
          )),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Jimmy'), findsOneWidget);
      expect(find.text('You have 27 journey tasks to complete'), findsOneWidget);
    });
  });
}
