test('should set ordered list attribute "preload"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), preload: AudioPreloadType.none),
          __WidgetClass__(key: Key('el-2'), preload: AudioPreloadType.metaData),
          __WidgetClass__(key: Key('el-3'), preload: AudioPreloadType.auto),
          __WidgetClass__(key: Key('el-4'), preload: AudioPreloadType.empty),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(
      domNode1.getAttribute('preload'),
      equals(AudioPreloadType.none.nativeName),
    );
    expect(
      domNode2.getAttribute('preload'),
      equals(AudioPreloadType.metaData.nativeName),
    );
    expect(
      domNode3.getAttribute('preload'),
      equals(AudioPreloadType.auto.nativeName),
    );
    expect(
      domNode4.getAttribute('preload'),
      equals(AudioPreloadType.empty.nativeName),
    );
});

test('should update ordered list attribute "preload"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), preload: AudioPreloadType.none),
          __WidgetClass__(key: Key('el-2'), preload: AudioPreloadType.metaData),
          __WidgetClass__(key: Key('el-3'), preload: AudioPreloadType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1')),
          __WidgetClass__(key: Key('el-2'), preload: null),
          __WidgetClass__(key: Key('el-3'), preload: AudioPreloadType.empty),
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
        equals(AudioPreloadType.empty.nativeName),
    );
});
