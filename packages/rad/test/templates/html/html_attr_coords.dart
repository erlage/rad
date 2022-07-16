test('should set attribute "coords"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), coords: 'some-value'),
        __WidgetClass__(key: Key('el-2'), coords: 'another-value'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('coords'), equals('some-value'));
    expect(domNode2.getAttribute('coords'), equals('another-value'));
}__Skip__);

test('should update attribute "coords"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), coords: 'some-value'),
        __WidgetClass__(key: Key('el-2'), coords: 'another-value'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), coords: 'updated-value'),
        __WidgetClass__(key: Key('el-2'), coords: 'another-value'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('coords'), equals('updated-value'));
    expect(domNode2.getAttribute('coords'), equals('another-value'));
}__Skip__);

test('should clear attribute "coords"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), coords: 'another-value'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2')),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('coords'), equals(null));
    expect(domNode2.getAttribute('coords'), equals(null));
});

test('should clear attribute "coords" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), coords: 'some-value'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), coords: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('coords'), equals(null));
});

test('should not set attribute "coords" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), coords: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('coords'), equals(null));
});
