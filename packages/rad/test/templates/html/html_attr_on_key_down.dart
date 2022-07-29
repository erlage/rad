test('should set "KeyDown" event listener', () async {
    var testStack = RT_TestStack();

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
                key: Key('el-1'),
                onKeyDown: (event) => testStack.push('keydown-1'),
            ),
            __WidgetClass__(
                key: Key('el-2'),
                onKeyDown: (event) => testStack.push('keydown-2'),
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    app!.domNodeByKeyValue('el-1').dispatchEvent(Event('keydown'));
    app!.domNodeByKeyValue('el-2').dispatchEvent(Event('keydown'));

    await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('keydown-1'));
        expect(testStack.popFromStart(), equals('keydown-2'));
        expect(testStack.canPop(), equals(false));
    });
});

test('should set "KeyDown" event listener only if provided', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), onKeyDown: null),
            __WidgetClass__(key: Key('el-3'), onKeyDown: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
    var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

    expect(listeners1[DomEventType.keyDown], equals(null));
    expect(listeners2[DomEventType.keyDown], equals(null));
    expect(listeners3[DomEventType.keyDown], equals(listener));
});

test('should clear "KeyDown" event listener', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), onKeyDown: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

    expect(listeners1[DomEventType.keyDown], equals(null));
    expect(listeners2[DomEventType.keyDown], equals(listener));

    // update

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

    expect(listeners1[DomEventType.keyDown], equals(null));
    expect(listeners2[DomEventType.keyDown], equals(null));
});