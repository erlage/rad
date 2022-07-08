test('should set attribute "disabled" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), disabled: false),
            __WidgetClass__(key: Key('el-2'), disabled: null),
            __WidgetClass__(key: Key('el-3'), disabled: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('disabled'), equals(null));
    expect(domNode2.getAttribute('disabled'), equals(null));
    expect(domNode3.getAttribute('disabled'), equals('true'));
}__Skip__);

test('should clear attribute "disabled" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), disabled: true),
            __WidgetClass__(key: Key('el-2'), disabled: true),
            __WidgetClass__(key: Key('el-3'), disabled: true),
            __WidgetClass__(key: Key('el-4'), disabled: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), disabled: true),
            __WidgetClass__(key: Key('el-2'), disabled: false),
            __WidgetClass__(key: Key('el-3'), disabled: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('disabled'), equals('true'));
    expect(domNode2.getAttribute('disabled'), equals(null));
    expect(domNode3.getAttribute('disabled'), equals(null));
    expect(domNode4.getAttribute('disabled'), equals(null));
});