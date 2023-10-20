test('should set attribute "hreflang"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), hrefLang: 'some-hreflang'),
        __WidgetClass__(key: Key('el-2'), hrefLang: 'another-hreflang'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('hreflang'), equals('some-hreflang'));
    expect(domNode2.getAttribute('hreflang'), equals('another-hreflang'));
}__Skip__);

test('should update attribute "hreflang"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), hrefLang: 'some-hreflang'),
        __WidgetClass__(key: Key('el-2'), hrefLang: 'another-hreflang'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), hrefLang: 'updated-hreflang'),
        __WidgetClass__(key: Key('el-2'), hrefLang: 'another-hreflang'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('hreflang'), equals('updated-hreflang'));
    expect(domNode2.getAttribute('hreflang'), equals('another-hreflang'));
}__Skip__);

test('should clear attribute "hreflang"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), hrefLang: 'another-hreflang'),
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

    expect(domNode1.getAttribute('hreflang'), equals(null));
    expect(domNode2.getAttribute('hreflang'), equals(null));
});

test('should clear attribute "hreflang" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), hrefLang: 'some-hreflang'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), hrefLang: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('hreflang'), equals(null));
});

test('should not set attribute "hreflang" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), hrefLang: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('hreflang'), equals(null));
});

test('should set messy "hreflang"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        hrefLang: 'some hreflang',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        hrefLang: 'some "messy" hreflang',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        hrefLang: "some 'messy' hreflang",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('hreflang'),
    equals('some hreflang'),
  );

  expect(
    domNode2.getAttribute('hreflang'),
    equals('some "messy" hreflang'),
  );

  expect(
    domNode3.getAttribute('hreflang'),
    equals("some 'messy' hreflang"),
  );
}__Skip__);
