test('should set attribute "multiple" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), multiple: false),
            __WidgetClass__(key: GlobalKey('el-2'), multiple: null),
            __WidgetClass__(key: GlobalKey('el-3'), multiple: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');
    var domNode3 = app!.domNodeByGlobalKey('el-3');

    expect(domNode1.getAttribute('multiple'), equals(null));
    expect(domNode2.getAttribute('multiple'), equals(null));
    expect(domNode3.getAttribute('multiple'), equals('true'));
}__Skip__);

test('should clear attribute "multiple" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), multiple: true),
            __WidgetClass__(key: GlobalKey('el-2'), multiple: true),
            __WidgetClass__(key: GlobalKey('el-3'), multiple: true),
            __WidgetClass__(key: GlobalKey('el-4'), multiple: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), multiple: true),
            __WidgetClass__(key: GlobalKey('el-2'), multiple: false),
            __WidgetClass__(key: GlobalKey('el-3'), multiple: null),
            __WidgetClass__(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');
    var domNode3 = app!.domNodeByGlobalKey('el-3');
    var domNode4 = app!.domNodeByGlobalKey('el-4');

    expect(domNode1.getAttribute('multiple'), equals('true'));
    expect(domNode2.getAttribute('multiple'), equals(null));
    expect(domNode3.getAttribute('multiple'), equals(null));
    expect(domNode4.getAttribute('multiple'), equals(null));
});