// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  group('update dependent context:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() {
      app!.stop();
    });

    test('should call update on dependent', () async {
      var pap = app!;

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('widget'),
            roEventUpdate: () => pap.stack.push('update'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var element = pap.renderElementByKeyValue('widget')!;

      await pap.updateDependent(element);
      await pap.updateDependent(element);

      expect(pap.stack.popFromStart(), equals('update'));
      expect(pap.stack.popFromStart(), equals('update'));
      expect(pap.stack.canPop(), equals(false));
    });

    test('should set update type to dependencyChanged', () async {
      var pap = app!;

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('widget'),
            roHookUpdate: (type) => pap.stack.push(type.name),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var element = pap.renderElementByKeyValue('widget')!;

      await pap.updateDependent(element);
      await pap.updateDependent(element);

      var expectedName = UpdateType.dependencyChanged.name;

      expect(pap.stack.popFromStart(), equals(expectedName));
      expect(pap.stack.popFromStart(), equals(expectedName));
      expect(pap.stack.canPop(), equals(false));
    });

    test('should call update only on dependent widget', () async {
      var pap = app!;

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('widget-1'),
            roEventUpdate: () => pap.stack.push('update-1'),
          ),
          RT_TestWidget(
            key: Key('widget-2'),
            roEventUpdate: () => pap.stack.push('update-2'),
          ),
          RT_TestWidget(
            key: Key('widget-3'),
            roEventUpdate: () => pap.stack.push('update-3'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var element1 = pap.renderElementByKeyValue('widget-1')!;
      var element2 = pap.renderElementByKeyValue('widget-2')!;
      var element3 = pap.renderElementByKeyValue('widget-3')!;

      await pap.updateDependent(element1);
      await pap.updateDependent(element3);
      expect(pap.stack.popFromStart(), equals('update-1'));
      expect(pap.stack.popFromStart(), equals('update-3'));
      expect(pap.stack.canPop(), equals(false));

      await pap.updateDependent(element2);
      expect(pap.stack.popFromStart(), equals('update-2'));
      expect(pap.stack.canPop(), equals(false));

      await pap.updateDependent(element3);
      expect(pap.stack.popFromStart(), equals('update-3'));
      expect(pap.stack.canPop(), equals(false));
    });
  });
}
