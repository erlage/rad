// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

@Skip(
  'these tests are bit leaky and mutate globals. '
  'run them in isolation, once in a while',
)

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
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyReplaceState(
        title: '/',
        url: '/',
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyReplaceState(
        title: '/',
        url: '/',
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyBack(rootElement: RT_TestBed.rootRenderElement);
      await Future.delayed(Duration(milliseconds: 100));

      expect(testListener!.events.isEmpty, equals(true));
    });

    test('should add a listener', () async {
      browserWindow!.addPopStateListener(
        callback: testListener!.listener,
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyPushState(
        title: '/',
        url: '/',
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyPushState(
        title: '/',
        url: '/',
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyBack(rootElement: RT_TestBed.rootRenderElement);
      await Future.delayed(Duration(milliseconds: 100));

      expect(testListener!.events.isNotEmpty, equals(true));
    });

    test('should add only one listener per app instance', () async {
      browserWindow!.addPopStateListener(
        callback: testListener!.listener,
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.addPopStateListener(
        callback: testListener!.listener,
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyPushState(
        title: '/',
        url: '/',
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyPushState(
        title: '/',
        url: '/',
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyBack(rootElement: RT_TestBed.rootRenderElement);
      await Future.delayed(Duration(milliseconds: 100));

      expect(testListener!.events.length, equals(1));
    });

    test('should remove listener requests', () async {
      browserWindow!.addPopStateListener(
        callback: testListener!.listener,
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.removePopStateListener(RT_TestBed.rootRenderElement);

      browserWindow!.historyPushState(
        title: '',
        url: '/',
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyPushState(
        title: '',
        url: '/',
        rootElement: RT_TestBed.rootRenderElement,
      );

      browserWindow!.historyBack(rootElement: RT_TestBed.rootRenderElement);
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
