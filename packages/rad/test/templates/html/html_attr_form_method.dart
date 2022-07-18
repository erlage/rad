test('should set form attribute "formmethod"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formMethod: FormMethodType.get),
            __WidgetClass__(key: Key('el-2'), formMethod: FormMethodType.post),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(
        domNode1.getAttribute('formmethod'),
        equals(FormMethodType.get.nativeValue),
    );
    expect(
        domNode2.getAttribute('formmethod'),
        equals(FormMethodType.post.nativeValue),
    );
});

test('should update form attribute "formmethod"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formMethod: FormMethodType.get),
            __WidgetClass__(key: Key('el-2'), formMethod: FormMethodType.post),
            __WidgetClass__(key: Key('el-3'), formMethod: FormMethodType.get),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), formMethod: null),
            __WidgetClass__(key: Key('el-3'), formMethod: FormMethodType.post),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('formmethod'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('formmethod'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('formmethod'),
        equals(FormMethodType.post.nativeValue),
    );
});
