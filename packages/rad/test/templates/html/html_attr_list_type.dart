test('should set ordered list attribute "type"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), type: ListType.lowerCaseLetters),
          __WidgetClass__(key: Key('el-2'), type: ListType.upperCaseLetters),
          __WidgetClass__(key: Key('el-3'), type: ListType.lowerCaseRomanNumerals),
          __WidgetClass__(key: Key('el-4'), type: ListType.upperCaseRomanNumerals),
          __WidgetClass__(key: Key('el-5'), type: ListType.numbers),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');
    var domNode5 = app!.domNodeByKeyValue('el-5');

    expect(
      domNode1.getAttribute('type'),
      equals(ListType.lowerCaseLetters.nativeValue),
    );
    expect(
      domNode2.getAttribute('type'),
      equals(ListType.upperCaseLetters.nativeValue),
    );
    expect(
      domNode3.getAttribute('type'),
      equals(ListType.lowerCaseRomanNumerals.nativeValue),
    );
    expect(
      domNode4.getAttribute('type'),
      equals(ListType.upperCaseRomanNumerals.nativeValue),
    );
    expect(
      domNode5.getAttribute('type'),
      equals(ListType.numbers.nativeValue),
    );
});

test('should update ordered list attribute "type"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), type: ListType.lowerCaseLetters),
          __WidgetClass__(key: Key('el-2'), type: ListType.upperCaseLetters),
          __WidgetClass__(key: Key('el-3'), type: ListType.lowerCaseRomanNumerals),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1')),
          __WidgetClass__(key: Key('el-2'), type: null),
          __WidgetClass__(key: Key('el-3'), type: ListType.upperCaseRomanNumerals),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('type'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('type'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('type'),
        equals(ListType.upperCaseRomanNumerals.nativeValue),
    );
});
