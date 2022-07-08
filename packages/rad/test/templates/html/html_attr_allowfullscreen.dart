test('should set attribute "allowFullscreen" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), allowFullscreen: false),
            __WidgetClass__(key: Key('el-2'), allowFullscreen: null),
            __WidgetClass__(key: Key('el-3'), allowFullscreen: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('allowfullscreen'), equals(null));
    expect(domNode2.getAttribute('allowfullscreen'), equals(null));
    expect(domNode3.getAttribute('allowfullscreen'), equals('true'));
}__Skip__);

test('should clear attribute "allowFullscreen" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), allowFullscreen: true),
            __WidgetClass__(key: Key('el-2'), allowFullscreen: true),
            __WidgetClass__(key: Key('el-3'), allowFullscreen: true),
            __WidgetClass__(key: Key('el-4'), allowFullscreen: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), allowFullscreen: true),
            __WidgetClass__(key: Key('el-2'), allowFullscreen: false),
            __WidgetClass__(key: Key('el-3'), allowFullscreen: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('allowfullscreen'), equals('true'));
    expect(domNode2.getAttribute('allowfullscreen'), equals(null));
    expect(domNode3.getAttribute('allowfullscreen'), equals(null));
    expect(domNode4.getAttribute('allowfullscreen'), equals(null));
});