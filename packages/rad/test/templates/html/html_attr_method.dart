test('should set form attribute "method"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), method: FormMethodType.get),
            __WidgetClass__(key: Key('el-2'), method: FormMethodType.post),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(
        domNode1.getAttribute('method'),
        equals(FormMethodType.get.nativeValue),
    );
    expect(
        domNode2.getAttribute('method'),
        equals(FormMethodType.post.nativeValue),
    );
});

test('should update form attribute "method"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), method: FormMethodType.get),
            __WidgetClass__(key: Key('el-2'), method: FormMethodType.post),
            __WidgetClass__(key: Key('el-3'), method: FormMethodType.get),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), method: null),
            __WidgetClass__(key: Key('el-3'), method: FormMethodType.post),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('method'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('method'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('method'),
        equals(FormMethodType.post.nativeValue),
    );
});
