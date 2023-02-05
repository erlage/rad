// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  test('should return state of enclosing navigator', () async {
    NavigatorState? state;

    await app!.buildChildren(
      widgets: [
        Navigator(key: Key('navigator'), routes: [
          Route(
            name: 'some-route',
            page: HookScope(
              () {
                state = useNavigator();
                return Text('hello world');
              },
              key: Key('scope'),
            ),
          ),
        ]),
      ],
      parentRenderElement: app!.appRenderElement,
    );

    var renderElement = app!.renderElementByKeyValue('navigator');
    renderElement as NavigatorRenderElement;
    expect(renderElement.state, equals(state));
  });

  test('should return state of correct navigator', () async {
    NavigatorState? parent;
    NavigatorState? child;

    await app!.buildChildren(
      widgets: [
        Navigator(key: Key('parent'), routes: [
          Route(
            name: 'main',
            page: Navigator(
              key: Key('child'),
              routes: [
                Route(
                  name: 'some-route',
                  page: HookScope(
                    () {
                      child = useNavigator();
                      parent = useNavigator(byKey: Key('parent'));

                      return Text('hello world');
                    },
                    key: Key('scope'),
                  ),
                ),
              ],
            ),
          ),
        ])
      ],
      parentRenderElement: app!.appRenderElement,
    );

    var parentElement = app!.renderElementByKeyValue('parent');
    parentElement as NavigatorRenderElement;
    var childElement = app!.renderElementByKeyValue('child');
    childElement as NavigatorRenderElement;

    expect(parentElement.state, equals(parent));
    expect(childElement.state, equals(child));
  });
}
