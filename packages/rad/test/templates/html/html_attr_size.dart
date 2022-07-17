test('should set attribute "size"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), size: 'some-size'),
        __WidgetClass__(key: Key('el-2'), size: 'another-size'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('size'), equals('some-size'));
    expect(domNode2.getAttribute('size'), equals('another-size'));
}__Skip__);

test('should update attribute "size"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), size: 'some-size'),
        __WidgetClass__(key: Key('el-2'), size: 'another-size'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), size: 'updated-size'),
        __WidgetClass__(key: Key('el-2'), size: 'another-size'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('size'), equals('updated-size'));
    expect(domNode2.getAttribute('size'), equals('another-size'));
}__Skip__);

test('should clear attribute "size"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), size: 'another-size'),
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

    expect(domNode1.getAttribute('size'), equals(null));
    expect(domNode2.getAttribute('size'), equals(null));
});

test('should clear attribute "size" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), size: 'some-size'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), size: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('size'), equals(null));
});

test('should not set attribute "size" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), size: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('size'), equals(null));
});

test('should set messy "size"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        size: 'some size',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        size: 'some "messy" size',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        size: "some 'messy' size",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('size'),
    equals('some size'),
  );

  expect(
    domNode2.getAttribute('size'),
    equals('some "messy" size'),
  );

  expect(
    domNode3.getAttribute('size'),
    equals("some 'messy' size"),
  );
}__Skip__);
