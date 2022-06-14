test('should set attribute "label"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1'), label: 'some-label'),
        __WidgetClass__(key: GlobalKey('el-2'), label: 'another-label'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('label'), equals('some-label'));
    expect(domNode2.getAttribute('label'), equals('another-label'));
}__Skip__);

test('should update attribute "label"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1'), label: 'some-label'),
        __WidgetClass__(key: GlobalKey('el-2'), label: 'another-label'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1'), label: 'updated-label'),
        __WidgetClass__(key: GlobalKey('el-2'), label: 'another-label'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('label'), equals('updated-label'));
    expect(domNode2.getAttribute('label'), equals('another-label'));
}__Skip__);

test('should clear attribute "label"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1')),
        __WidgetClass__(key: GlobalKey('el-2'), label: 'another-label'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1')),
        __WidgetClass__(key: GlobalKey('el-2')),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('label'), equals(null));
    expect(domNode2.getAttribute('label'), equals(null));
});

test('should clear attribute "label" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), label: 'some-label'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), label: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('label'), equals(null));
});

test('should not set attribute "label" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), label: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('label'), equals(null));
});

test('should set messy "label"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        label: 'some label',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        label: 'some "messy" label',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        label: "some 'messy' label",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('label'),
    equals('some label'),
  );

  expect(
    domNode2.getAttribute('label'),
    equals('some "messy" label'),
  );

  expect(
    domNode3.getAttribute('label'),
    equals("some 'messy' label"),
  );
}__Skip__);
