test('should set attribute "ping"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), ping: 'some-ping'),
        __WidgetClass__(key: Key('el-2'), ping: 'another-ping'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('ping'), equals('some-ping'));
    expect(domNode2.getAttribute('ping'), equals('another-ping'));
}__Skip__);

test('should update attribute "ping"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), ping: 'some-ping'),
        __WidgetClass__(key: Key('el-2'), ping: 'another-ping'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), ping: 'updated-ping'),
        __WidgetClass__(key: Key('el-2'), ping: 'another-ping'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('ping'), equals('updated-ping'));
    expect(domNode2.getAttribute('ping'), equals('another-ping'));
}__Skip__);

test('should clear attribute "ping"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), ping: 'another-ping'),
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

    expect(domNode1.getAttribute('ping'), equals(null));
    expect(domNode2.getAttribute('ping'), equals(null));
});

test('should clear attribute "ping" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), ping: 'some-ping'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), ping: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('ping'), equals(null));
});

test('should not set attribute "ping" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), ping: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('ping'), equals(null));
});

test('should set messy "ping"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        ping: 'some ping',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        ping: 'some "messy" ping',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        ping: "some 'messy' ping",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('ping'),
    equals('some ping'),
  );

  expect(
    domNode2.getAttribute('ping'),
    equals('some "messy" ping'),
  );

  expect(
    domNode3.getAttribute('ping'),
    equals("some 'messy' ping"),
  );
}__Skip__);
