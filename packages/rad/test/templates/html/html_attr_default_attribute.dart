test('should set attribute "default" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), defaultAttribute: false),
            __WidgetClass__(key: Key('el-2'), defaultAttribute: null),
            __WidgetClass__(key: Key('el-3'), defaultAttribute: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('default'), equals(null));
    expect(domNode2.getAttribute('default'), equals(null));
    expect(domNode3.getAttribute('default'), equals('true'));
}__Skip__);

test('should clear attribute "default" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), defaultAttribute: true),
            __WidgetClass__(key: Key('el-2'), defaultAttribute: true),
            __WidgetClass__(key: Key('el-3'), defaultAttribute: true),
            __WidgetClass__(key: Key('el-4'), defaultAttribute: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), defaultAttribute: true),
            __WidgetClass__(key: Key('el-2'), defaultAttribute: false),
            __WidgetClass__(key: Key('el-3'), defaultAttribute: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('default'), equals('true'));
    expect(domNode2.getAttribute('default'), equals(null));
    expect(domNode3.getAttribute('default'), equals(null));
    expect(domNode4.getAttribute('default'), equals(null));
});