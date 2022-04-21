import 'package:rad/rad.dart';
import 'package:rad/widgets_internals.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

void main() {
  group('DebugOptions.defaultMode', () {
    var debugService = Debug()..startService(DebugOptions.defaultMode);

    test(':: should enable development mode', () {
      expect(debugService.developmentMode, equals(true));
    });

    test(':: should disable logging', () {
      expect(debugService.frameworkLogs, equals(false));
      expect(debugService.widgetLogs, equals(false));
      expect(debugService.routerLogs, equals(false));
    });
  });

  group('DebugOptions.developmentMode', () {
    var debugService = Debug()..startService(DebugOptions.development);

    test(':: should enable development mode', () {
      expect(debugService.developmentMode, equals(true));
    });

    test(':: should enable logging', () {
      expect(debugService.frameworkLogs, equals(true));
      expect(debugService.widgetLogs, equals(true));
      expect(debugService.routerLogs, equals(true));
    });
  });

  group('DebugOptions.productionMode', () {
    var debugService = Debug()..startService(DebugOptions.production);

    test(':: should disable development mode', () {
      expect(debugService.developmentMode, equals(false));
    });

    test(':: should disable logging', () {
      expect(debugService.frameworkLogs, equals(false));
      expect(debugService.widgetLogs, equals(false));
      expect(debugService.routerLogs, equals(false));
    });
  });

  group('development mode tests', () {
    var debugService = Debug()..startService(DebugOptions.development);

    test(':: should throw exception', () {
      expect(
        () => debugService.exception('Test exception'),
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Test exception'),
          ),
        ),
      );
    });
  });

  group('production mode tests', () {
    var debugService = Debug()..startService(DebugOptions.production);

    test(':: should suppress exception', () {
      debugService.exception('Test exception');
    });
  });

  group('should respect explicit settings', () {
    test(':: development mode', () {
      var debugServiceTrue = Debug()
        ..startService(DebugOptions(developmentMode: false));

      expect(debugServiceTrue.developmentMode, equals(false));

      var debugServiceFalse = Debug()
        ..startService(DebugOptions(developmentMode: true));

      expect(debugServiceFalse.developmentMode, equals(true));
    });

    test(':: widget logs', () {
      var debugServiceTrue = Debug()
        ..startService(DebugOptions(widgetLogs: false));

      expect(debugServiceTrue.widgetLogs, equals(false));

      var debugServiceFalse = Debug()
        ..startService(DebugOptions(widgetLogs: true));

      expect(debugServiceFalse.widgetLogs, equals(true));
    });

    test(':: router logs', () {
      var debugServiceTrue = Debug()
        ..startService(DebugOptions(routerLogs: false));

      expect(debugServiceTrue.routerLogs, equals(false));

      var debugServiceFalse = Debug()
        ..startService(DebugOptions(routerLogs: true));

      expect(debugServiceFalse.routerLogs, equals(true));
    });

    test(':: framework logs', () {
      var debugServiceTrue = Debug()
        ..startService(DebugOptions(frameworkLogs: false));

      expect(debugServiceTrue.frameworkLogs, equals(false));

      var debugServiceFalse = Debug()
        ..startService(DebugOptions(frameworkLogs: true));

      expect(debugServiceFalse.frameworkLogs, equals(true));
    });
  });
}
