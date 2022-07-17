test('should set attribute "accept-charset"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), acceptCharset: 'some-accept-charset'),
            __WidgetClass__(key: Key('el-2'), acceptCharset: 'another-accept-charset'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('accept-charset'), equals('some-accept-charset'));
    expect(domNode2.getAttribute('accept-charset'), equals('another-accept-charset'));
}__Skip__);

test('should update attribute "accept-charset"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), acceptCharset: 'some-accept-charset'),
            __WidgetClass__(key: Key('el-2'), acceptCharset: 'another-accept-charset'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), acceptCharset: 'updated-accept-charset'),
            __WidgetClass__(key: Key('el-2'), acceptCharset: 'another-accept-charset'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('accept-charset'), equals('updated-accept-charset'));
    expect(domNode2.getAttribute('accept-charset'), equals('another-accept-charset'));
}__Skip__);

test('should clear attribute "accept-charset"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), acceptCharset: 'another-accept-charset'),
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

    expect(domNode1.getAttribute('accept-charset'), equals(null));
    expect(domNode2.getAttribute('accept-charset'), equals(null));
}__Skip__);

test('should clear attribute "accept-charset" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), acceptCharset: 'some-accept-charset'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), acceptCharset: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('accept-charset'), equals(null));
}__Skip__);

test('should not set attribute "accept-charset" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), acceptCharset: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('accept-charset'), equals(null));
}__Skip__);

test('should set messy "accept-charset"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        acceptCharset: 'some accept',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        acceptCharset: 'some "messy" accept',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        acceptCharset: "some 'messy' accept",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('accept-charset'),
    equals('some accept'),
  );

  expect(
    domNode2.getAttribute('accept-charset'),
    equals('some "messy" accept'),
  );

  expect(
    domNode3.getAttribute('accept-charset'),
    equals("some 'messy' accept"),
  );
}__Skip__);
