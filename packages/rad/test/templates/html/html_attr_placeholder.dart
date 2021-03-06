test('should set attribute "placeholder"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), placeholder: 'some-placeholder'),
        __WidgetClass__(key: Key('el-2'), placeholder: 'another-placeholder'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('placeholder'), equals('some-placeholder'));
    expect(domNode2.getAttribute('placeholder'), equals('another-placeholder'));
}__Skip__);

test('should update attribute "placeholder"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), placeholder: 'some-placeholder'),
        __WidgetClass__(key: Key('el-2'), placeholder: 'another-placeholder'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), placeholder: 'updated-placeholder'),
        __WidgetClass__(key: Key('el-2'), placeholder: 'another-placeholder'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('placeholder'), equals('updated-placeholder'));
    expect(domNode2.getAttribute('placeholder'), equals('another-placeholder'));
}__Skip__);

test('should clear attribute "placeholder"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), placeholder: 'another-placeholder'),
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

    expect(domNode1.getAttribute('placeholder'), equals(null));
    expect(domNode2.getAttribute('placeholder'), equals(null));
});

test('should clear attribute "placeholder" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), placeholder: 'some-placeholder'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), placeholder: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('placeholder'), equals(null));
});

test('should not set attribute "placeholder" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), placeholder: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('placeholder'), equals(null));
});
