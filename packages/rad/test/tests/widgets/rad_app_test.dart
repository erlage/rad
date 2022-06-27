// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  group('RadApp widget tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should render child', () async {
      await app!.buildChildren(
        widgets: [
          RadApp(child: Text('contents')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('contents'));
    });

    test('should update child', () async {
      await app!.buildChildren(
        widgets: [
          RadApp(child: Text('contents')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('contents'));

      await app!.updateChildren(
        widgets: [
          RadApp(child: Text('updated contents')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('updated contents'));
    });

    test(
      'should act as normal widget(multiple instance for example)',
      () async {
        await app!.buildChildren(
          widgets: [
            RadApp(child: Text('1')),
            RadApp(child: Text('2')),
            RadApp(child: Text('3')),
            RadApp(child: Text('4')),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3|4'));

        await app!.updateChildren(
          widgets: [
            RadApp(child: Text('4')),
            RadApp(child: Text('3')),
            RadApp(child: Text('2')),
            RadApp(child: Text('1')),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('4|3|2|1'));

        await app!.updateChildren(
          widgets: [
            RadApp(child: Text('1')),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1'));
      },
    );
  });
}
