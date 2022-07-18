test('should set form attribute "formenctype"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formEncType: FormEncType.textPlain),
            __WidgetClass__(key: Key('el-2'), formEncType: FormEncType.multipartFormData),
            __WidgetClass__(
                key: Key('el-3'),
                formEncType: FormEncType.applicationXwwwFormUrlEncoded,
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('formenctype'),
        equals('text/plain'),
    );
    expect(
        domNode2.getAttribute('formenctype'),
        equals('multipart/form-data'),
    );
    expect(
        domNode3.getAttribute('formenctype'),
        equals('application/x-www-form-urlencoded'),
    );
});

test('should update form attribute "formenctype"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formEncType: FormEncType.textPlain),
            __WidgetClass__(key: Key('el-2'), formEncType: FormEncType.multipartFormData),
            __WidgetClass__(
                key: Key('el-3'),
                formEncType: FormEncType.applicationXwwwFormUrlEncoded,
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), formEncType: null),
            __WidgetClass__(key: Key('el-3'), formEncType: FormEncType.multipartFormData),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('formenctype'), equals(null));
    expect(domNode2.getAttribute('formenctype'), equals(null));

    expect(
        domNode3.getAttribute('formenctype'),
        equals(FormEncType.multipartFormData.nativeValue),
    );
});