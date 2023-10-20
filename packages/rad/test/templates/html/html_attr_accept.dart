test('should set attribute "accept"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), accept: 'some-accept'),
            __WidgetClass__(key: Key('el-2'), accept: 'another-accept'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('accept'), equals('some-accept'));
    expect(domNode2.getAttribute('accept'), equals('another-accept'));
}__Skip__);

test('should update attribute "accept"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), accept: 'some-accept'),
            __WidgetClass__(key: Key('el-2'), accept: 'another-accept'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), accept: 'updated-accept'),
            __WidgetClass__(key: Key('el-2'), accept: 'another-accept'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('accept'), equals('updated-accept'));
    expect(domNode2.getAttribute('accept'), equals('another-accept'));
}__Skip__);

test('should clear attribute "accept"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), accept: 'another-accept'),
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

    expect(domNode1.getAttribute('accept'), equals(null));
    expect(domNode2.getAttribute('accept'), equals(null));
}__Skip__);

test('should clear attribute "accept" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), accept: 'some-accept'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), accept: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('accept'), equals(null));
}__Skip__);

test('should not set attribute "accept" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), accept: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('accept'), equals(null));
}__Skip__);

test('should set messy "accept"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        accept: 'some accept',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        accept: 'some "messy" accept',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        accept: "some 'messy' accept",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('accept'),
    equals('some accept'),
  );

  expect(
    domNode2.getAttribute('accept'),
    equals('some "messy" accept'),
  );

  expect(
    domNode3.getAttribute('accept'),
    equals("some 'messy' accept"),
  );
}__Skip__);
