test('should set attribute "required" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), required: false),
            __WidgetClass__(key: Key('el-2'), required: null),
            __WidgetClass__(key: Key('el-3'), required: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('required'), equals(null));
    expect(domNode2.getAttribute('required'), equals(null));
    expect(domNode3.getAttribute('required'), equals('true'));
}__Skip__);

test('should clear attribute "required" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), required: true),
            __WidgetClass__(key: Key('el-2'), required: true),
            __WidgetClass__(key: Key('el-3'), required: true),
            __WidgetClass__(key: Key('el-4'), required: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), required: true),
            __WidgetClass__(key: Key('el-2'), required: false),
            __WidgetClass__(key: Key('el-3'), required: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('required'), equals('true'));
    expect(domNode2.getAttribute('required'), equals(null));
    expect(domNode3.getAttribute('required'), equals(null));
    expect(domNode4.getAttribute('required'), equals(null));
});