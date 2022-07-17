test('should set attribute "formtarget"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), formTarget: 'some-formtarget'),
        __WidgetClass__(key: Key('el-2'), formTarget: 'another-formtarget'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('formtarget'), equals('some-formtarget'));
    expect(domNode2.getAttribute('formtarget'), equals('another-formtarget'));
}__Skip__);

test('should update attribute "formtarget"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), formTarget: 'some-formtarget'),
        __WidgetClass__(key: Key('el-2'), formTarget: 'another-formtarget'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), formTarget: 'updated-formtarget'),
        __WidgetClass__(key: Key('el-2'), formTarget: 'another-formtarget'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('formtarget'), equals('updated-formtarget'));
    expect(domNode2.getAttribute('formtarget'), equals('another-formtarget'));
}__Skip__);

test('should clear attribute "formtarget"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), formTarget: 'another-formtarget'),
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

    expect(domNode1.getAttribute('formtarget'), equals(null));
    expect(domNode2.getAttribute('formtarget'), equals(null));
});

test('should clear attribute "formtarget" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formTarget: 'some-formtarget'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formTarget: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('formtarget'), equals(null));
});

test('should not set attribute "formtarget" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formTarget: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('formtarget'), equals(null));
});
