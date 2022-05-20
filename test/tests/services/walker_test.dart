import '../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | walker service tests
  |--------------------------------------------------------------------------
  */

  group('findAncestorWidgetOfExactType():', () {
    RT_AppRunner? app;
    setUp(() => app = createTestApp()..start());
    tearDown(() => app!.stop());

    test('should return null if widget not found', () {
      var walker = app!.services.walker;

      var widget = walker.findAncestorWidgetOfExactType(app!.appContext);

      expect(widget, equals(null));

      widget = walker.findAncestorWidgetOfExactType<RT_TestWidget>(
        app!.appContext,
      );

      expect(widget, equals(null));
    });

    test('should return matching widget from ancestors', () {
      var walker = app!.services.walker;

      app!.framework.updateChildren(
        widgets: [
          RT_TestWidget(),
          RT_TestWidget(
            children: [
              RT_AnotherTestWidget(key: GlobalKey('child-widget')),
            ],
          ),
        ],
        parentContext: app!.appContext,
        updateType: UpdateType.setState,
      );

      var widget = walker.findAncestorWidgetOfExactType<RT_TestWidget>(
        app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
      );

      expect('${widget.runtimeType}', equals('$RT_TestWidget'));
    });

    test('should return nearest matching widget from ancestors', () {
      var walker = app!.services.walker;

      app!.framework.updateChildren(
        widgets: [
          RT_TestWidget(),
          RT_TestWidget(
            customHash: '1',
            children: [
              RT_TestWidget(
                customHash: '2',
                children: [
                  RT_AnotherTestWidget(key: GlobalKey('child-widget')),
                ],
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
        updateType: UpdateType.setState,
      );

      var widget = walker.findAncestorWidgetOfExactType<RT_TestWidget>(
        app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
      );

      expect('${widget.runtimeType}', equals('$RT_TestWidget'));
      expect((widget as RT_TestWidget).hash, equals('2'));
    });

    test(
      'should return widget with exact runtime type(ignore super classes)',
      () {
        var walker = app!.services.walker;

        app!.framework.updateChildren(
          widgets: [
            RT_AnotherTestWidget(),
            RT_AnotherTestWidget(
              customHash: '1',
              children: [
                RT_TestWidget(
                  customHash: '2',
                  children: [
                    RT_AnotherTestWidget(key: GlobalKey('child-widget')),
                  ],
                ),
              ],
            ),
          ],
          parentContext: app!.appContext,
          updateType: UpdateType.setState,
        );

        var widget = walker.findAncestorWidgetOfExactType<RT_AnotherTestWidget>(
          app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
        );

        expect('${widget.runtimeType}', equals('$RT_AnotherTestWidget'));
        expect((widget as RT_TestWidget).hash, equals('1'));
      },
    );

    test('should return null if no direct ancestor matched', () {
      var walker = app!.services.walker;

      app!.framework.updateChildren(
        widgets: [
          RT_AnotherTestWidget(),
          RT_TestWidget(
            children: [
              RT_TestWidget(
                children: [
                  RT_AnotherTestWidget(key: GlobalKey('child-widget')),
                ],
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
        updateType: UpdateType.setState,
      );

      var widget = walker.findAncestorWidgetOfExactType<RT_AnotherTestWidget>(
        app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
      );

      expect(widget, equals(null));
    });
  });

  group('findAncestorWidgetObject():', () {
    RT_AppRunner? app;
    setUp(() => app = createTestApp()..start());
    tearDown(() => app!.stop());

    test('should return null if widget not found', () {
      var walker = app!.services.walker;

      var widgetObject = walker.findAncestorWidgetObject(app!.appContext);

      expect(widgetObject, equals(null));

      widgetObject = walker.findAncestorWidgetObject<RT_TestWidget>(
        app!.appContext,
      );

      expect(widgetObject, equals(null));
    });

    test('should return matching widget from ancestors', () {
      var walker = app!.services.walker;

      app!.framework.updateChildren(
        widgets: [
          RT_TestWidget(),
          RT_TestWidget(
            children: [
              RT_AnotherTestWidget(key: GlobalKey('child-widget')),
            ],
          ),
        ],
        parentContext: app!.appContext,
        updateType: UpdateType.setState,
      );

      var widgetObject = walker.findAncestorWidgetObject<RT_TestWidget>(
        app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
      )!;

      expect(widgetObject.context.widgetRuntimeType, equals('$RT_TestWidget'));
    });

    test('should return nearest matching widget from ancestors', () {
      var walker = app!.services.walker;

      app!.framework.updateChildren(
        widgets: [
          RT_TestWidget(),
          RT_TestWidget(
            customHash: '1',
            children: [
              RT_TestWidget(
                customHash: '2',
                children: [
                  RT_AnotherTestWidget(key: GlobalKey('child-widget')),
                ],
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
        updateType: UpdateType.setState,
      );

      var widgetObject = walker.findAncestorWidgetObject<RT_TestWidget>(
        app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
      )!;

      expect(widgetObject.context.widgetRuntimeType, equals('$RT_TestWidget'));
      expect((widgetObject.widget as RT_TestWidget).hash, equals('2'));
    });

    test(
      'should return widget with exact runtime type(ignore super classes)',
      () {
        var walker = app!.services.walker;

        app!.framework.updateChildren(
          widgets: [
            RT_AnotherTestWidget(),
            RT_AnotherTestWidget(
              customHash: '1',
              children: [
                RT_TestWidget(
                  customHash: '2',
                  children: [
                    RT_AnotherTestWidget(key: GlobalKey('child-widget')),
                  ],
                ),
              ],
            ),
          ],
          parentContext: app!.appContext,
          updateType: UpdateType.setState,
        );

        var widgetObject =
            walker.findAncestorWidgetObject<RT_AnotherTestWidget>(
          app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
        )!;

        expect(
          widgetObject.context.widgetRuntimeType,
          equals('$RT_AnotherTestWidget'),
        );
        expect((widgetObject.widget as RT_TestWidget).hash, equals('1'));
      },
    );

    test('should return null if no direct ancestor matched', () {
      var walker = app!.services.walker;

      app!.framework.updateChildren(
        widgets: [
          RT_AnotherTestWidget(),
          RT_TestWidget(
            children: [
              RT_TestWidget(
                children: [
                  RT_AnotherTestWidget(key: GlobalKey('child-widget')),
                ],
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
        updateType: UpdateType.setState,
      );

      var widgetObject = walker.findAncestorWidgetObject<RT_AnotherTestWidget>(
        app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
      );

      expect(widgetObject, equals(null));
    });
  });

  group('findAncestorStateOfType():', () {
    RT_AppRunner? app;
    setUp(() => app = createTestApp()..start());
    tearDown(() => app!.stop());

    test('should return null if widget with exact state not found', () {
      var walker = app!.services.walker;

      var state = walker.findAncestorStateOfType(app!.appContext);

      expect(state, equals(null));

      state = walker.findAncestorStateOfType<RT_StatefulTestWidget_State>(
        app!.appContext,
      );

      expect(state, equals(null));
    });

    test('should return matching state from ancestors', () async {
      var walker = app!.services.walker;

      app!.framework.updateChildren(
        widgets: [
          RT_StatefulTestWidget(),
          RT_StatefulTestWidget(
            children: [
              RT_AnotherStatefulWidget(key: GlobalKey('child-widget')),
            ],
          ),
        ],
        parentContext: app!.appContext,
        updateType: UpdateType.setState,
      );

      await Future.delayed(Duration(seconds: 1), () {
        var state = walker.findAncestorStateOfType<RT_StatefulTestWidget_State>(
          app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
        )!;

        expect('${state.runtimeType}', equals('$RT_StatefulTestWidget_State'));
      });
    });

    test('should return nearest matching state from ancestors', () async {
      var walker = app!.services.walker;

      app!.framework.updateChildren(
        widgets: [
          RT_StatefulTestWidget(),
          RT_StatefulTestWidget(
            customHash: '1',
            children: [
              RT_StatefulTestWidget(
                customHash: '2',
                children: [
                  RT_AnotherStatefulWidget(key: GlobalKey('child-widget')),
                ],
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
        updateType: UpdateType.setState,
      );

      await Future.delayed(Duration(seconds: 1), () {
        var state = walker.findAncestorStateOfType<RT_StatefulTestWidget_State>(
          app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
        )!;

        expect('${state.runtimeType}', equals('$RT_StatefulTestWidget_State'));
        expect(state.widget.hash, equals('2'));
      });
    });

    test('should return null if no direct ancestor matched', () async {
      var walker = app!.services.walker;

      app!.framework.updateChildren(
        widgets: [
          RT_AnotherStatefulWidget(),
          RT_StatefulTestWidget(
            children: [
              RT_StatefulTestWidget(
                children: [
                  RT_AnotherStatefulWidget(key: GlobalKey('child-widget')),
                ],
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
        updateType: UpdateType.setState,
      );

      await Future.delayed(Duration(seconds: 1), () {
        var state =
            walker.findAncestorStateOfType<RT_AnotherStatefulWidget_State>(
          app!.services.walker.getWidgetObjectUsingKey('child-widget')!.context,
        );

        expect(state, equals(null));
      });
    });
  });
}
