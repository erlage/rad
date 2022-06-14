test('should set attribute "cite"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1'), cite: 'some-cite'),
        __WidgetClass__(key: GlobalKey('el-2'), cite: 'another-cite'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('cite'), equals('some-cite'));
    expect(domNode2.getAttribute('cite'), equals('another-cite'));
}__Skip__);

test('should update attribute "cite"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1'), cite: 'some-cite'),
        __WidgetClass__(key: GlobalKey('el-2'), cite: 'another-cite'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1'), cite: 'updated-cite'),
        __WidgetClass__(key: GlobalKey('el-2'), cite: 'another-cite'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('cite'), equals('updated-cite'));
    expect(domNode2.getAttribute('cite'), equals('another-cite'));
}__Skip__);

test('should clear attribute "cite"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1')),
        __WidgetClass__(key: GlobalKey('el-2'), cite: 'another-cite'),
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

    expect(domNode1.getAttribute('cite'), equals(null));
    expect(domNode2.getAttribute('cite'), equals(null));
});

test('should clear attribute "cite" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), cite: 'some-cite'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), cite: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('cite'), equals(null));
});

test('should not set attribute "cite" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), cite: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('cite'), equals(null));
});

test('should set messy "cite"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        cite: 'some cite',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        cite: 'some "messy" cite',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        cite: "some 'messy' cite",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('cite'),
    equals('some cite'),
  );

  expect(
    domNode2.getAttribute('cite'),
    equals('some "messy" cite'),
  );

  expect(
    domNode3.getAttribute('cite'),
    equals("some 'messy' cite"),
  );
}__Skip__);
