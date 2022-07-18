test('should set ordered list attribute "preload"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), preload: PreloadType.none),
          __WidgetClass__(key: Key('el-2'), preload: PreloadType.metaData),
          __WidgetClass__(key: Key('el-3'), preload: PreloadType.auto),
          __WidgetClass__(key: Key('el-4'), preload: PreloadType.empty),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(
      domNode1.getAttribute('preload'),
      equals(PreloadType.none.nativeValue),
    );
    expect(
      domNode2.getAttribute('preload'),
      equals(PreloadType.metaData.nativeValue),
    );
    expect(
      domNode3.getAttribute('preload'),
      equals(PreloadType.auto.nativeValue),
    );
    expect(
      domNode4.getAttribute('preload'),
      equals(PreloadType.empty.nativeValue),
    );
});

test('should update ordered list attribute "preload"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), preload: PreloadType.none),
          __WidgetClass__(key: Key('el-2'), preload: PreloadType.metaData),
          __WidgetClass__(key: Key('el-3'), preload: PreloadType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1')),
          __WidgetClass__(key: Key('el-2'), preload: null),
          __WidgetClass__(key: Key('el-3'), preload: PreloadType.empty),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('preload'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('preload'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('preload'),
        equals(PreloadType.empty.nativeValue),
    );
});
