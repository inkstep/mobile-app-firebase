import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/profile_row.dart';

void main() {
  group('Artist Selection', () {
    testWidgets('renders text properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: ProfileRow(
            name: 'Ricky Williams',
            studioName: 'South City Market',
            imagePath: 'assets/ricky.png',
            artistID: 1,
          )),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Ricky Williams'), findsOneWidget);
      expect(find.text('South City Market'), findsOneWidget);
    });

    testWidgets('Can build with invalid image path', (WidgetTester tester) async {
      final ProfileRow artistProfileRow = ProfileRow(
        name: 'Ricky Williams',
        studioName: 'South City Market',
        artistID: 1,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: artistProfileRow),
        ),
      );

      await tester.pumpAndSettle();
    });
  });
}
