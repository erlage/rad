test('should set "input" event listener', () async {
    var testStack = RT_TestStack();

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
                key: Key('el-1'),
                onInput: (event) => testStack.push('input-1'),
            ),
            __WidgetClass__(
                key: Key('el-2'),
                onInput: (event) => testStack.push('input-2'),
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    app!.domNodeByKeyValue('el-1').dispatchEvent(Event('input'));
    app!.domNodeByKeyValue('el-2').dispatchEvent(Event('input'));

    await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('input-1'));
        expect(testStack.popFromStart(), equals('input-2'));
        expect(testStack.canPop(), equals(false));
    });
});

test('should set "input" event listener only if provided', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), onInput: null),
            __WidgetClass__(key: Key('el-3'), onInput: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
    var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

    expect(listeners1[DomEventType.input], equals(null));
    expect(listeners2[DomEventType.input], equals(null));
    expect(listeners3[DomEventType.input], equals(listener));
});

test('should clear "input" event listener', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), onInput: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

    expect(listeners1[DomEventType.input], equals(null));
    expect(listeners2[DomEventType.input], equals(listener));

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

    expect(listeners1[DomEventType.input], equals(null));
    expect(listeners2[DomEventType.input], equals(null));
});