import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/short_text_input_form_element.dart';
import 'package:inkstep/ui/pages/new_journey_screen.dart';

void main() {
  group('Having New Journey Screen', () {
    Widget screen;

    final Offset scroll = Offset(0.0, -600.0);

    setUp(() {
      screen = MaterialApp(home: NewJourneyScreen());
    });

    testWidgets('Journey should start with requesting a name if not already provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(screen);

      expect(find.text('What do your friends call you?'), findsOneWidget);
      expect(find.byType(ShortTextInputFormElement), findsOneWidget);
    });

    testWidgets('Inspiration accessible via scroll', (WidgetTester tester) async {
      await tester.pumpWidget(screen);
      for (int i = 0; i < 1; i++) {
        await tester.drag(find.byType(PageView), scroll);
        await tester.pump();
      }

      expect(find.text('What do your friends call you?'), findsNothing);
      expect(find.text('Show us your inspiration'), findsOneWidget);
    });

    testWidgets('Description accessible via scroll', (WidgetTester tester) async {
      await tester.pumpWidget(screen);
      for (int i = 0; i < 2; i++) {
        await tester.drag(find.byType(PageView), scroll);
        await tester.pump();
      }

      expect(find.text('What do your friends call you?'), findsNothing);
      expect(find.text('Show us your inspiration'), findsNothing);
      expect(find.text('Describe the image in your head of the tattoo you want?'), findsOneWidget);
    });

    testWidgets('Position accessible via scroll', (WidgetTester tester) async {
      await tester.pumpWidget(screen);
      for (int i = 0; i < 3; i++) {
        await tester.drag(find.byType(PageView), scroll);
        await tester.pump();
      }

      expect(find.text('What do your friends call you?'), findsNothing);
      expect(find.text('Show us your inspiration'), findsNothing);
      expect(
          find.text('Describe the image in your head of the tattoo you '
              'want?'),
          findsNothing);
      expect(find.text('Where would you like your tattoo? (Arm, leg, etc)'), findsOneWidget);
    });

    testWidgets('Size accessible via scroll', (WidgetTester tester) async {
      await tester.pumpWidget(screen);
      for (int i = 0; i < 4; i++) {
        await tester.drag(find.byType(PageView), scroll);
        await tester.pump();
      }

      expect(find.text('What do your friends call you?'), findsNothing);
      expect(find.text('Show us your inspiration'), findsNothing);
      expect(
          find.text('Describe the image in your head of the tattoo you '
              'want?'),
          findsNothing);
      expect(find.text('Where would you like your tattoo? (Arm, leg, etc)'), findsNothing);
      expect(find.text('How big would you like your tattoo to be?'), findsOneWidget);
    });

    testWidgets('Availability accessible via scroll', (WidgetTester tester) async {
      await tester.pumpWidget(screen);
      for (int i = 0; i < 5; i++) {
        await tester.drag(find.byType(PageView), scroll);
        await tester.pump();
      }

      expect(find.text('What do your friends call you?'), findsNothing);
      expect(find.text('Show us your inspiration'), findsNothing);
      expect(
          find.text('Describe the image in your head of the tattoo you '
              'want?'),
          findsNothing);
      expect(find.text('Where would you like your tattoo? (Arm, leg, etc)'), findsNothing);
      expect(find.text('How big would you like your tattoo to be?'), findsNothing);
      expect(find.text('What days of the week are you normally available?'), findsOneWidget);
    });

    testWidgets('Deposite accessible via scroll', (WidgetTester tester) async {
      await tester.pumpWidget(screen);
      for (int i = 0; i < 6; i++) {
        await tester.drag(find.byType(PageView), scroll);
        await tester.pump();
      }

      expect(find.text('What do your friends call you?'), findsNothing);
      expect(find.text('Show us your inspiration'), findsNothing);
      expect(
          find.text('Describe the image in your head of the tattoo you '
              'want?'),
          findsNothing);
      expect(find.text('Where would you like your tattoo? (Arm, leg, etc)'), findsNothing);
      expect(find.text('How big would you like your tattoo to be?'), findsNothing);
      expect(find.text('What days of the week are you normally available?'), findsNothing);
      expect(find.text('Are you willing to leave a deposit?'), findsOneWidget);
    });

    testWidgets('Email accessible via scroll', (WidgetTester tester) async {
      await tester.pumpWidget(screen);
      for (int i = 0; i < 7; i++) {
        await tester.drag(find.byType(PageView), scroll);
        await tester.pump();
      }

      expect(find.text('What do your friends call you?'), findsNothing);
      expect(find.text('Show us your inspiration'), findsNothing);
      expect(
          find.text('Describe the image in your head of the tattoo you '
              'want?'),
          findsNothing);
      expect(find.text('Where would you like your tattoo? (Arm, leg, etc)'), findsNothing);
      expect(find.text('How big would you like your tattoo to be?'), findsNothing);
      expect(find.text('What days of the week are you normally available?'), findsNothing);
      expect(find.text('Are you happy to leave a deposit?'), findsNothing);
      expect(find.text('What is your email address?'), findsOneWidget);
    });

    testWidgets('Contact accessible via scroll', (WidgetTester tester) async {
      await tester.pumpWidget(screen);
      for (int i = 0; i < 8; i++) {
        await tester.drag(find.byType(PageView), scroll);
        await tester.pump();
      }

      expect(find.text('What do your friends call you?'), findsNothing);
      expect(find.text('Show us your inspiration'), findsNothing);
      expect(
          find.text('Describe the image in your head of the tattoo you '
              'want?'),
          findsNothing);
      expect(find.text('Where would you like your tattoo? (Arm, leg, etc)'), findsNothing);
      expect(find.text('How big would you like your tattoo to be?'), findsNothing);
      expect(find.text('What days of the week are you normally available?'), findsNothing);
      expect(find.text('Are you happy to leave a deposit?'), findsNothing);
      expect(find.text('What is your email address?'), findsNothing);
      expect(find.text('Check your details!'), findsOneWidget);
    });

    testWidgets('Error with imcomplete form', (WidgetTester tester) async {
      await tester.pumpWidget(screen);
      for (int i = 0; i < 9; i++) {
        await tester.drag(find.byType(PageView), scroll);
        await tester.pump();
      }
      await tester.tap(find.text('Check your details!'));
      await tester.pump();

      expect(find.text('Check your details!'), findsOneWidget);
    });
  });
}
