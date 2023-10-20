test('should set attribute "name"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), name: 'some-name'),
        __WidgetClass__(key: Key('el-2'), name: 'another-name'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('name'), equals('some-name'));
    expect(domNode2.getAttribute('name'), equals('another-name'));
}__Skip__);

test('should update attribute "name"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), name: 'some-name'),
        __WidgetClass__(key: Key('el-2'), name: 'another-name'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), name: 'updated-name'),
        __WidgetClass__(key: Key('el-2'), name: 'another-name'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('name'), equals('updated-name'));
    expect(domNode2.getAttribute('name'), equals('another-name'));
}__Skip__);

test('should clear attribute "name"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), name: 'another-name'),
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

    expect(domNode1.getAttribute('name'), equals(null));
    expect(domNode2.getAttribute('name'), equals(null));
});

test('should clear attribute "name" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), name: 'some-name'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), name: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('name'), equals(null));
});

test('should not set attribute "name" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), name: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('name'), equals(null));
});

test('should set messy "name"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        name: 'some name',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        name: 'some "messy" name',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        name: "some 'messy' name",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('name'),
    equals('some name'),
  );

  expect(
    domNode2.getAttribute('name'),
    equals('some "messy" name'),
  );

  expect(
    domNode3.getAttribute('name'),
    equals("some 'messy' name"),
  );
}__Skip__);