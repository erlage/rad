import 'package:rad/rad.dart';
import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

/*
|--------------------------------------------------------------------------
| Comnponent test for core/classes/debug.dart
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | Debug default options test
  |--------------------------------------------------------------------------
  */

  group('implicit default options', () {
    setUp(() {
      Framework.init(routingPath: '');
    });
    tearDown(Framework.tearDown);

    test(':: should enable development mode', () {
      expect(Debug.developmentMode, equals(true));
    });

    test(':: should disable logging', () {
      expect(Debug.frameworkLogs, equals(false));
      expect(Debug.widgetLogs, equals(false));
      expect(Debug.routerLogs, equals(false));
    });
  });

  group('explicit default options', () {
    setUp(() {
      Framework.init(routingPath: '', debugOptions: DebugOptions.defaultMode);
    });
    tearDown(Framework.tearDown);

    test(':: should enable development mode', () {
      expect(Debug.developmentMode, equals(true));
    });

    test(':: should disable logging', () {
      expect(Debug.frameworkLogs, equals(false));
      expect(Debug.widgetLogs, equals(false));
      expect(Debug.routerLogs, equals(false));
    });
  });

  group('production mode', () {
    setUp(() {
      Framework.init(routingPath: '', debugOptions: DebugOptions.production);
    });
    tearDown(Framework.tearDown);

    test(':: should disable development mode', () {
      expect(Debug.developmentMode, equals(false));
    });

    test(':: should disable logging', () {
      expect(Debug.frameworkLogs, equals(false));
      expect(Debug.widgetLogs, equals(false));
      expect(Debug.routerLogs, equals(false));
    });
  });

  group('development mode', () {
    setUp(() {
      Framework.init(routingPath: '', debugOptions: DebugOptions.development);
    });
    tearDown(Framework.tearDown);

    test(':: should enable development mode', () {
      expect(Debug.developmentMode, equals(true));
    });

    test(':: should enable logging', () {
      expect(Debug.frameworkLogs, equals(true));
      expect(Debug.widgetLogs, equals(true));
      expect(Debug.routerLogs, equals(true));
    });
  });
}
