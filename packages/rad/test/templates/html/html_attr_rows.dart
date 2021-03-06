test('should set attribute "rows"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), rows: 10),
            __WidgetClass__(key: Key('el-2'), rows: 0),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('rows'), equals('10'));
    expect(domNode2.getAttribute('rows'), equals('0'));
}__Skip__);

test('should update attribute "rows"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), rows: 10),
            __WidgetClass__(key: Key('el-2'), rows: 10),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), rows: 20),
            __WidgetClass__(key: Key('el-2'), rows: 20),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('rows'), equals('20'));
    expect(domNode2.getAttribute('rows'), equals('20'));
}__Skip__);

test('should clear attribute "rows"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), rows: 10),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('rows'), equals(null));
    expect(domNode2.getAttribute('rows'), equals(null));
});

test('should clear attribute "rows" if updated value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), rows: 10),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), rows: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('rows'), equals(null));
});

test('should not set attribute "rows" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), rows: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('rows'), equals(null));
});