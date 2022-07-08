test('should set attribute "href"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), href: 'some-href'),
        __WidgetClass__(key: Key('el-2'), href: 'another-href'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('href'), equals('some-href'));
    expect(domNode2.getAttribute('href'), equals('another-href'));
}__Skip__);

test('should update attribute "href"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), href: 'some-href'),
        __WidgetClass__(key: Key('el-2'), href: 'another-href'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), href: 'updated-href'),
        __WidgetClass__(key: Key('el-2'), href: 'another-href'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('href'), equals('updated-href'));
    expect(domNode2.getAttribute('href'), equals('another-href'));
}__Skip__);

test('should clear attribute "href"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), href: 'another-href'),
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

    expect(domNode1.getAttribute('href'), equals(null));
    expect(domNode2.getAttribute('href'), equals(null));
});

test('should clear attribute "href" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), href: 'some-href'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), href: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('href'), equals(null));
});

test('should not set attribute "href" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), href: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('href'), equals(null));
});

test('should set messy "href"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        href: 'some href',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        href: 'some "messy" href',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        href: "some 'messy' href",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('href'),
    equals('some href'),
  );

  expect(
    domNode2.getAttribute('href'),
    equals('some "messy" href'),
  );

  expect(
    domNode3.getAttribute('href'),
    equals("some 'messy' href"),
  );
}__Skip__);
