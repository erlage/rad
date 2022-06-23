test('should set button attribute "type"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), type: ButtonType.button),
            __WidgetClass__(key: GlobalKey('el-2'), type: ButtonType.reset),
            __WidgetClass__(key: GlobalKey('el-3'), type: ButtonType.submit),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');
    var domNode3 = app!.domNodeByGlobalKey('el-3');

    expect(domNode1.getAttribute('type'), equals('button'));
    expect(domNode2.getAttribute('type'), equals('reset'));
    expect(domNode3.getAttribute('type'), equals('submit'));
}__Skip__);

test('should update button attribute "type"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), type: ButtonType.button),
            __WidgetClass__(key: GlobalKey('el-2'), type: ButtonType.reset),
            __WidgetClass__(key: GlobalKey('el-3'), type: ButtonType.submit),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1')),
            __WidgetClass__(key: GlobalKey('el-2'), type: null),
            __WidgetClass__(key: GlobalKey('el-3'), type: ButtonType.button),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');
    var domNode3 = app!.domNodeByGlobalKey('el-3');

    expect(domNode1.getAttribute('type'), equals(null));
    expect(domNode2.getAttribute('type'), equals(null));
    expect(domNode3.getAttribute('type'), equals('button'));
}__Skip__);