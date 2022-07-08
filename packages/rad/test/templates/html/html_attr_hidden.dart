test('should set attribute "hidden" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), hidden: false),
            __WidgetClass__(key: Key('el-2'), hidden: null),
            __WidgetClass__(key: Key('el-3'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('hidden'), equals(null));
    expect(domNode2.getAttribute('hidden'), equals(null));
    expect(domNode3.getAttribute('hidden'), equals('true'));
}__Skip__);

test('should clear attribute "hidden" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), hidden: true),
            __WidgetClass__(key: Key('el-2'), hidden: true),
            __WidgetClass__(key: Key('el-3'), hidden: true),
            __WidgetClass__(key: Key('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), hidden: true),
            __WidgetClass__(key: Key('el-2'), hidden: false),
            __WidgetClass__(key: Key('el-3'), hidden: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('hidden'), equals('true'));
    expect(domNode2.getAttribute('hidden'), equals(null));
    expect(domNode3.getAttribute('hidden'), equals(null));
    expect(domNode4.getAttribute('hidden'), equals(null));
});