// Copyright (c) 2022 H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: unused_element

import '../../test_imports.dart';

// some misc mount cases
// previous algorithm wasn't able to handle some of the cases below

void main() {
  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  group('sync render and dom tree', () {
    test('build', () async {
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

      /*
      .
      └── Target
        ├── V
        │   └── V
        │       └── 'a'
        └── 'b'
      */

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

      await app!.updateChildren(
        widgets: [
          _V([
            Text('added above'),
            _V([
              Text('a'),
            ]),
          ]),
          Text('b'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      /*
      .
      └── Target
          ├── V
          │   ├── 'added above'
          │   └── V
          │       └── 'a'
          └── 'b'
      */

      expect(RT_TestBed.rootDomNode, RT_hasContents('added above|a|b'));
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

      await app!.updateChildren(
        widgets: [
          _V([
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

      /*
      .
      └── Target
          ├── V
          │   ├── V
          │   │   └── 'a'
          │   └── 'added below'
          └── 'b'
      */

      expect(RT_TestBed.rootDomNode, RT_hasContents('a|added below|b'));
    });

    test('add above and below a', () async {
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

      await app!.updateChildren(
        widgets: [
          _V([
            Text('added above'),
            _V([
              Text('a'),
            ])
          ]),
          Text('b'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      /*
      .
      └── Target
          ├── V
          │   ├── 'added above'
          │   └── V
          │       └── 'a'
          └── 'b'
      */

      expect(RT_TestBed.rootDomNode, RT_hasContents('added above|a|b'));

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

      expect(RT_TestBed.rootDomNode,
          RT_hasContents('added above|a|added below|b'));
    });

    test('add below and above a', () async {
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

      await app!.updateChildren(
        widgets: [
          _V([
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

      /*
      .
      └── Target
          ├── V
          │   ├── V
          │   │   └── 'a'
          │   └── 'added below'
          └── 'b'
      */

      expect(RT_TestBed.rootDomNode, RT_hasContents('a|added below|b'));

      await app!.buildChildren(
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
        parentRenderElement: app!.appRenderElement,
      );

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
