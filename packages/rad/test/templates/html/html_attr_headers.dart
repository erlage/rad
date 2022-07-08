test('should set attribute "headers"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), headers: 'some-headers'),
        __WidgetClass__(key: Key('el-2'), headers: 'another-headers'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('headers'), equals('some-headers'));
    expect(domNode2.getAttribute('headers'), equals('another-headers'));
}__Skip__);

test('should update attribute "headers"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), headers: 'some-headers'),
        __WidgetClass__(key: Key('el-2'), headers: 'another-headers'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), headers: 'updated-headers'),
        __WidgetClass__(key: Key('el-2'), headers: 'another-headers'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('headers'), equals('updated-headers'));
    expect(domNode2.getAttribute('headers'), equals('another-headers'));
}__Skip__);

test('should clear attribute "headers"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), headers: 'another-headers'),
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

    expect(domNode1.getAttribute('headers'), equals(null));
    expect(domNode2.getAttribute('headers'), equals(null));
});

test('should clear attribute "headers" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), headers: 'some-headers'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), headers: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('headers'), equals(null));
});

test('should not set attribute "headers" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), headers: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('headers'), equals(null));
});

test('should set messy "headers"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        headers: 'some headers',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        headers: 'some "messy" headers',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        headers: "some 'messy' headers",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('headers'),
    equals('some headers'),
  );

  expect(
    domNode2.getAttribute('headers'),
    equals('some "messy" headers'),
  );

  expect(
    domNode3.getAttribute('headers'),
    equals("some 'messy' headers"),
  );
}__Skip__);
