test('should set attribute "checked" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), checked: false),
            __WidgetClass__(key: Key('el-2'), checked: null),
            __WidgetClass__(key: Key('el-3'), checked: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('checked'), equals(null));
    expect(domNode2.getAttribute('checked'), equals(null));
    expect(domNode3.getAttribute('checked'), equals('true'));
}__Skip__);

test('should clear attribute "checked" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), checked: true),
            __WidgetClass__(key: Key('el-2'), checked: true),
            __WidgetClass__(key: Key('el-3'), checked: true),
            __WidgetClass__(key: Key('el-4'), checked: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), checked: true),
            __WidgetClass__(key: Key('el-2'), checked: false),
            __WidgetClass__(key: Key('el-3'), checked: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('checked'), equals('true'));
    expect(domNode2.getAttribute('checked'), equals(null));
    expect(domNode3.getAttribute('checked'), equals(null));
    expect(domNode4.getAttribute('checked'), equals(null));
});