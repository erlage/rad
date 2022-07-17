test('should set attribute "formaction"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formAction: 'some-formaction'),
            __WidgetClass__(key: Key('el-2'), formAction: 'another-formaction'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('formaction'), equals('some-formaction'));
    expect(domNode2.getAttribute('formaction'), equals('another-formaction'));
}__Skip__);

test('should update attribute "formaction"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formAction: 'some-formaction'),
            __WidgetClass__(key: Key('el-2'), formAction: 'another-formaction'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formAction: 'updated-formaction'),
            __WidgetClass__(key: Key('el-2'), formAction: 'another-formaction'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('formaction'), equals('updated-formaction'));
    expect(domNode2.getAttribute('formaction'), equals('another-formaction'));
}__Skip__);

test('should clear attribute "formaction"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), formAction: 'another-formaction'),
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

    expect(domNode1.getAttribute('formaction'), equals(null));
    expect(domNode2.getAttribute('formaction'), equals(null));
});

test('should clear attribute "formaction" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formAction: 'some-formaction'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formAction: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('formaction'), equals(null));
});

test('should not set attribute "formaction" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), formAction: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('formaction'), equals(null));
});

test('should set messy "formaction"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        formAction: 'some formaction',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        formAction: 'some "messy" formaction',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        formAction: "some 'messy' formaction",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('formaction'),
    equals('some formaction'),
  );

  expect(
    domNode2.getAttribute('formaction'),
    equals('some "messy" formaction'),
  );

  expect(
    domNode3.getAttribute('formaction'),
    equals("some 'messy' formaction"),
  );
}__Skip__);
