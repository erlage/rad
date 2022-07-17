test('should set attribute "novalidate" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), noValidate: false),
            __WidgetClass__(key: Key('el-2'), noValidate: null),
            __WidgetClass__(key: Key('el-3'), noValidate: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('novalidate'), equals(null));
    expect(domNode2.getAttribute('novalidate'), equals(null));
    expect(domNode3.getAttribute('novalidate'), equals('true'));
}__Skip__);

test('should clear attribute "novalidate" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), noValidate: true),
            __WidgetClass__(key: Key('el-2'), noValidate: true),
            __WidgetClass__(key: Key('el-3'), noValidate: true),
            __WidgetClass__(key: Key('el-4'), noValidate: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), noValidate: true),
            __WidgetClass__(key: Key('el-2'), noValidate: false),
            __WidgetClass__(key: Key('el-3'), noValidate: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('novalidate'), equals('true'));
    expect(domNode2.getAttribute('novalidate'), equals(null));
    expect(domNode3.getAttribute('novalidate'), equals(null));
    expect(domNode4.getAttribute('novalidate'), equals(null));
});