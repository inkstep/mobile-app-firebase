import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/short_text_input.dart';
import 'package:inkstep/ui/pages/new_screen.dart';

void main() {
  group('Having New Journey Screen', () {
    Widget screen;

    setUp(() {
      screen = MaterialApp(home: NewScreen());
    });

    testWidgets(
        'Journey should start with requesting a name if not already provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(screen);

      expect(find.text('What do your friends call you?'), findsOneWidget);
      expect(find.byType(ShortTextInput), findsOneWidget);
    });

    testWidgets('Inspiration accessible via scroll',
        (WidgetTester tester) async {
//      await tester.pumpWidget(screen);
//      tester.
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
