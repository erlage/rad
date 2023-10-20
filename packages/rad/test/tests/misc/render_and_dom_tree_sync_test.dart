// Copyright (c) 2022 H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: unused_element

import '../../test_imports.dart';

void main() {
  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  group('sync render and dom tree', () {
    test('build', () async {
      /*
      .
      └── Target
        ├── V
        │   └── V
        │       └── 'a'
        └── 'b'
      */

      await app!.buildChildren(
        widgets: [
          _V([
            _V([
              Text('a'),
            ])
          ]),
          Text('b'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('a|b'));
    });

    test('add above a', () async {
      await app!.buildChildren(
        widgets: [
          _V([
            _V([
              Text('a'),
            ])
          ]),
          Text('b'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('a|b'));

      /*
      .
      └── Target
          ├── V
          │   ├── 'added'
          │   └── V
          │       └── 'a'
          └── 'b'
      */

      await app!.updateChildren(
        widgets: [
          _V([
            Text('added'),
            _V([
              Text('a'),
            ]),
          ]),
          Text('b'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('added|a|b'));
    });

    test('add below a', () async {
      await app!.buildChildren(
        widgets: [
          _V([
            _V([
              Text('a'),
            ])
          ]),
          Text('b'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('a|b'));

      /*
      .
      └── Target
          ├── V
          │   ├── V
          │   │   └── 'a'
          │   └── 'added'
          └── 'b'
      */

      await app!.updateChildren(
        widgets: [
          _V([
            _V([
              Text('a'),
            ]),
            Text('added'),
          ]),
          Text('b'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('a|added|b'));
    });

    test('add above and below a', () async {
      await app!.buildChildren(
        widgets: [
          _V([
            Text('added above'),
            _V([
              Text('a'),
            ])
          ]),
          Text('b'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('added above|a|b'));

      /*
      .
      └── Target
          ├── V
          │   ├── 'added above'
          │   ├── V
          │   │   └── 'a'
          │   └── 'added below'
          └── 'b'
      */

      await app!.updateChildren(
        widgets: [
          _V([
            Text('added above'),
            _V([
              Text('a'),
            ]),
            Text('added below'),
          ]),
          Text('b'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode,
          RT_hasContents('added above|a|added below|b'));
    });
  });
}

/// A simple widget that can have virtual dom nodes.
///
/// See [RenderElement.frameworkContainsVirtualDomNodes] for more information.
///
class _V extends Widget {
  final List<Widget> children;
  const _V(this.children, {super.key});

  @override
  DomTagType? get correspondingTag => null;

  @override
  bool shouldUpdateWidget(oldWidget) => false;

  @override
  bool shouldUpdateWidgetChildren(Widget oldWidget, bool shouldUpdateWidget) =>
      true;

  @override
  createRenderElement(parent) => _SampleRenderElement(this, parent);
}

class _SampleRenderElement extends RenderElement {
  _SampleRenderElement(super.widget, super.parent);

  @override
  List<Widget> get widgetChildren => (widget as _V).children;
}
