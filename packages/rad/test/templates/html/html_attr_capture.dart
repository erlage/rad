test('should set attribute "capture"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), capture: 'some-capture'),
            __WidgetClass__(key: Key('el-2'), capture: 'another-capture'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('capture'), equals('some-capture'));
    expect(domNode2.getAttribute('capture'), equals('another-capture'));
}__Skip__);

test('should update attribute "capture"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), capture: 'some-capture'),
            __WidgetClass__(key: Key('el-2'), capture: 'another-capture'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), capture: 'updated-capture'),
            __WidgetClass__(key: Key('el-2'), capture: 'another-capture'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('capture'), equals('updated-capture'));
    expect(domNode2.getAttribute('capture'), equals('another-capture'));
}__Skip__);

test('should clear attribute "capture"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), capture: 'another-capture'),
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

    expect(domNode1.getAttribute('capture'), equals(null));
    expect(domNode2.getAttribute('capture'), equals(null));
});

test('should clear attribute "capture" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), capture: 'some-capture'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), capture: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('capture'), equals(null));
});

test('should not set attribute "capture" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), capture: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('capture'), equals(null));
});

test('should set messy "capture"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        capture: 'some capture',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        capture: 'some "messy" capture',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        capture: "some 'messy' capture",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('capture'),
    equals('some capture'),
  );

  expect(
    domNode2.getAttribute('capture'),
    equals('some "messy" capture'),
  );

  expect(
    domNode3.getAttribute('capture'),
    equals("some 'messy' capture"),
  );
}__Skip__);
