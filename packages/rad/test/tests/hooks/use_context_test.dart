// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  test('should return context of scope', () async {
    BuildContext? context;

    await app!.buildChildren(
      widgets: [
        HookScope(
          () {
            context = useContext();

            return Text('hello world');
          },
          key: Key('scope'),
        ),
      ],
      parentRenderElement: app!.appRenderElement,
    );

    var renderElement = app!.renderElementByKeyValue('scope') as BuildContext;
    expect(renderElement, equals(context));
  });

  test('should return context of nearest scope', () async {
    BuildContext? parent;
    BuildContext? child;

    await app!.buildChildren(
      widgets: [
        HookScope(
          () {
            parent = useContext();

            return HookScope(
              () {
                child = useContext();
                return Text('hello world');
              },
              key: Key('child'),
            );
          },
          key: Key('parent'),
        ),
      ],
      parentRenderElement: app!.appRenderElement,
    );

    var childContext = app!.renderElementByKeyValue('child') as BuildContext;
    var parentContext = app!.renderElementByKeyValue('parent') as BuildContext;
    expect(childContext, equals(child));
    expect(parentContext, equals(parent));
  });
}
