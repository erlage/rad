test('should set attribute "for"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), forAttribute: 'some-for'),
        __WidgetClass__(key: Key('el-2'), forAttribute: 'another-for'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('for'), equals('some-for'));
    expect(domNode2.getAttribute('for'), equals('another-for'));
}__Skip__);

test('should update attribute "for"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), forAttribute: 'some-for'),
        __WidgetClass__(key: Key('el-2'), forAttribute: 'another-for'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), forAttribute: 'updated-for'),
        __WidgetClass__(key: Key('el-2'), forAttribute: 'another-for'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('for'), equals('updated-for'));
    expect(domNode2.getAttribute('for'), equals('another-for'));
}__Skip__);

test('should clear attribute "for"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), forAttribute: 'another-for'),
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

    expect(domNode1.getAttribute('for'), equals(null));
    expect(domNode2.getAttribute('for'), equals(null));
});

test('should clear attribute "for" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), forAttribute: 'some-for'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), forAttribute: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('for'), equals(null));
});

test('should not set attribute "for" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), forAttribute: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('for'), equals(null));
});

test('should set messy "for"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        forAttribute: 'some for',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        forAttribute: 'some "messy" for',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        forAttribute: "some 'messy' for",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('for'),
    equals('some for'),
  );

  expect(
    domNode2.getAttribute('for'),
    equals('some "messy" for'),
  );

  expect(
    domNode3.getAttribute('for'),
    equals("some 'messy' for"),
  );
}__Skip__);
