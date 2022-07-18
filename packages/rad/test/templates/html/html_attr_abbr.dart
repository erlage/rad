test('should set attribute "abbr"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), abbr: 'some-abbr'),
        __WidgetClass__(key: Key('el-2'), abbr: 'another-abbr'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('abbr'), equals('some-abbr'));
    expect(domNode2.getAttribute('abbr'), equals('another-abbr'));
}__Skip__);

test('should update attribute "abbr"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), abbr: 'some-abbr'),
        __WidgetClass__(key: Key('el-2'), abbr: 'another-abbr'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), abbr: 'updated-abbr'),
        __WidgetClass__(key: Key('el-2'), abbr: 'another-abbr'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('abbr'), equals('updated-abbr'));
    expect(domNode2.getAttribute('abbr'), equals('another-abbr'));
}__Skip__);

test('should clear attribute "abbr"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), abbr: 'another-abbr'),
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

    expect(domNode1.getAttribute('abbr'), equals(null));
    expect(domNode2.getAttribute('abbr'), equals(null));
});

test('should clear attribute "abbr" if updated abbr is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), abbr: 'some-abbr'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), abbr: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('abbr'), equals(null));
});

test('should not set attribute "abbr" if provided abbr is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), abbr: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('abbr'), equals(null));
});
