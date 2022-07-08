test('should set attribute "action"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), action: 'some-action'),
            __WidgetClass__(key: Key('el-2'), action: 'another-action'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('action'), equals('some-action'));
    expect(domNode2.getAttribute('action'), equals('another-action'));
}__Skip__);

test('should update attribute "action"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), action: 'some-action'),
            __WidgetClass__(key: Key('el-2'), action: 'another-action'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), action: 'updated-action'),
            __WidgetClass__(key: Key('el-2'), action: 'another-action'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('action'), equals('updated-action'));
    expect(domNode2.getAttribute('action'), equals('another-action'));
}__Skip__);

test('should clear attribute "action"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), action: 'another-action'),
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

    expect(domNode1.getAttribute('action'), equals(null));
    expect(domNode2.getAttribute('action'), equals(null));
});

test('should clear attribute "action" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), action: 'some-action'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), action: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('action'), equals(null));
});

test('should not set attribute "action" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), action: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('action'), equals(null));
});

test('should set messy "action"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        action: 'some action',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        action: 'some "messy" action',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        action: "some 'messy' action",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('action'),
    equals('some action'),
  );

  expect(
    domNode2.getAttribute('action'),
    equals('some "messy" action'),
  );

  expect(
    domNode3.getAttribute('action'),
    equals("some 'messy' action"),
  );
}__Skip__);
