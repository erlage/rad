test('should set attribute "controls" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), controls: false),
            __WidgetClass__(key: Key('el-2'), controls: null),
            __WidgetClass__(key: Key('el-3'), controls: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('controls'), equals(null));
    expect(domNode2.getAttribute('controls'), equals(null));
    expect(domNode3.getAttribute('controls'), equals('true'));
}__Skip__);

test('should clear attribute "controls" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), controls: true),
            __WidgetClass__(key: Key('el-2'), controls: true),
            __WidgetClass__(key: Key('el-3'), controls: true),
            __WidgetClass__(key: Key('el-4'), controls: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), controls: true),
            __WidgetClass__(key: Key('el-2'), controls: false),
            __WidgetClass__(key: Key('el-3'), controls: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('controls'), equals('true'));
    expect(domNode2.getAttribute('controls'), equals(null));
    expect(domNode3.getAttribute('controls'), equals(null));
    expect(domNode4.getAttribute('controls'), equals(null));
});