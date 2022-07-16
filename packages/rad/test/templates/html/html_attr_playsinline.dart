test('should set attribute "playsinline" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), playsInline: false),
            __WidgetClass__(key: Key('el-2'), playsInline: null),
            __WidgetClass__(key: Key('el-3'), playsInline: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('playsinline'), equals(null));
    expect(domNode2.getAttribute('playsinline'), equals(null));
    expect(domNode3.getAttribute('playsinline'), equals('true'));
}__Skip__);

test('should clear attribute "playsinline" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), playsInline: true),
            __WidgetClass__(key: Key('el-2'), playsInline: true),
            __WidgetClass__(key: Key('el-3'), playsInline: true),
            __WidgetClass__(key: Key('el-4'), playsInline: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), playsInline: true),
            __WidgetClass__(key: Key('el-2'), playsInline: false),
            __WidgetClass__(key: Key('el-3'), playsInline: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('playsinline'), equals('true'));
    expect(domNode2.getAttribute('playsinline'), equals(null));
    expect(domNode3.getAttribute('playsinline'), equals(null));
    expect(domNode4.getAttribute('playsinline'), equals(null));
});