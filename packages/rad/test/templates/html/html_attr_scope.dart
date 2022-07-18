test('should set ordered list attribute "scope"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), scope: ScopeType.row),
          __WidgetClass__(key: Key('el-2'), scope: ScopeType.column),
          __WidgetClass__(key: Key('el-3'), scope: ScopeType.rowGroup),
          __WidgetClass__(key: Key('el-4'), scope: ScopeType.columnGroup),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(
      domNode1.getAttribute('scope'),
      equals('row'),
    );
    expect(
      domNode2.getAttribute('scope'),
      equals('col'),
    );
    expect(
      domNode3.getAttribute('scope'),
      equals('rowgroup'),
    );
    expect(
      domNode4.getAttribute('scope'),
      equals('colgroup'),
    );
});

test('should update ordered list attribute "scope"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), scope: ScopeType.row),
          __WidgetClass__(key: Key('el-2'), scope: ScopeType.column),
          __WidgetClass__(key: Key('el-3'), scope: ScopeType.rowGroup),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1')),
          __WidgetClass__(key: Key('el-2'), scope: null),
          __WidgetClass__(key: Key('el-3'), scope: ScopeType.columnGroup),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('scope'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('scope'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('scope'),
        equals('colgroup'),
    );
});
