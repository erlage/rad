test('should set attribute "list"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), list: 'some-list'),
            __WidgetClass__(key: Key('el-2'), list: 'another-list'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('list'), equals('some-list'));
    expect(domNode2.getAttribute('list'), equals('another-list'));
}__Skip__);

test('should update attribute "list"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), list: 'some-list'),
            __WidgetClass__(key: Key('el-2'), list: 'another-list'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), list: 'updated-list'),
            __WidgetClass__(key: Key('el-2'), list: 'another-list'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('list'), equals('updated-list'));
    expect(domNode2.getAttribute('list'), equals('another-list'));
}__Skip__);

test('should clear attribute "list"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), list: 'another-list'),
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

    expect(domNode1.getAttribute('list'), equals(null));
    expect(domNode2.getAttribute('list'), equals(null));
});

test('should clear attribute "list" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), list: 'some-list'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), list: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('list'), equals(null));
});

test('should not set attribute "list" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), list: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('list'), equals(null));
});

test('should set messy "list"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        list: 'some list',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        list: 'some "messy" list',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        list: "some 'messy' list",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('list'),
    equals('some list'),
  );

  expect(
    domNode2.getAttribute('list'),
    equals('some "messy" list'),
  );

  expect(
    domNode3.getAttribute('list'),
    equals("some 'messy' list"),
  );
}__Skip__);
