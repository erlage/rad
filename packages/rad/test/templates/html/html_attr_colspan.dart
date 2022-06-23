test('should set attribute "colSpan"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), colSpan: 10),
            __WidgetClass__(key: GlobalKey('el-2'), colSpan: 0),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('colspan'), equals('10'));
    expect(domNode2.getAttribute('colspan'), equals('0'));
}__Skip__);

test('should update attribute "colSpan"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), colSpan: 10),
            __WidgetClass__(key: GlobalKey('el-2'), colSpan: 10),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), colSpan: 20),
            __WidgetClass__(key: GlobalKey('el-2'), colSpan: 20),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('colspan'), equals('20'));
    expect(domNode2.getAttribute('colspan'), equals('20'));
}__Skip__);

test('should clear attribute "colSpan"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1')),
            __WidgetClass__(key: GlobalKey('el-2'), colSpan: 10),
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

    expect(domNode1.getAttribute('colspan'), equals(null));
    expect(domNode2.getAttribute('colspan'), equals(null));
});

test('should clear attribute "colSpan" if updated value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), colSpan: 10),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), colSpan: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('colspan'), equals(null));
});

test('should not set attribute "colSpan" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), colSpan: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('colspan'), equals(null));
});