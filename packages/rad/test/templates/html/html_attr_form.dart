test('should set attribute "form"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), form: 'some-form'),
        __WidgetClass__(key: Key('el-2'), form: 'another-form'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('form'), equals('some-form'));
    expect(domNode2.getAttribute('form'), equals('another-form'));
}__Skip__);

test('should update attribute "form"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), form: 'some-form'),
        __WidgetClass__(key: Key('el-2'), form: 'another-form'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), form: 'updated-form'),
        __WidgetClass__(key: Key('el-2'), form: 'another-form'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('form'), equals('updated-form'));
    expect(domNode2.getAttribute('form'), equals('another-form'));
}__Skip__);

test('should clear attribute "form"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), form: 'another-form'),
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

    expect(domNode1.getAttribute('form'), equals(null));
    expect(domNode2.getAttribute('form'), equals(null));
});

test('should clear attribute "form" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), form: 'some-form'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), form: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('form'), equals(null));
});

test('should not set attribute "form" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), form: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('form'), equals(null));
});

test('should set messy "form"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        form: 'some form',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        form: 'some "messy" form',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        form: "some 'messy' form",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('form'),
    equals('some form'),
  );

  expect(
    domNode2.getAttribute('form'),
    equals('some "messy" form'),
  );

  expect(
    domNode3.getAttribute('form'),
    equals("some 'messy' form"),
  );
}__Skip__);
