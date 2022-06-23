test('should set attribute "rowSpan"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), rowSpan: 10),
            __WidgetClass__(key: GlobalKey('el-2'), rowSpan: 0),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('rowspan'), equals('10'));
    expect(domNode2.getAttribute('rowspan'), equals('0'));
}__Skip__);

test('should update attribute "rowSpan"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), rowSpan: 10),
            __WidgetClass__(key: GlobalKey('el-2'), rowSpan: 10),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), rowSpan: 20),
            __WidgetClass__(key: GlobalKey('el-2'), rowSpan: 20),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('rowspan'), equals('20'));
    expect(domNode2.getAttribute('rowspan'), equals('20'));
}__Skip__);

test('should clear attribute "rowSpan"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1')),
            __WidgetClass__(key: GlobalKey('el-2'), rowSpan: 10),
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

    expect(domNode1.getAttribute('rowspan'), equals(null));
    expect(domNode2.getAttribute('rowspan'), equals(null));
});

test('should clear attribute "rowSpan" if updated value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), rowSpan: 10),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), rowSpan: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('rowspan'), equals(null));
});

test('should not set attribute "rowSpan" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), rowSpan: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('rowspan'), equals(null));
});