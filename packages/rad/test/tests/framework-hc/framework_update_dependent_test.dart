// Copyright (c) 2022, Rad developers. All rights reserved.
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
  });
}
