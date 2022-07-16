test('should set attribute "media"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), media: 'some-media'),
        __WidgetClass__(key: Key('el-2'), media: 'another-media'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('media'), equals('some-media'));
    expect(domNode2.getAttribute('media'), equals('another-media'));
}__Skip__);

test('should update attribute "media"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), media: 'some-media'),
        __WidgetClass__(key: Key('el-2'), media: 'another-media'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), media: 'updated-media'),
        __WidgetClass__(key: Key('el-2'), media: 'another-media'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('media'), equals('updated-media'));
    expect(domNode2.getAttribute('media'), equals('another-media'));
}__Skip__);

test('should clear attribute "media"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), media: 'another-media'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2')),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('media'), equals(null));
    expect(domNode2.getAttribute('media'), equals(null));
});

test('should clear attribute "media" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), media: 'some-media'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), media: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('media'), equals(null));
});

test('should not set attribute "media" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), media: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('media'), equals(null));
});

test('should set messy "media"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        media: 'some media',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        media: 'some "messy" media',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        media: "some 'messy' media",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('media'),
    equals('some media'),
  );

  expect(
    domNode2.getAttribute('media'),
    equals('some "messy" media'),
  );

  expect(
    domNode3.getAttribute('media'),
    equals("some 'messy' media"),
  );
}__Skip__);
