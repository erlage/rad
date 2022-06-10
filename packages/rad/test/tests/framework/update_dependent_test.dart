import 'package:rad_test/rad_test.dart';

import '../../test_imports.dart';

void main() {
  group('update dependent tests:', () {
    testWidgets('should call update on dependent', (tester) async {
      var gkey = GlobalKey('gkey');

      await tester.pumpWidget(
        RT_TestWidget(
          key: gkey,
          roEventHookUpdate: () => tester.push('update'),
        ),
      );

      var wo = tester.getWidgetObjectByGlobalKey(gkey)!;

      await tester.updateContextAsIfDependant(wo.context);
      await tester.updateContextAsIfDependant(wo.context);

      tester.assertMatchStack([
        'update',
        'update',
      ]);
    });

    testWidgets('should set update type to dependencyChanged', (tester) async {
      var gkey = GlobalKey('gkey');

      await tester.pumpWidget(
        RT_TestWidget(
          key: gkey,
          roHookUpdate: (type) => tester.push(type.name),
        ),
      );

      var wo = tester.getWidgetObjectByGlobalKey(gkey)!;

      await tester.updateContextAsIfDependant(wo.context);
      await tester.updateContextAsIfDependant(wo.context);

      tester.assertMatchStack([
        UpdateType.dependencyChanged.name,
        UpdateType.dependencyChanged.name,
      ]);
    });
  });
}
