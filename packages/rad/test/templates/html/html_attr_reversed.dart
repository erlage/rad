test('should set attribute "reversed" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), reversed: false),
            __WidgetClass__(key: Key('el-2'), reversed: null),
            __WidgetClass__(key: Key('el-3'), reversed: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('reversed'), equals(null));
    expect(domNode2.getAttribute('reversed'), equals(null));
    expect(domNode3.getAttribute('reversed'), equals('true'));
}__Skip__);

test('should clear attribute "reversed" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), reversed: true),
            __WidgetClass__(key: Key('el-2'), reversed: true),
            __WidgetClass__(key: Key('el-3'), reversed: true),
            __WidgetClass__(key: Key('el-4'), reversed: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), reversed: true),
            __WidgetClass__(key: Key('el-2'), reversed: false),
            __WidgetClass__(key: Key('el-3'), reversed: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('reversed'), equals('true'));
    expect(domNode2.getAttribute('reversed'), equals(null));
    expect(domNode3.getAttribute('reversed'), equals(null));
    expect(domNode4.getAttribute('reversed'), equals(null));
});