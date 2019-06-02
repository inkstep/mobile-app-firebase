import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:mockito/mockito.dart';

class MockController extends Mock implements PageController {}

void main() {
  group('Form Element Builder', ()
  {
    testWidgets('Builds Text Object', (WidgetTester tester) async {
      Text text = Text('test');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: FormElementBuilder(
                onSubmitCallback: (String ) {},
                controller: null,
                builder: (BuildContext context, FocusNode focus,
                    SubmitCallbackonSubmit) {return text;},
              )
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('test'), findsOneWidget);
    });

    testWidgets('Passes callback correctly', (WidgetTester tester) async {
      String testData = '';

      PageController pageController = MockController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: FormElementBuilder(
                onSubmitCallback: (text) {
                  testData = text;
                },
                controller: pageController,
                builder: (BuildContext context, FocusNode focus,
                    SubmitCallbackonSubmit) {
                  return FlatButton(
                    onPressed: () {
                      SubmitCallbackonSubmit('test');
                    },
                    child: null,
                  );
                },
              )
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(FlatButton));
      await tester.pump();

      expect(testData, 'test');
    });
  });
}
