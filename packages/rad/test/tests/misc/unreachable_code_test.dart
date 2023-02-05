// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_relative_lib_imports

import '../../test_imports.dart' hide RootRenderElement;
import '../../../lib/src/core/common/objects/common_render_elements.dart';

// these tests are mere to cover unreachable code

void main() {
  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  group('RootRenderElement', () {
    test('should throw on accessing children list', () {
      expect(
          () => RootRenderElement(
                appTargetId: RT_TestBed.rootTargetId,
                appTargetDomNode:
                    document.getElementById(RT_TestBed.rootTargetId)!,
              ).widgetChildren,
          throwsA((e) => e.toString().toLowerCase().contains('access')));
    });
  });

  group('TemporaryRenderElement', () {
    test('should throw on accessing children list', () {
      expect(
          () => TemporaryElement.create(
                futureParentRenderElement: app!.appRenderElement,
                services: app!.frameworkServices,
              ).widgetChildren,
          throwsA((e) => e.toString().toLowerCase().contains('access')));
    });
  });

  group('Component', () {
    test('should insert styles if head is present', () {
      var component = _TestComponent();
      Components.instance.injectStyleComponent(component);

      var matches = document.getElementsByTagName('style');
      var found = false;
      for (var i = 0; i < matches.length; i++) {
        if (component.styleSheetContents == matches[i].text) {
          found = true;
          break;
        }
      }

      expect(found, equals(true));
    });

    test('should insert styles if head is not present but body is', () {
      document.head?.remove();

      var component = _TestComponent();
      Components.instance.injectStyleComponent(component);

      var matches = document.getElementsByTagName('style');
      var found = false;
      for (var i = 0; i < matches.length; i++) {
        if (component.styleSheetContents == matches[i].text) {
          found = true;
          break;
        }
      }

      expect(found, equals(true));
    });

    test('should throw if neither head nor body is present', () {
      document.head?.remove();
      document.body?.remove();

      var component = _TestComponent();

      expect(
        () => Components.instance.injectStyleComponent(
          component,
        ),
        throwsA((e) => e.toString().contains('head tag')),
      );
    });
  });
}

var _idCount = 1;

class _TestComponent extends StyleComponent {
  final String id;
  _TestComponent() : id = '${_idCount++}';

  @override
  String get name => 'testing-$id';

  @override
  String get author => 'rad-core-$id';

  @override
  String get version => '0.0.0-$id';

  @override
  String? get styleSheetContents => 'contents-$id';
}
