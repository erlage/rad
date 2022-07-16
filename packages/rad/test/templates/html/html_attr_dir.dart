test('should set attribute "dir"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), dir: TextDirection.leftToRight),
          __WidgetClass__(key: Key('el-2'), dir: TextDirection.rightToLeft),
          __WidgetClass__(key: Key('el-3'), dir: TextDirection.auto),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
      domNode1.getAttribute('dir'),
      equals(TextDirection.leftToRight.nativeName),
    );
    expect(
      domNode2.getAttribute('dir'),
      equals(TextDirection.rightToLeft.nativeName),
    );
    expect(
      domNode3.getAttribute('dir'),
      equals(TextDirection.auto.nativeName),
    );
});

test('should update attribute "dir"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), dir: TextDirection.leftToRight),
          __WidgetClass__(key: Key('el-2'), dir: TextDirection.rightToLeft),
          __WidgetClass__(key: Key('el-3'), dir: TextDirection.auto),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1')),
          __WidgetClass__(key: Key('el-2'), dir: null),
          __WidgetClass__(key: Key('el-3'), dir: TextDirection.leftToRight),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('dir'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('dir'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('dir'),
        equals(TextDirection.leftToRight.nativeName),
    );
});
