test('should set attribute "kind"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), kind: KindType.subtitles),
          __WidgetClass__(key: Key('el-2'), kind: KindType.captions),
          __WidgetClass__(key: Key('el-3'), kind: KindType.descriptions),
          __WidgetClass__(key: Key('el-4'), kind: KindType.chapters),
          __WidgetClass__(key: Key('el-5'), kind: KindType.metadata),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');
    var domNode5 = app!.domNodeByKeyValue('el-5');

    expect(
      domNode1.getAttribute('kind'),
      equals(KindType.subtitles.nativeValue),
    );
    expect(
      domNode2.getAttribute('kind'),
      equals(KindType.captions.nativeValue),
    );
    expect(
      domNode3.getAttribute('kind'),
      equals(KindType.descriptions.nativeValue),
    );
    expect(
      domNode4.getAttribute('kind'),
      equals(KindType.chapters.nativeValue),
    );
    expect(
      domNode5.getAttribute('kind'),
      equals(KindType.metadata.nativeValue),
    );
});

test('should update attribute "kind"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), kind: KindType.subtitles),
          __WidgetClass__(key: Key('el-2'), kind: KindType.captions),
          __WidgetClass__(key: Key('el-3'), kind: KindType.descriptions),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1')),
          __WidgetClass__(key: Key('el-2'), kind: null),
          __WidgetClass__(key: Key('el-3'), kind: KindType.chapters),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('kind'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('kind'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('kind'),
        equals(KindType.chapters.nativeValue),
    );
});
