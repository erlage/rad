test('should set "submit" event listener', () async {
    var testStack = RT_TestStack();

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
                key: Key('el-1'),
                onSubmit: (event) => testStack.push('submit-1'),
            ),
            __WidgetClass__(
                key: Key('el-2'),
                onSubmit: (event) => testStack.push('submit-2'),
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    app!.domNodeByKeyValue('el-1').dispatchEvent(Event('submit'));
    app!.domNodeByKeyValue('el-2').dispatchEvent(Event('submit'));

    await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('submit-1'));
        expect(testStack.popFromStart(), equals('submit-2'));
        expect(testStack.canPop(), equals(false));
    });
});

test('should set "submit" event listener only if provided', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), onSubmit: null),
            __WidgetClass__(key: Key('el-3'), onSubmit: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
    var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

    expect(listeners1[DomEventType.submit], equals(null));
    expect(listeners2[DomEventType.submit], equals(null));
    expect(listeners3[DomEventType.submit], equals(listener));
});

test('should clear "submit" event listner', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), onSubmit: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

    expect(listeners1[DomEventType.submit], equals(null));
    expect(listeners2[DomEventType.submit], equals(listener));

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

    expect(listeners1[DomEventType.submit], equals(null));
    expect(listeners2[DomEventType.submit], equals(null));
});