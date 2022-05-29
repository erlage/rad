import '../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | Browser window test
  |--------------------------------------------------------------------------
  */

  // tests below are bit leaky, run them in order

  group('Browser window tests', () {
    BrowserWindow? browserWindow;
    RT_TestPopStateListener? testListener;

    setUp(() {
      browserWindow = BrowserWindow();
      testListener = RT_TestPopStateListener();
    });

    tearDown(() {
      browserWindow = null;
      testListener = null;
    });

    test('should replace state', () async {
      browserWindow!.addPopStateListener(
        callback: testListener!.listener,
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyReplaceState(
        title: '/',
        url: '/',
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyReplaceState(
        title: '/',
        url: '/',
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyBack(context: RT_TestBed.rootContext);
      await Future.delayed(Duration(milliseconds: 100));

      expect(testListener!.events.isEmpty, equals(true));
    });

    test('should add a listener', () async {
      browserWindow!.addPopStateListener(
        callback: testListener!.listener,
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyPushState(
        title: '/',
        url: '/',
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyPushState(
        title: '/',
        url: '/',
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyBack(context: RT_TestBed.rootContext);
      await Future.delayed(Duration(milliseconds: 100));

      expect(testListener!.events.isNotEmpty, equals(true));
    });

    test('should add only one listener per app instance', () async {
      browserWindow!.addPopStateListener(
        callback: testListener!.listener,
        context: RT_TestBed.rootContext,
      );

      browserWindow!.addPopStateListener(
        callback: testListener!.listener,
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyPushState(
        title: '/',
        url: '/',
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyPushState(
        title: '/',
        url: '/',
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyBack(context: RT_TestBed.rootContext);
      await Future.delayed(Duration(milliseconds: 100));

      expect(testListener!.events.length, equals(1));
    });

    test('should remove listener requests', () async {
      browserWindow!.addPopStateListener(
        callback: testListener!.listener,
        context: RT_TestBed.rootContext,
      );

      browserWindow!.removePopStateListener(RT_TestBed.rootContext);

      browserWindow!.historyPushState(
        title: '',
        url: '/',
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyPushState(
        title: '',
        url: '/',
        context: RT_TestBed.rootContext,
      );

      browserWindow!.historyBack(context: RT_TestBed.rootContext);
      await Future.delayed(Duration(milliseconds: 100));

      expect(testListener!.events.isEmpty, equals(true));
    });

    test('should return href', () {
      expect(browserWindow!.locationHref, window.location.href);
    });

    test('should return hash', () {
      expect(browserWindow!.locationHash, window.location.hash);

      window.location.hash = '${window.location.hash}/updated';

      expect(browserWindow!.locationHash, window.location.hash);
    });

    test('should return path name', () {
      expect(browserWindow!.locationPathName, window.location.pathname);

      window.location.pathname = '${window.location.pathname}/updated';

      expect(browserWindow!.locationPathName, window.location.pathname);
    });
  });
}
