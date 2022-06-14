test('should set attribute "rel"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1'), rel: 'some-rel'),
        __WidgetClass__(key: GlobalKey('el-2'), rel: 'another-rel'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('rel'), equals('some-rel'));
    expect(domNode2.getAttribute('rel'), equals('another-rel'));
}__Skip__);

test('should update attribute "rel"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1'), rel: 'some-rel'),
        __WidgetClass__(key: GlobalKey('el-2'), rel: 'another-rel'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1'), rel: 'updated-rel'),
        __WidgetClass__(key: GlobalKey('el-2'), rel: 'another-rel'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('rel'), equals('updated-rel'));
    expect(domNode2.getAttribute('rel'), equals('another-rel'));
}__Skip__);

test('should clear attribute "rel"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1')),
        __WidgetClass__(key: GlobalKey('el-2'), rel: 'another-rel'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1')),
        __WidgetClass__(key: GlobalKey('el-2')),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('rel'), equals(null));
    expect(domNode2.getAttribute('rel'), equals(null));
});

test('should clear attribute "rel" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), rel: 'some-rel'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), rel: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('rel'), equals(null));
});

test('should not set attribute "rel" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), rel: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('rel'), equals(null));
});
