import 'package:rad/rad.dart';
import 'package:rad/widgets_html.dart';
import 'package:rad_test/rad_test.dart';
import 'package:test/expect.dart';

void main() {
  testWidgets(
    'collectAllWidgetObjectsFrom goes in LTR DFS',
    (tester) async {
      var key = const GlobalKey('widget');

      await tester.pumpWidget(
        Division(
          key: key,
          child: const Paragraph(
            children: [
              Text('a'),
              Text('b'),
            ],
          ),
        ),
      );

      var widgetObject = tester.getWidgetObjectByGlobalKey(key)!;

      final wObjects = collectAllWidgetObjectsFrom(
        widgetObject,
        skipOffstage: false,
      ).toList();

      expect(wObjects.length, 3);

      expect(wObjects[0].widget, isA<Paragraph>());

      expect(wObjects[1].widget, isA<Text>());
      expect((wObjects[1].widget as Text).text, 'a');

      expect(wObjects[2].widget, isA<Text>());
      expect((wObjects[2].widget as Text).text, 'b');
    },
  );
}
