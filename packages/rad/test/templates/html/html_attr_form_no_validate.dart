test('should set attribute "formnovalidate" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formNoValidate: false),
            __WidgetClass__(key: Key('el-2'), formNoValidate: null),
            __WidgetClass__(key: Key('el-3'), formNoValidate: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('formnovalidate'), equals(null));
    expect(domNode2.getAttribute('formnovalidate'), equals(null));
    expect(domNode3.getAttribute('formnovalidate'), equals('true'));
}__Skip__);

test('should clear attribute "formnovalidate" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formNoValidate: true),
            __WidgetClass__(key: Key('el-2'), formNoValidate: true),
            __WidgetClass__(key: Key('el-3'), formNoValidate: true),
            __WidgetClass__(key: Key('el-4'), formNoValidate: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formNoValidate: true),
            __WidgetClass__(key: Key('el-2'), formNoValidate: false),
            __WidgetClass__(key: Key('el-3'), formNoValidate: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('formnovalidate'), equals('true'));
    expect(domNode2.getAttribute('formnovalidate'), equals(null));
    expect(domNode3.getAttribute('formnovalidate'), equals(null));
    expect(domNode4.getAttribute('formnovalidate'), equals(null));
});