test('should set attribute "autocomplete"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), autoComplete: 'some-autocomplete'),
        __WidgetClass__(key: Key('el-2'), autoComplete: 'another-autocomplete'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('autocomplete'), equals('some-autocomplete'));
    expect(domNode2.getAttribute('autocomplete'), equals('another-autocomplete'));
}__Skip__);

test('should update attribute "autocomplete"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), autoComplete: 'some-autocomplete'),
        __WidgetClass__(key: Key('el-2'), autoComplete: 'another-autocomplete'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), autoComplete: 'updated-autocomplete'),
        __WidgetClass__(key: Key('el-2'), autoComplete: 'another-autocomplete'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('autocomplete'), equals('updated-autocomplete'));
    expect(domNode2.getAttribute('autocomplete'), equals('another-autocomplete'));
}__Skip__);

test('should clear attribute "autocomplete"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), autoComplete: 'another-autocomplete'),
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

    expect(domNode1.getAttribute('autocomplete'), equals(null));
    expect(domNode2.getAttribute('autocomplete'), equals(null));
});

test('should clear attribute "autocomplete" if updated autocomplete is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), autoComplete: 'some-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), autoComplete: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('autocomplete'), equals(null));
});

test('should not set attribute "autocomplete" if provided autocomplete is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), autoComplete: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('autocomplete'), equals(null));
});
