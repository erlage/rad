test('should set attribute "dirname"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), dirName: 'some-dirname'),
            __WidgetClass__(key: Key('el-2'), dirName: 'another-dirname'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('dirname'), equals('some-dirname'));
    expect(domNode2.getAttribute('dirname'), equals('another-dirname'));
}__Skip__);

test('should update attribute "dirname"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), dirName: 'some-dirname'),
            __WidgetClass__(key: Key('el-2'), dirName: 'another-dirname'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), dirName: 'updated-dirname'),
            __WidgetClass__(key: Key('el-2'), dirName: 'another-dirname'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('dirname'), equals('updated-dirname'));
    expect(domNode2.getAttribute('dirname'), equals('another-dirname'));
}__Skip__);

test('should clear attribute "dirname"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), dirName: 'another-dirname'),
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

    expect(domNode1.getAttribute('dirname'), equals(null));
    expect(domNode2.getAttribute('dirname'), equals(null));
});

test('should clear attribute "dirname" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), dirName: 'some-dirname'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), dirName: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('dirname'), equals(null));
});

test('should not set attribute "dirname" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), dirName: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('dirname'), equals(null));
});

test('should set messy "dirname"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        dirName: 'some dirname',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        dirName: 'some "messy" dirname',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        dirName: "some 'messy' dirname",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('dirname'),
    equals('some dirname'),
  );

  expect(
    domNode2.getAttribute('dirname'),
    equals('some "messy" dirname'),
  );

  expect(
    domNode3.getAttribute('dirname'),
    equals("some 'messy' dirname"),
  );
}__Skip__);
