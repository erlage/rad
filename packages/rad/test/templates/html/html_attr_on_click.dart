test('should set "click" event listener', () async {
    var testStack = RT_TestStack();

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
                key: Key('el-1'),
                onClick: (event) => testStack.push('click-1'),
            ),
            __WidgetClass__(
                key: Key('el-2'),
                onClick: (event) => testStack.push('click-2'),
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    app!.domNodeByKeyValue('el-1').dispatchEvent(Event('click'));
    app!.domNodeByKeyValue('el-2').dispatchEvent(Event('click'));

    await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('click-1'));
        expect(testStack.popFromStart(), equals('click-2'));
        expect(testStack.canPop(), equals(false));
    });
});

test('should set "click" event listener only if provided', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), onClick: null),
            __WidgetClass__(key: Key('el-3'), onClick: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
    var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

    expect(listeners1[DomEventType.click], equals(null));
    expect(listeners2[DomEventType.click], equals(null));
    expect(listeners3[DomEventType.click], equals(listener));
});

test('should clear "click" event listener', () async {
    void listener(event) => {};

    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), onClick: listener),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
    var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

    expect(listeners1[DomEventType.click], equals(null));
    expect(listeners2[DomEventType.click], equals(listener));

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

    expect(listeners1[DomEventType.click], equals(null));
    expect(listeners2[DomEventType.click], equals(null));
});