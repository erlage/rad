test('should set attribute "spellcheck"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), spellCheck: SpellCheckType.trueValue),
          __WidgetClass__(key: Key('el-2'), spellCheck: SpellCheckType.falseValue),
          __WidgetClass__(key: Key('el-3'), spellCheck: SpellCheckType.defaultValue),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
      domNode1.getAttribute('spellcheck'),
      equals('true'),
    );
    expect(
      domNode2.getAttribute('spellcheck'),
      equals('false'),
    );
    expect(
      domNode3.getAttribute('spellcheck'),
      equals('default'),
    );
});

test('should update attribute "spellcheck"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), spellCheck: SpellCheckType.trueValue),
          __WidgetClass__(key: Key('el-2'), spellCheck: SpellCheckType.falseValue),
          __WidgetClass__(key: Key('el-3'), spellCheck: SpellCheckType.defaultValue),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1')),
          __WidgetClass__(key: Key('el-2'), spellCheck: null),
          __WidgetClass__(key: Key('el-3'), spellCheck: SpellCheckType.falseValue),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('spellcheck'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('spellcheck'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('spellcheck'),
        equals('false'),
    );
});
