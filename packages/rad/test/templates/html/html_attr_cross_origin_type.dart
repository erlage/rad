test('should set form attribute "crossorigin"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), crossOrigin: CrossOriginType.anonymous),
            __WidgetClass__(key: Key('el-2'), crossOrigin: CrossOriginType.useCredentials),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(
        domNode1.getAttribute('crossorigin'),
        equals(CrossOriginType.anonymous.nativeValue),
    );
    expect(
        domNode2.getAttribute('crossorigin'),
        equals(CrossOriginType.useCredentials.nativeValue),
    );
});

test('should update form attribute "crossorigin"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), crossOrigin: CrossOriginType.anonymous),
            __WidgetClass__(key: Key('el-2'), crossOrigin: CrossOriginType.useCredentials),
            __WidgetClass__(key: Key('el-3'), crossOrigin: CrossOriginType.anonymous),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), crossOrigin: null),
            __WidgetClass__(key: Key('el-3'), crossOrigin: CrossOriginType.useCredentials),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('crossorigin'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('crossorigin'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('crossorigin'),
        equals(CrossOriginType.useCredentials.nativeValue),
    );
});
