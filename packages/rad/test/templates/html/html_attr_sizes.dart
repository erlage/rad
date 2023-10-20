test('should set attribute "sizes"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), sizes: 'some-sizes'),
        __WidgetClass__(key: Key('el-2'), sizes: 'another-sizes'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('sizes'), equals('some-sizes'));
    expect(domNode2.getAttribute('sizes'), equals('another-sizes'));
}__Skip__);

test('should update attribute "sizes"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), sizes: 'some-sizes'),
        __WidgetClass__(key: Key('el-2'), sizes: 'another-sizes'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), sizes: 'updated-sizes'),
        __WidgetClass__(key: Key('el-2'), sizes: 'another-sizes'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('sizes'), equals('updated-sizes'));
    expect(domNode2.getAttribute('sizes'), equals('another-sizes'));
}__Skip__);

test('should clear attribute "sizes"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), sizes: 'another-sizes'),
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

    expect(domNode1.getAttribute('sizes'), equals(null));
    expect(domNode2.getAttribute('sizes'), equals(null));
});

test('should clear attribute "sizes" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), sizes: 'some-sizes'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), sizes: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('sizes'), equals(null));
});

test('should not set attribute "sizes" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), sizes: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('sizes'), equals(null));
});

test('should set messy "sizes"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        sizes: 'some sizes',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        sizes: 'some "messy" sizes',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        sizes: "some 'messy' sizes",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('sizes'),
    equals('some sizes'),
  );

  expect(
    domNode2.getAttribute('sizes'),
    equals('some "messy" sizes'),
  );

  expect(
    domNode3.getAttribute('sizes'),
    equals("some 'messy' sizes"),
  );
}__Skip__);
