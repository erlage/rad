import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/matchers.dart';
import 'package:rad_test/src/modules/testers.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('enter text test', () {
    testWidgets('should enter text', (tester) async {
      const gkey = GlobalKey('input');

      await tester.pumpWidget(
        const Input(key: gkey),
      );

      await tester.enterText(tester.find.byType(Input), 'hello world');

      expect(tester.getDomNodeByGlobalKey(gkey), hasValue('hello world'));
    });

    testWidgets('should clear old text', (tester) async {
      const gkey = GlobalKey('input');

      await tester.pumpWidget(
        const Input(key: gkey, value: 'some text'),
      );

      expect(tester.getDomNodeByGlobalKey(gkey), hasValue('some text'));

      await tester.enterText(tester.find.byType(Input), '');
      expect(tester.getDomNodeByGlobalKey(gkey), hasValue(''));
    });
  });

  group('focus test', () {
    testWidgets('should not focus by default', (tester) async {
      const gkey = GlobalKey('input');

      await tester.pumpWidget(
        const Input(key: gkey),
      );

      expect(tester.getDomNodeByGlobalKey(gkey), nodeHasNotFocus);
    });

    testWidgets('should focus', (tester) async {
      const gkey = GlobalKey('input');

      await tester.pumpWidget(
        const Input(key: gkey),
      );

      await tester.focus(tester.find.byType(Input));

      expect(tester.getDomNodeByGlobalKey(gkey), nodeHasFocus);
    });
  });
}
