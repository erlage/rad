test('should set attribute "loop" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), loop: false),
            __WidgetClass__(key: Key('el-2'), loop: null),
            __WidgetClass__(key: Key('el-3'), loop: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('loop'), equals(null));
    expect(domNode2.getAttribute('loop'), equals(null));
    expect(domNode3.getAttribute('loop'), equals('true'));
}__Skip__);

test('should clear attribute "loop" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), loop: true),
            __WidgetClass__(key: Key('el-2'), loop: true),
            __WidgetClass__(key: Key('el-3'), loop: true),
            __WidgetClass__(key: Key('el-4'), loop: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), loop: true),
            __WidgetClass__(key: Key('el-2'), loop: false),
            __WidgetClass__(key: Key('el-3'), loop: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('loop'), equals('true'));
    expect(domNode2.getAttribute('loop'), equals(null));
    expect(domNode3.getAttribute('loop'), equals(null));
    expect(domNode4.getAttribute('loop'), equals(null));
});