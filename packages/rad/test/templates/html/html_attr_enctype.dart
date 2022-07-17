test('should set form attribute "enctype"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), enctype: FormEncType.textPlain),
            __WidgetClass__(key: Key('el-2'), enctype: FormEncType.multipartFormData),
            __WidgetClass__(
                key: Key('el-3'),
                enctype: FormEncType.applicationXwwwFormUrlEncoded,
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('enctype'),
        equals('text/plain'),
    );
    expect(
        domNode2.getAttribute('enctype'),
        equals('multipart/form-data'),
    );
    expect(
        domNode3.getAttribute('enctype'),
        equals('application/x-www-form-urlencoded'),
    );
});

test('should update form attribute "enctype"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), enctype: FormEncType.textPlain),
            __WidgetClass__(key: Key('el-2'), enctype: FormEncType.multipartFormData),
            __WidgetClass__(
                key: Key('el-3'),
                enctype: FormEncType.applicationXwwwFormUrlEncoded,
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), enctype: null),
            __WidgetClass__(key: Key('el-3'), enctype: FormEncType.multipartFormData),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('enctype'), equals(null));
    expect(domNode2.getAttribute('enctype'), equals(null));

    expect(
        domNode3.getAttribute('enctype'),
        equals(FormEncType.multipartFormData.nativeName),
    );
});