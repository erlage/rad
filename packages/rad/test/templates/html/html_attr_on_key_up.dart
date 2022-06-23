test('should set "KeyUp" event listener', () async {
    var testStack = RT_TestStack();

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
                key: GlobalKey('el-1'),
                onKeyUp: (event) => testStack.push('keyup-1'),
            ),
            __WidgetClass__(
                key: GlobalKey('el-2'),
                onKeyUp: (event) => testStack.push('keyup-2'),
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    app!.domNodeByGlobalKey('el-1').dispatchEvent(Event('keyup'));
    app!.domNodeByGlobalKey('el-2').dispatchEvent(Event('keyup'));

    await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('keyup-1'));
        expect(testStack.popFromStart(), equals('keyup-2'));
        expect(testStack.canPop(), equals(false));
    });
});

test('should set "KeyUp" event listener only if provided', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1')),
            __WidgetClass__(key: GlobalKey('el-2'), onKeyUp: null),
            __WidgetClass__(key: GlobalKey('el-3'), onKeyUp: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;
    var listeners3 = app!.widgetByGlobalKey('el-3').widgetEventListeners;

    expect(listeners1[DomEventType.keyUp], equals(null));
    expect(listeners2[DomEventType.keyUp], equals(null));
    expect(listeners3[DomEventType.keyUp], equals(listener));
});

test('should clear "KeyUp" event listner', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1')),
            __WidgetClass__(key: GlobalKey('el-2'), onKeyUp: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

    expect(listeners1[DomEventType.keyUp], equals(null));
    expect(listeners2[DomEventType.keyUp], equals(listener));

    // update

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1')),
            __WidgetClass__(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
    listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

    expect(listeners1[DomEventType.keyUp], equals(null));
    expect(listeners2[DomEventType.keyUp], equals(null));
});