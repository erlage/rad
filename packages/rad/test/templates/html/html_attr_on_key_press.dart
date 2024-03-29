test('should set "KeyPress" event listener', () async {
    var testStack = RT_TestStack();

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
                key: Key('el-1'),
                onKeyPress: (event) => testStack.push('keypress-1'),
            ),
            __WidgetClass__(
                key: Key('el-2'),
                onKeyPress: (event) => testStack.push('keypress-2'),
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    app!.domNodeByKeyValue('el-1').dispatchEvent(Event('keypress'));
    app!.domNodeByKeyValue('el-2').dispatchEvent(Event('keypress'));

    await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('keypress-1'));
        expect(testStack.popFromStart(), equals('keypress-2'));
        expect(testStack.canPop(), equals(false));
    });
});

test('should set "KeyPress" event listener only if provided', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), onKeyPress: null),
            __WidgetClass__(key: Key('el-3'), onKeyPress: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
    var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

    expect(listeners1[DomEventType.keyPress], equals(null));
    expect(listeners2[DomEventType.keyPress], equals(null));
    expect(listeners3[DomEventType.keyPress], equals(listener));
});

test('should clear "KeyPress" event listener', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), onKeyPress: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

    expect(listeners1[DomEventType.keyPress], equals(null));
    expect(listeners2[DomEventType.keyPress], equals(listener));

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

    expect(listeners1[DomEventType.keyPress], equals(null));
    expect(listeners2[DomEventType.keyPress], equals(null));
});