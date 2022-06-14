test('should set input attribute "type"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1')),
            __WidgetClass__(key: GlobalKey('el-2'), type: null),
            __WidgetClass__(key: GlobalKey('el-3'), type: InputType.text),
            __WidgetClass__(key: GlobalKey('el-4'), type: InputType.password),
            __WidgetClass__(key: GlobalKey('el-5'), type: InputType.radio),
            __WidgetClass__(key: GlobalKey('el-6'), type: InputType.checkbox),
            __WidgetClass__(key: GlobalKey('el-7'), type: InputType.submit),
            __WidgetClass__(key: GlobalKey('el-8'), type: InputType.file),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');
    var domNode3 = app!.domNodeByGlobalKey('el-3');
    var domNode4 = app!.domNodeByGlobalKey('el-4');
    var domNode5 = app!.domNodeByGlobalKey('el-5');
    var domNode6 = app!.domNodeByGlobalKey('el-6');
    var domNode7 = app!.domNodeByGlobalKey('el-7');
    var domNode8 = app!.domNodeByGlobalKey('el-8');

    expect(domNode1.getAttribute('type'), equals(null));
    expect(domNode2.getAttribute('type'), equals(null));
    expect(domNode3.getAttribute('type'), equals('text'));
    expect(domNode4.getAttribute('type'), equals('password'));
    expect(domNode5.getAttribute('type'), equals('radio'));
    expect(domNode6.getAttribute('type'), equals('checkbox'));
    expect(domNode7.getAttribute('type'), equals('submit'));
    expect(domNode8.getAttribute('type'), equals('file'));
}__Skip__);

test('should update form attribute "type"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1')),
            __WidgetClass__(key: GlobalKey('el-2'), type: null),
            __WidgetClass__(key: GlobalKey('el-3'), type: InputType.text),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), type: InputType.text),
            __WidgetClass__(key: GlobalKey('el-2'), type: null),
            __WidgetClass__(key: GlobalKey('el-3')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');
    var domNode3 = app!.domNodeByGlobalKey('el-3');

    expect(domNode1.getAttribute('type'), equals('text'));
    expect(domNode2.getAttribute('type'), equals(null));
    expect(domNode3.getAttribute('type'), equals(null));
});