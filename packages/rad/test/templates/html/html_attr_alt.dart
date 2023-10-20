test('should set attribute "alt"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), alt: 'some-alt'),
            __WidgetClass__(key: Key('el-2'), alt: 'another-alt'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('alt'), equals('some-alt'));
    expect(domNode2.getAttribute('alt'), equals('another-alt'));
}__Skip__);

test('should update attribute "alt"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), alt: 'some-alt'),
            __WidgetClass__(key: Key('el-2'), alt: 'another-alt'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), alt: 'updated-alt'),
            __WidgetClass__(key: Key('el-2'), alt: 'another-alt'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('alt'), equals('updated-alt'));
    expect(domNode2.getAttribute('alt'), equals('another-alt'));
}__Skip__);

test('should clear attribute "alt"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), alt: 'another-alt'),
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

    expect(domNode1.getAttribute('alt'), equals(null));
    expect(domNode2.getAttribute('alt'), equals(null));
});

test('should clear attribute "alt" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), alt: 'some-alt'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), alt: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('alt'), equals(null));
});

test('should not set attribute "alt" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), alt: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('alt'), equals(null));
});

test('should set messy "alt"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        alt: 'some alt',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        alt: 'some "messy" alt',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        alt: "some 'messy' alt",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('alt'),
    equals('some alt'),
  );

  expect(
    domNode2.getAttribute('alt'),
    equals('some "messy" alt'),
  );

  expect(
    domNode3.getAttribute('alt'),
    equals("some 'messy' alt"),
  );
}__Skip__);
