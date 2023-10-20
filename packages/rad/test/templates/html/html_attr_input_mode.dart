test('should set attribute "inputmode"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), inputMode: 'some-inputmode'),
            __WidgetClass__(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('inputmode'), equals('some-inputmode'));
    expect(domNode2.getAttribute('inputmode'), equals('another-inputmode'));
}__Skip__);

test('should update attribute "inputmode"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), inputMode: 'some-inputmode'),
            __WidgetClass__(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), inputMode: 'updated-inputmode'),
            __WidgetClass__(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('inputmode'), equals('updated-inputmode'));
    expect(domNode2.getAttribute('inputmode'), equals('another-inputmode'));
}__Skip__);

test('should clear attribute "inputmode"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), inputMode: 'another-inputmode'),
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

    expect(domNode1.getAttribute('inputmode'), equals(null));
    expect(domNode2.getAttribute('inputmode'), equals(null));
});

test('should clear attribute "inputmode" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), inputMode: 'some-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), inputMode: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('inputmode'), equals(null));
});

test('should not set attribute "inputmode" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), inputMode: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('inputmode'), equals(null));
});

test('should set messy "inputmode"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        inputMode: 'some inputmode',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        inputMode: 'some "messy" inputmode',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        inputMode: "some 'messy' inputmode",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('inputmode'),
    equals('some inputmode'),
  );

  expect(
    domNode2.getAttribute('inputmode'),
    equals('some "messy" inputmode'),
  );

  expect(
    domNode3.getAttribute('inputmode'),
    equals("some 'messy' inputmode"),
  );
}__Skip__);
