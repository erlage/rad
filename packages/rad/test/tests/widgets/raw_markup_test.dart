// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  group('RawMarkUp widget tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should render raw markup', () async {
      await app!.buildChildren(
        widgets: [
          RawMarkUp(
            '<div id="raw">s</div>',
            //
            // so we can get domNode associated with raw markup
            //
            key: Key('widget'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var rawElement = app!.domNodeByKeyValue('widget');

      expect(rawElement.innerHtml, equals('<div id="raw">s</div>'));
    });

    test('should allow scripts', () async {
      await app!.buildChildren(
        widgets: [
          RawMarkUp(
            '''
            <div id="raw"></div>

            <script>
              document.getElementById('raw').innerText = 'hw';
            </script>
            ''',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.domNodeById('raw').innerHtml, equals('hw'));
    });

    test('should update raw markup', () async {
      await app!.buildChildren(
        widgets: [
          RawMarkUp('<div id="raw">nothing</div>'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.domNodeById('raw').innerHtml, equals('nothing'));

      await app!.updateChildren(
        widgets: [
          RawMarkUp('<div id="raw">updated</div>'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.domNodeById('raw').innerHtml, equals('updated'));
    });
  });
}
