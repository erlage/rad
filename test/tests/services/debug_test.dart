import 'package:rad/rad.dart';
import 'package:rad/widgets_internals.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

import '../../fixers/test_bed.dart';

void main() {
  group('DebugOptions.defaultMode', () {
    DebugService? debugService;

    setUp(() {
      debugService = DebugService(
        RT_TestBed.rootContext,
        DebugOptions.defaultMode,
      )..startService();
    });

    tearDown(() => debugService!.stopService());

    test(':: should enable development mode', () {
      expect(debugService!.additionalChecks, equals(true));
    });

    test(':: should disable logging', () {
      expect(debugService!.frameworkLogs, equals(false));
      expect(debugService!.widgetLogs, equals(false));
      expect(debugService!.routerLogs, equals(false));
    });
  });

  group('DebugOptions.developmentMode', () {
    DebugService? debugService;

    setUp(() {
      debugService = DebugService(
        RT_TestBed.rootContext,
        DebugOptions.developmentMode,
      )..startService();
    });

    tearDown(() => debugService!.stopService());

    test(':: should enable development mode', () {
      expect(debugService!.additionalChecks, equals(true));
    });

    test(':: should enable logging', () {
      expect(debugService!.frameworkLogs, equals(true));
      expect(debugService!.widgetLogs, equals(true));
      expect(debugService!.routerLogs, equals(true));
    });
  });

  group('DebugOptions.productionMode', () {
    DebugService? debugService;

    setUp(() {
      debugService = DebugService(
        RT_TestBed.rootContext,
        DebugOptions.productionMode,
      )..startService();
    });

    tearDown(() => debugService!.stopService());

    test(':: should disable development mode', () {
      expect(debugService!.additionalChecks, equals(false));
    });

    test(':: should disable logging', () {
      expect(debugService!.frameworkLogs, equals(false));
      expect(debugService!.widgetLogs, equals(false));
      expect(debugService!.routerLogs, equals(false));
    });
  });

  group('development mode tests', () {
    DebugService? debugService;

    setUp(() {
      debugService = DebugService(
        RT_TestBed.rootContext,
        DebugOptions.developmentMode,
      )..startService();
    });

    tearDown(() => debugService!.stopService());

    test(':: should throw exception', () {
      expect(
        () => debugService!.exception('Test exception'),
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Test exception'),
          ),
        ),
      );
    });
  });

  group('production mode tests', () {
    DebugService? debugService;

    setUp(() {
      debugService = DebugService(
        RT_TestBed.rootContext,
        DebugOptions.productionMode,
      )..startService();
    });

    tearDown(() => debugService!.stopService());

    test(':: should suppress exception', () {
      debugService!.exception('Test exception');
    });
  });

  group('should respect explicit settings', () {
    test(':: DebugOptions.additionalChecks', () {
      var debugServiceFalse = DebugService(
        RT_TestBed.rootContext,
        DebugOptions(additionalChecks: false),
      )..startService();

      expect(debugServiceFalse.additionalChecks, equals(false));

      var debugServiceTrue = DebugService(
        RT_TestBed.rootContext,
        DebugOptions(additionalChecks: true),
      )..startService();

      expect(debugServiceTrue.additionalChecks, equals(true));
    });

    test(':: DebugOptions.widgetLogs', () {
      var debugServiceFalse = DebugService(
        RT_TestBed.rootContext,
        DebugOptions(widgetLogs: false),
      )..startService();

      expect(debugServiceFalse.widgetLogs, equals(false));

      var debugServiceTrue = DebugService(
        RT_TestBed.rootContext,
        DebugOptions(widgetLogs: true),
      )..startService();

      expect(debugServiceTrue.widgetLogs, equals(true));
    });

    test(':: DebugOptions.routerLogs', () {
      var debugServiceFalse = DebugService(
        RT_TestBed.rootContext,
        DebugOptions(routerLogs: false),
      )..startService();

      expect(debugServiceFalse.routerLogs, equals(false));

      var debugServiceTrue = DebugService(
        RT_TestBed.rootContext,
        DebugOptions(routerLogs: true),
      )..startService();

      expect(debugServiceTrue.routerLogs, equals(true));
    });

    test(':: DebugOptions.frameworkLogs', () {
      var debugServiceFalse = DebugService(
        RT_TestBed.rootContext,
        DebugOptions(frameworkLogs: false),
      )..startService();

      expect(debugServiceFalse.frameworkLogs, equals(false));

      var debugServiceTrue = DebugService(
        RT_TestBed.rootContext,
        DebugOptions(frameworkLogs: true),
      )..startService();

      expect(debugServiceTrue.frameworkLogs, equals(true));
    });

    test(':: DebugOptions.suppressExceptions', () {
      var debugServiceFalse = DebugService(
        RT_TestBed.rootContext,
        DebugOptions(suppressExceptions: false),
      )..startService();

      expect(
        () => debugServiceFalse.exception('Test exception'),
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Test exception'),
          ),
        ),
      );

      var debugServiceTrue = DebugService(
        RT_TestBed.rootContext,
        DebugOptions(suppressExceptions: true),
      )..startService();

      debugServiceTrue.onException(Exception('Test exception'));
    });
  });
}
