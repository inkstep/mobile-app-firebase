import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/pages/journey_page.dart';

void main() {
  group('Having New Journey Screen', () {
    setUp(() {
      setup();
    });

    testWidgets(
        'App should start with requesting a name if not already provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(JourneyPage());

      expect(find.text('Register'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(1));
//      expect(find.byType(OutlineButton), findsOneWidget);
//      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('Onboarding can be successfully completed with default names',
        (WidgetTester tester) async {
//      await tester.pumpWidget(app);
//      final Finder nickname = find.widgetWithText(TextFormField, 'Nickname');
//      final Finder fullName = find.widgetWithText(TextFormField, 'Full name');
//      final Finder submit = find.widgetWithText(OutlineButton, 'Register');
//
//      expect(find.text('Form submitted'), findsNothing);
//
//      await tester.enterText(nickname, 'Jess');
//      await tester.enterText(fullName, 'Jess Sampson');
//
//      await tester.tap(submit);
//      await tester.pump();
//
//      expect(find.text('Form submitted'), findsOneWidget);
    });

    testWidgets('All required elements completed', (WidgetTester tester) async {
//    await tester.pumpWidget(app);
//    final Finder submit = find.widgetWithText(OutlineButton, 'Register');
//    await tester.tap(submit);
//    await tester.pump();
//
//    expect(find.text('Nickname is required'), findsOneWidget);
//    expect(find.text('Form submitted'), findsNothing);
    });

    testWidgets('Submit disabled if not enough images selected',
        (WidgetTester tester) async {
//    await tester.pumpWidget(app);
//    final Finder submit = find.widgetWithText(OutlineButton, 'Register');
//    final Finder tos = find.byType(Checkbox);
//
//    expect(tester.widget<OutlineButton>(submit).enabled, isTrue);
//
//    await tester.tap(tos);
//    await tester.tap(submit);
//    await tester.pump();
//
//    expect(tester.widget<OutlineButton>(submit).enabled, isFalse);
//    expect(find.text('Form submitted'), findsNothing);
    });
  });
}
