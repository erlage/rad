test('should set correct input type if "isPassword" is set', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), isPassword: false),
            __WidgetClass__(key: Key('el-2'), isPassword: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('type'), equals('text'));
    expect(domNode2.getAttribute('type'), equals('password'));
}__Skip__);

test('should update input type if "isPassword" is set', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), isPassword: false),
            __WidgetClass__(key: Key('el-2'), isPassword: true),
            __WidgetClass__(key: Key('el-3'), isPassword: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), isPassword: true),
            __WidgetClass__(key: Key('el-2'), isPassword: false),
            __WidgetClass__(key: Key('el-3')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('type'), equals('password'));
    expect(domNode2.getAttribute('type'), equals('text'));

    if('$__WidgetClass__' == 'InputText') {
        // InputText should set input type to text if user doesn't
        // set isPassword
        expect(domNode3.getAttribute('type'), equals('text'));
    }
});