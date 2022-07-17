test('should set form attribute "loading"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), loading: LoadingType.eager),
            __WidgetClass__(key: Key('el-2'), loading: LoadingType.lazy),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(
        domNode1.getAttribute('loading'),
        equals(LoadingType.eager.nativeName),
    );
    expect(
        domNode2.getAttribute('loading'),
        equals(LoadingType.lazy.nativeName),
    );
});

test('should update form attribute "loading"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), loading: LoadingType.eager),
            __WidgetClass__(key: Key('el-2'), loading: LoadingType.lazy),
            __WidgetClass__(key: Key('el-3'), loading: LoadingType.eager),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), loading: null),
            __WidgetClass__(key: Key('el-3'), loading: LoadingType.lazy),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('loading'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('loading'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('loading'),
        equals(LoadingType.lazy.nativeName),
    );
});
