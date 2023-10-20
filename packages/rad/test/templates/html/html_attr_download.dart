test('should set attribute "download"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), download: 'some-download'),
        __WidgetClass__(key: Key('el-2'), download: 'another-download'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('download'), equals('some-download'));
    expect(domNode2.getAttribute('download'), equals('another-download'));
}__Skip__);

test('should update attribute "download"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), download: 'some-download'),
        __WidgetClass__(key: Key('el-2'), download: 'another-download'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), download: 'updated-download'),
        __WidgetClass__(key: Key('el-2'), download: 'another-download'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('download'), equals('updated-download'));
    expect(domNode2.getAttribute('download'), equals('another-download'));
}__Skip__);

test('should clear attribute "download"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), download: 'another-download'),
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

    expect(domNode1.getAttribute('download'), equals(null));
    expect(domNode2.getAttribute('download'), equals(null));
});

test('should clear attribute "download" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), download: 'some-download'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), download: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('download'), equals(null));
});

test('should not set attribute "download" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), download: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('download'), equals(null));
});

test('should set messy "download"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        download: 'some download',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        download: 'some "messy" download',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        download: "some 'messy' download",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('download'),
    equals('some download'),
  );

  expect(
    domNode2.getAttribute('download'),
    equals('some "messy" download'),
  );

  expect(
    domNode3.getAttribute('download'),
    equals("some 'messy' download"),
  );
}__Skip__);
