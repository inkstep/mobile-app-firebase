import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/blocs/journey_bloc.dart';
import 'package:inkstep/main.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/ui/components/text_button.dart';
import 'package:inkstep/ui/pages/info_gathering.dart';
import 'package:inkstep/ui/pages/journey_page.dart';
import 'package:inkstep/ui/pages/onboarding.dart';
import 'package:mockito/mockito.dart';

class MockJourneyBloc extends Mock implements JourneyBloc {}

void main() {
  testWidgets('App should start with onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(Inkstep());
    expect(find.byType(Inkstep), findsOneWidget);
    expect(find.byType(Onboarding), findsOneWidget);
  });

  testWidgets('Can get to journey page from onboarding',
      (WidgetTester tester) async {
    await tester.pumpWidget(Onboarding(MockJourneyBloc()));

    final Finder journeyButton = find.byType(TextButton);
    await tester.tap(journeyButton);
    await tester.pump();

    expect(find.byType(JourneyPage), findsOneWidget);
  });

  testWidgets('Can get to new journey page from onboarding',
      (WidgetTester tester) async {
    await tester.pumpWidget(Onboarding(MockJourneyBloc()));

    final Finder journeyButton = find.byType(BoldCallToAction);
    await tester.tap(journeyButton);
    await tester.pump();

    expect(find.byType(InfoScreen), findsOneWidget);
  });
}
