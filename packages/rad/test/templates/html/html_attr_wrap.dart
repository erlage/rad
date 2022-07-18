test('should set attribute "wrap"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), wrap: WrapType.hard),
          __WidgetClass__(key: Key('el-2'), wrap: WrapType.soft),
          __WidgetClass__(key: Key('el-3'), wrap: WrapType.off),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
      domNode1.getAttribute('wrap'),
      equals('hard'),
    );
    expect(
      domNode2.getAttribute('wrap'),
      equals('soft'),
    );
    expect(
      domNode3.getAttribute('wrap'),
      equals('off'),
    );
});

test('should update attribute "wrap"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), wrap: WrapType.hard),
          __WidgetClass__(key: Key('el-2'), wrap: WrapType.soft),
          __WidgetClass__(key: Key('el-3'), wrap: WrapType.off),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1')),
          __WidgetClass__(key: Key('el-2'), wrap: null),
          __WidgetClass__(key: Key('el-3'), wrap: WrapType.soft),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('wrap'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('wrap'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('wrap'),
        equals('soft'),
    );
});
