test('should set attribute "shape"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), shape: 'some-shape'),
        __WidgetClass__(key: Key('el-2'), shape: 'another-shape'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('shape'), equals('some-shape'));
    expect(domNode2.getAttribute('shape'), equals('another-shape'));
}__Skip__);

test('should update attribute "shape"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), shape: 'some-shape'),
        __WidgetClass__(key: Key('el-2'), shape: 'another-shape'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), shape: 'updated-shape'),
        __WidgetClass__(key: Key('el-2'), shape: 'another-shape'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('shape'), equals('updated-shape'));
    expect(domNode2.getAttribute('shape'), equals('another-shape'));
}__Skip__);

test('should clear attribute "shape"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), shape: 'another-shape'),
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

    expect(domNode1.getAttribute('shape'), equals(null));
    expect(domNode2.getAttribute('shape'), equals(null));
});

test('should clear attribute "shape" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), shape: 'some-shape'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), shape: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('shape'), equals(null));
});

test('should not set attribute "shape" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), shape: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('shape'), equals(null));
});

test('should set messy "shape"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        shape: 'some shape',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        shape: 'some "messy" shape',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        shape: "some 'messy' shape",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('shape'),
    equals('some shape'),
  );

  expect(
    domNode2.getAttribute('shape'),
    equals('some "messy" shape'),
  );

  expect(
    domNode3.getAttribute('shape'),
    equals("some 'messy' shape"),
  );
}__Skip__);
