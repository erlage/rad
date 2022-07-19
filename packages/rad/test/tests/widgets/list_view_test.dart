// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

// commited by mistake, file is not complete.

void main() {
  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  group('ListView basic tests:', () {
    test('should build child widgets', () async {
      await app!.buildChildren(
        widgets: [
          ListView(children: [
            Text('w1'),
            Text('w2'),
            Text('w3'),
          ])
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents('w1|w2|w3'));
    });

    test('should update child widgets', () async {
      await app!.buildChildren(
        widgets: [
          ListView(children: [
            Text('w1'),
            Text('w2'),
            Text('w3'),
          ])
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          ListView(children: [
            Text('w1'),
            Text('w3'),
            Text('w2'),
          ])
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents('w1|w3|w2'));
    });

    test('should removed if removed from updated list of childs', () async {
      await app!.buildChildren(
        widgets: [
          ListView(children: [
            Text('w1'),
            Text('w2'),
            Text('w3'),
          ])
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          ListView(children: [
            Text('w1'),
          ])
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents('w1'));
    });

    test('should add if added to updated list of childs', () async {
      await app!.buildChildren(
        widgets: [
          ListView(children: [
            Text('w1'),
          ])
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          ListView(children: [
            Text('w1'),
            Text('w2'),
          ])
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents('w1|w2'));
    });

    test('should clear if updated child list is empty', () async {
      await app!.buildChildren(
        widgets: [
          ListView(children: [
            Text('w1'),
            Text('w2'),
          ])
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [ListView(children: [])],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents(''));
    });
  });
}
