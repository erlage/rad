test('should set attribute "referrerpolicy"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), referrerPolicy: 'some-referrerpolicy'),
        __WidgetClass__(key: Key('el-2'), referrerPolicy: 'another-referrerpolicy'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('referrerpolicy'), equals('some-referrerpolicy'));
    expect(domNode2.getAttribute('referrerpolicy'), equals('another-referrerpolicy'));
}__Skip__);

test('should update attribute "referrerpolicy"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), referrerPolicy: 'some-referrerpolicy'),
        __WidgetClass__(key: Key('el-2'), referrerPolicy: 'another-referrerpolicy'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), referrerPolicy: 'updated-referrerpolicy'),
        __WidgetClass__(key: Key('el-2'), referrerPolicy: 'another-referrerpolicy'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('referrerpolicy'), equals('updated-referrerpolicy'));
    expect(domNode2.getAttribute('referrerpolicy'), equals('another-referrerpolicy'));
}__Skip__);

test('should clear attribute "referrerpolicy"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), referrerPolicy: 'another-referrerpolicy'),
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

    expect(domNode1.getAttribute('referrerpolicy'), equals(null));
    expect(domNode2.getAttribute('referrerpolicy'), equals(null));
});

test('should clear attribute "referrerpolicy" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), referrerPolicy: 'some-referrerpolicy'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), referrerPolicy: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('referrerpolicy'), equals(null));
});

test('should not set attribute "referrerpolicy" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), referrerPolicy: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('referrerpolicy'), equals(null));
});

test('should set messy "referrerpolicy"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        referrerPolicy: 'some referrerpolicy',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        referrerPolicy: 'some "messy" referrerpolicy',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        referrerPolicy: "some 'messy' referrerpolicy",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('referrerpolicy'),
    equals('some referrerpolicy'),
  );

  expect(
    domNode2.getAttribute('referrerpolicy'),
    equals('some "messy" referrerpolicy'),
  );

  expect(
    domNode3.getAttribute('referrerpolicy'),
    equals("some 'messy' referrerpolicy"),
  );
}__Skip__);
