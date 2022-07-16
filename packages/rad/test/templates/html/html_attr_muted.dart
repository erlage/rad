test('should set attribute "muted" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), muted: false),
            __WidgetClass__(key: Key('el-2'), muted: null),
            __WidgetClass__(key: Key('el-3'), muted: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('muted'), equals(null));
    expect(domNode2.getAttribute('muted'), equals(null));
    expect(domNode3.getAttribute('muted'), equals('true'));
}__Skip__);

test('should clear attribute "muted" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), muted: true),
            __WidgetClass__(key: Key('el-2'), muted: true),
            __WidgetClass__(key: Key('el-3'), muted: true),
            __WidgetClass__(key: Key('el-4'), muted: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), muted: true),
            __WidgetClass__(key: Key('el-2'), muted: false),
            __WidgetClass__(key: Key('el-3'), muted: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('muted'), equals('true'));
    expect(domNode2.getAttribute('muted'), equals(null));
    expect(domNode3.getAttribute('muted'), equals(null));
    expect(domNode4.getAttribute('muted'), equals(null));
});