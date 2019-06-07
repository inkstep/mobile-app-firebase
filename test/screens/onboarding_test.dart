import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/ui/components/text_button.dart';
import 'package:inkstep/ui/pages/onboarding.dart';
import 'package:inkstep/utils/screen_navigator.dart';
import 'package:mockito/mockito.dart';

class MockNavigator extends Mock implements ScreenNavigator {}

void main() {
  group('Having Onboarding Screen', () {
    final MockNavigator nav = MockNavigator();
    Widget app;

    setUp(() {
      setup();
      sl.allowReassignment = true;
      sl.registerFactory<ScreenNavigator>(() => nav);
      app = MaterialApp(
        home: Onboarding(),
      );
    });

//    testWidgets('renders correctly', (WidgetTester tester) async {
//      await tester.pumpWidget(
//        MaterialApp(
//          home: Onboarding(),
//        ),
//      );
//
//      await tester.pumpAndSettle();
//      expect(find.text('Hi there,'), findsOneWidget);
//    });

    testWidgets('Can get to journey page from onboarding', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      final Finder button = find.byType(TextButton);
      expect(button, findsOneWidget);

      await tester.tap(button);
      await tester.pump();

      verify(nav.openViewJourneysScreenWithNewDevice(any));
    });

    testWidgets('Can get to artist page from onboarding', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      final Finder button = find.byType(BoldCallToAction);
      expect(button, findsOneWidget);

      await tester.tap(button);
      await tester.pump();

      verify(nav.openArtistSelection(any));
    });
  });
}
