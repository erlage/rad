import 'package:rad/rad.dart';
import 'package:rad/widgets_html.dart';
import 'package:rad_test/rad_test.dart';
import 'package:rad_test/src/modules/all_elements.dart';
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

      var renderElement = tester.getRenderElementByGlobalKey(key)!;

      final rElements = collectAllWidgetObjectsFrom(
        renderElement,
        skipOffstage: false,
      ).toList();

      expect(rElements.length, 3);

      expect(rElements[0].widget, isA<Paragraph>());

      expect(rElements[1].widget, isA<Text>());
      expect((rElements[1].widget as Text).text, 'a');

      expect(rElements[2].widget, isA<Text>());
      expect((rElements[2].widget as Text).text, 'b');
    },
  );
}
