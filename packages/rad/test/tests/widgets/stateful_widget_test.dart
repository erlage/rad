// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  group('State hooks :', () {
    setUp(() {
      ServicesRegistry.instance.unRegisterServices(
        RT_TestBed.rootRenderElement,
      );
    });

    test('should bind widget before initState, type test', () async {
      runApp(
        app: RT_StatefulTestWidget(
          key: Key('widget'),
          stateHookInitState: (state) {
            expect(state.widget.runtimeType, equals(RT_StatefulTestWidget));
          },
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration.zero);
    });

    test('should bind widget before initState, key test', () async {
      runApp(
        app: RT_StatefulTestWidget(
          key: Key('widget'),
          stateHookInitState: (state) {
            expect(state.context.key?.frameworkValue, endsWith('widget'));
          },
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration.zero);
    });

    test(
      'should always throw if State.widget is accessed from state constructor',
      () async {
        expect(
          () => createTestApp(
            app: RT_StatefulTestWidget(
              stateHookCreateState: (state) => state.widget,
            ),
          )..start(),
          // or just AssertionError
          throwsA(
            predicate(
              (e) => '$e'.contains(
                'State.widget instance cannot be accessed in state',
              ),
            ),
          ),
        );

        await Future.delayed(Duration.zero);
      },
    );

    test(
      'should always throw if State.context is accessed from state constructor',
      () async {
        expect(
          () => createTestApp(
            app: RT_StatefulTestWidget(
              stateHookCreateState: (state) => state.context,
            ),
          )..start(),
          throwsA(
            predicate(
              (e) => '$e'.contains(
                'State.context instance cannot be accessed in a state',
              ),
            ),
          ),
        );

        await Future.delayed(Duration.zero);
      },
    );

    test(
      'should call afterMount after widget is built',
      () async {
        var testStack = RT_TestStack();

        runApp(
          app: RT_StatefulTestWidget(
            stateEventAfterMount: () => testStack.push('after mount'),
            stateEventBuild: () => testStack.push('build'),
          ),
          appTargetId: RT_TestBed.rootTargetId,
        );

        await Future.delayed(Duration(milliseconds: 200));

        expect(testStack.popFromStart(), equals('build'));
        expect(testStack.popFromStart(), equals('after mount'));
        expect(testStack.canPop(), equals(false));
      },
    );

    test('should call afterMount after widget is mounted on screen', () async {
      runApp(
        app: RT_StatefulTestWidget(
          children: [Text('hello world')],
          stateEventAfterMount: () {
            expect(RT_TestBed.rootDomNode, RT_hasContents('hello world'));
          },
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration(milliseconds: 200));
    });

    test('should call afterMount exactly once', () async {
      var testStack = RT_TestStack();

      var runner = runApp(
        app: RT_StatefulTestWidget(
          stateEventAfterMount: () => testStack.push('after mount'),
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration(milliseconds: 100));
      runner.stop();
      await Future.delayed(Duration(milliseconds: 100));
      expect(RT_TestBed.rootDomNode, RT_hasContents(''));

      expect(testStack.popFromStart(), equals('after mount'));
      expect(testStack.canPop(), equals(false));
    });

    test('should call afterUpdate after build', () async {
      var app = createTestApp()..start();
      var testStack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_StatefulTestWidget(
            stateEventBuild: () => testStack.push('build'),
            stateEventAfterUpdate: () => testStack.push('after update'),
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      await app.updateChildren(
        widgets: [
          RT_StatefulTestWidget(
            stateEventBuild: () => testStack.push('build'),
            stateEventAfterUpdate: () => testStack.push('after update'),
          )
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app.appRenderElement,
      );

      await app.updateChildren(
        widgets: [
          RT_StatefulTestWidget(
            stateEventBuild: () => testStack.push('build'),
            stateEventAfterUpdate: () => testStack.push('after update'),
          )
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app.appRenderElement,
      );

      expect(testStack.popFromStart(), equals('build'));
      expect(testStack.popFromStart(), equals('build'));
      expect(testStack.popFromStart(), equals('after update'));
      expect(testStack.popFromStart(), equals('build'));
      expect(testStack.popFromStart(), equals('after update'));
      expect(testStack.canPop(), equals(false));
    });

    test('should call afterUpdate after dom updates are flushed', () async {
      var app = createTestApp()..start();
      var testStack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_StatefulTestWidget(
            children: [Text('initial contents')],
            stateEventAfterUpdate: () => testStack.push('after update'),
          )
        ],
        parentRenderElement: app.appRenderElement,
      );

      await app.updateChildren(
        widgets: [
          RT_StatefulTestWidget(
            children: [Text('updated contents')],
            stateEventAfterUpdate: () {
              testStack.push('after update');

              expect(app.appDomNode, RT_hasContents('updated contents'));
            },
          )
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app.appRenderElement,
      );

      expect(testStack.popFromStart(), equals('after update'));
      expect(testStack.canPop(), equals(false));
    });

    test('should call afterUnMount after actual unmount', () async {
      var stack = RT_TestStack();

      var runner = runApp(
        app: RT_StatefulTestWidget(
          children: [Text('hello world', style: 'font-weight: bold;')],
          stateEventAfterUnMount: () {
            stack.push('after unmount');
            expect(RT_TestBed.rootDomNode, RT_hasContents(''));
          },
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration(milliseconds: 100));
      runner.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('after unmount'));
      expect(stack.canPop(), equals(false));
    });

    test('should call did change dependencies after initState', () async {
      var testStack = RT_TestStack();

      runApp(
        app: RT_StatefulTestWidget(
          stateEventInitState: () => testStack.push('init state'),
          stateEventDidChangeDependencies: () => testStack.push(
            'did change dependencies',
          ),
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('init state'));
        expect(testStack.popFromStart(), equals('did change dependencies'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should call build after did change dependencies', () async {
      var testStack = RT_TestStack();

      runApp(
        app: RT_StatefulTestWidget(
          stateEventInitState: () => testStack.push('init state'),
          stateEventBuild: () => testStack.push('build'),
          stateEventDidChangeDependencies: () => testStack.push(
            'did change dependencies',
          ),
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('init state'));
        expect(testStack.popFromStart(), equals('did change dependencies'));
        expect(testStack.popFromStart(), equals('build'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should defer setState called in initState', () async {
      var testStack = RT_TestStack();
      var i = 1;

      runApp(
        app: RT_StatefulTestWidget(
          stateHookInitState: (state) {
            testStack.push('init state');

            // ignore: invalid_use_of_protected_member
            state.setState(() {
              testStack.push('set state');
            });
          },
          stateEventBuild: () => testStack.push('build-${i++}'),
          stateEventDidUpdateWidget: () => testStack.push('did update widget'),
          stateEventDidChangeDependencies: () => testStack.push(
            'did change dependencies',
          ),
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('init state'));
        expect(testStack.popFromStart(), equals('did change dependencies'));
        expect(testStack.popFromStart(), equals('build-1'));
        expect(testStack.popFromStart(), equals('set state'));
        expect(testStack.popFromStart(), equals('build-2'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should not call didUpdateWidget for initial build', () async {
      var testStack = RT_TestStack();

      runApp(
        app: RT_StatefulTestWidget(
          stateEventInitState: () => testStack.push('init state'),
          stateEventBuild: () => testStack.push('build'),
          stateEventDidUpdateWidget: () => testStack.push('did update widget'),
          stateEventDidChangeDependencies: () => testStack.push(
            'did change dependencies',
          ),
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('init state'));
        expect(testStack.popFromStart(), equals('did change dependencies'));
        expect(testStack.popFromStart(), equals('build'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test(
      'should call didUpdateWidget with old widget when widget is swapped',
      () async {
        var testStack = RT_TestStack();
        var i = 1;

        var app = createTestApp()..start();

        await app.buildChildren(
          widgets: [
            RT_StatefulTestWidget(
              customHash: 'old',
              stateEventCreateState: () => testStack.push('create state 1a'),
              stateEventInitState: () => testStack.push('init state 1a'),
              stateEventBuild: () => testStack.push('build-${i++} 1a'),
              stateEventDidUpdateWidget: () => testStack.push(
                'did update widget 1a',
              ),
              stateHookDidUpdateWidget: (state, widget) {
                widget as RT_StatefulTestWidget;

                expect(widget.hash, equals('old'));
                expect(state.widget.hash, equals('new'));
              },
              stateEventDidChangeDependencies: () => testStack.push(
                'did change dependencies 1a',
              ),
            ),
          ],
          parentRenderElement: app.appRenderElement,
        );

        await app.updateChildren(
          widgets: [
            RT_StatefulTestWidget(
              customHash: 'new',
              stateEventCreateState: () => testStack.push('create state 1b'),
              stateEventInitState: () => testStack.push('init state 1b'),
              stateEventBuild: () => testStack.push('build-${i++} 1b'),
              stateEventDidUpdateWidget: () => testStack.push(
                'did update widget 1b',
              ),
              stateHookDidUpdateWidget: (state, widget) {
                throw Exception('should never gets called');
              },
              stateEventDidChangeDependencies: () => testStack.push(
                'did change dependencies 1b',
              ),
            ),
          ],
          updateType: UpdateType.undefined,
          parentRenderElement: app.appRenderElement,
        );

        expect(testStack.popFromStart(), equals('create state 1a'));
        expect(testStack.popFromStart(), equals('init state 1a'));
        expect(testStack.popFromStart(), equals('did change dependencies 1a'));
        expect(testStack.popFromStart(), equals('build-1 1a'));
        expect(testStack.popFromStart(), equals('did update widget 1a'));
        expect(testStack.popFromStart(), equals('build-2 1a'));
        expect(testStack.canPop(), equals(false));
      },
    );

    test('should call dispose when widget is removed', () async {
      var testStack = RT_TestStack();

      var app = createTestApp()..start();

      await app.buildChildren(
        widgets: [
          RT_StatefulTestWidget(
            key: Key('old'),
            stateEventCreateState: () => testStack.push('create state 1a'),
            stateEventInitState: () => testStack.push('init state 1a'),
            stateEventBuild: () => testStack.push('build 1a'),
            stateEventDidUpdateWidget: () => testStack.push(
              'did update widget 1a',
            ),
            stateEventDidChangeDependencies: () => testStack.push(
              'did change dependencies 1a',
            ),
            stateEventDispose: () => testStack.push('dispose 1a'),
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      await app.updateChildren(
        widgets: [
          RT_StatefulTestWidget(
            key: Key('new'),
            stateEventCreateState: () => testStack.push('create state 1b'),
            stateEventInitState: () => testStack.push('init state 1b'),
            stateEventBuild: () => testStack.push('build 1b'),
            stateEventDidUpdateWidget: () => testStack.push(
              'did update widget 1b',
            ),
            stateEventDidChangeDependencies: () => testStack.push(
              'did change dependencies 1b',
            ),
            stateEventDispose: () => testStack.push('dispose 1b'),
          ),
        ],
        updateType: UpdateType.undefined,
        parentRenderElement: app.appRenderElement,
      );

      expect(testStack.popFromStart(), equals('create state 1a'));
      expect(testStack.popFromStart(), equals('init state 1a'));
      expect(testStack.popFromStart(), equals('did change dependencies 1a'));
      expect(testStack.popFromStart(), equals('build 1a'));
      expect(testStack.popFromStart(), equals('dispose 1a'));

      // after dispose

      expect(testStack.popFromStart(), equals('create state 1b'));
      expect(testStack.popFromStart(), equals('init state 1b'));
      expect(testStack.popFromStart(), equals('did change dependencies 1b'));
      expect(testStack.popFromStart(), equals('build 1b'));
      expect(testStack.canPop(), equals(false));
    });

    //
  });

  group('Widget building process :', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should build widgets in order', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_StatefulTestWidget(
            stateEventBuild: () => testStack.push('build-1a'),
          ),
          RT_StatefulTestWidget(
            stateEventBuild: () => testStack.push('build-1b'),
          ),
          RT_StatefulTestWidget(
            stateEventBuild: () => testStack.push('build-1c'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(testStack.popFromStart(), equals('build-1a'));
      expect(testStack.popFromStart(), equals('build-1b'));
      expect(testStack.popFromStart(), equals('build-1c'));

      expect(testStack.canPop(), equals(false));
    });

    test('should update widgets in order', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_StatefulTestWidget(
            stateEventBuild: () => testStack.push('build-a'),
          ),
          RT_StatefulTestWidget(
            stateEventBuild: () => testStack.push('build-b'),
          ),
          RT_StatefulTestWidget(
            stateEventBuild: () => testStack.push('build-c'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          RT_StatefulTestWidget(),
          RT_StatefulTestWidget(),
          RT_StatefulTestWidget(),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(testStack.popFromStart(), equals('build-a'));
      expect(testStack.popFromStart(), equals('build-b'));
      expect(testStack.popFromStart(), equals('build-c'));

      // stateful widgets always call build on previous state object

      expect(testStack.popFromStart(), equals('build-a'));
      expect(testStack.popFromStart(), equals('build-b'));
      expect(testStack.popFromStart(), equals('build-c'));

      expect(testStack.canPop(), equals(false));
    });

    test('should call hooks in order', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_StatefulTestWidget(
              stateEventInitState: () => testStack.push('init'),
              stateEventBuild: () => testStack.push('build'),
              stateEventDispose: () => testStack.push('dispose'),
              children: [
                RT_TestWidget(
                  roEventRender: () => testStack.push('render child'),
                )
              ]),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          RT_AnotherStatefulWidget(
            stateEventInitState: () => testStack.push('init new'),
            stateEventBuild: () => testStack.push('build new'),
            stateEventDispose: () => testStack.push('dispose new'),
            children: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render child new'),
              )
            ],
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(testStack.popFromStart(), equals('init'));
      expect(testStack.popFromStart(), equals('build'));
      expect(testStack.popFromStart(), equals('render child'));

      expect(testStack.popFromStart(), equals('dispose'));
      expect(testStack.popFromStart(), equals('init new'));
      expect(testStack.popFromStart(), equals('build new'));
      expect(testStack.popFromStart(), equals('render child new'));

      expect(testStack.canPop(), equals(false));
    });

    test('should build alternating child widgets', () async {
      await app!.updateChildren(
        widgets: [
          _AlternatingChildrenWidget(),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('child 1'));

      await app!.updateChildren(
        widgets: [
          _AlternatingChildrenWidget(),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('child 2'));

      await app!.updateChildren(
        widgets: [
          _AlternatingChildrenWidget(),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('child 1'));
    });
  });
}

class _AlternatingChildrenWidget extends StatefulWidget {
  _AlternatingChildrenWidget({Key? key}) : super(key: key);

  @override
  _AlternatingChildrenWidgetState createState() =>
      _AlternatingChildrenWidgetState();
}

class _AlternatingChildrenWidgetState
    extends State<_AlternatingChildrenWidget> {
  final Widget _child1 = Span(innerText: 'child 1');
  final Widget _child2 = Division(innerText: 'child 2');

  Widget? _activeChild;

  @override
  void initState() {
    _activeChild = _child2;
  }

  @override
  Widget build(BuildContext context) {
    _activeChild = _activeChild == _child1 ? _child2 : _child1;

    return _activeChild!;
  }
}
