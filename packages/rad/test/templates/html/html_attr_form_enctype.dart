test('should set form attribute "enctype"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), enctype: FormEncType.textPlain),
            __WidgetClass__(key: GlobalKey('el-2'), enctype: FormEncType.multipartFormData),
            __WidgetClass__(
                key: GlobalKey('el-3'),
                enctype: FormEncType.applicationXwwwFormUrlEncoded,
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');
    var domNode3 = app!.domNodeByGlobalKey('el-3');

    expect(
        domNode1.getAttribute('enctype'),
        equals(FormEncType.textPlain.nativeName),
    );
    expect(
        domNode2.getAttribute('enctype'),
        equals(FormEncType.multipartFormData.nativeName),
    );
    expect(
        domNode3.getAttribute('enctype'),
        equals(FormEncType.applicationXwwwFormUrlEncoded.nativeName),
    );
});

test('should update form attribute "enctype"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), enctype: FormEncType.textPlain),
            __WidgetClass__(key: GlobalKey('el-2'), enctype: FormEncType.multipartFormData),
            __WidgetClass__(
                key: GlobalKey('el-3'),
                enctype: FormEncType.applicationXwwwFormUrlEncoded,
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1')),
            __WidgetClass__(key: GlobalKey('el-2'), enctype: null),
            __WidgetClass__(key: GlobalKey('el-3'), enctype: FormEncType.multipartFormData),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');
    var domNode3 = app!.domNodeByGlobalKey('el-3');

    expect(domNode1.getAttribute('enctype'), equals(null));
    expect(domNode2.getAttribute('enctype'), equals(null));

    expect(
        domNode3.getAttribute('enctype'),
        equals(FormEncType.multipartFormData.nativeName),
    );
});