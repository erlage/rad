test('should set ordered list attribute "decoding"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), decoding: DecodingType.sync),
          __WidgetClass__(key: Key('el-2'), decoding: DecodingType.async),
          __WidgetClass__(key: Key('el-3'), decoding: DecodingType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
      domNode1.getAttribute('decoding'),
      equals(DecodingType.sync.nativeName),
    );
    expect(
      domNode2.getAttribute('decoding'),
      equals(DecodingType.async.nativeName),
    );
    expect(
      domNode3.getAttribute('decoding'),
      equals(DecodingType.auto.nativeName),
    );
});

test('should update ordered list attribute "decoding"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), decoding: DecodingType.sync),
          __WidgetClass__(key: Key('el-2'), decoding: DecodingType.async),
          __WidgetClass__(key: Key('el-3'), decoding: DecodingType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1')),
          __WidgetClass__(key: Key('el-2'), decoding: null),
          __WidgetClass__(key: Key('el-3'), decoding: DecodingType.sync),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('decoding'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('decoding'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('decoding'),
        equals(DecodingType.sync.nativeName),
    );
});
