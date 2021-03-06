test('should set attribute "readonly" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), readOnly: false),
            __WidgetClass__(key: Key('el-2'), readOnly: null),
            __WidgetClass__(key: Key('el-3'), readOnly: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('readonly'), equals(null));
    expect(domNode2.getAttribute('readonly'), equals(null));
    expect(domNode3.getAttribute('readonly'), equals('true'));
}__Skip__);

test('should clear attribute "readonly" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), readOnly: true),
            __WidgetClass__(key: Key('el-2'), readOnly: true),
            __WidgetClass__(key: Key('el-3'), readOnly: true),
            __WidgetClass__(key: Key('el-4'), readOnly: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), readOnly: true),
            __WidgetClass__(key: Key('el-2'), readOnly: false),
            __WidgetClass__(key: Key('el-3'), readOnly: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('readonly'), equals('true'));
    expect(domNode2.getAttribute('readonly'), equals(null));
    expect(domNode3.getAttribute('readonly'), equals(null));
    expect(domNode4.getAttribute('readonly'), equals(null));
});