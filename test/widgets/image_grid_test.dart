import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/ui/pages/new/image_grid.dart';
import 'package:mockito/mockito.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MockController extends Mock implements PageController {}

void main() {
  group('Image Grid', () {
    final PageController controller = MockController();

    MaterialApp _buildImageGrid({List<Asset> images}) {
      return MaterialApp(
        home: Scaffold(
          body: ImageGrid(
            images: images ?? const <Asset>[],
            submitCallback: () {
              controller.nextPage(duration: Duration(milliseconds: 1), curve: Curves.ease);
            },
            updateCallback: (list) {},
          ),
        ),
      );
    }

    testWidgets('renders text properly', (WidgetTester tester) async {
      await tester.pumpWidget(_buildImageGrid());

      await tester.pumpAndSettle();
      expect(find.text('Show us your inspiration'), findsOneWidget);
    });

    testWidgets('Advancement button only appears when >1 image provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(_buildImageGrid());

      await tester.pumpAndSettle();
      expect(find.text('That enough?'), findsNothing);
    });

    testWidgets('Pressing Ok advances', (WidgetTester tester) async {
      await tester.pumpWidget(_buildImageGrid(images: [
        Asset('_identifier', 'some name', 50, 40),
        Asset('_identifier', 'some name', 50, 40)
      ]));
      await tester.pump();

      await tester.tap(find.text('Next!'));
      await tester.pump();

      verify(controller.nextPage(duration: anyNamed('duration'), curve: anyNamed('curve')));
    });
  });
}
