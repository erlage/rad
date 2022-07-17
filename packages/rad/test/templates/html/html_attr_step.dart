test('should set attribute "step"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), step: 'some-step'),
        __WidgetClass__(key: Key('el-2'), step: 'another-step'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('step'), equals('some-step'));
    expect(domNode2.getAttribute('step'), equals('another-step'));
}__Skip__);

test('should update attribute "step"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), step: 'some-step'),
        __WidgetClass__(key: Key('el-2'), step: 'another-step'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), step: 'updated-step'),
        __WidgetClass__(key: Key('el-2'), step: 'another-step'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('step'), equals('updated-step'));
    expect(domNode2.getAttribute('step'), equals('another-step'));
}__Skip__);

test('should clear attribute "step"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), step: 'another-step'),
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

    expect(domNode1.getAttribute('step'), equals(null));
    expect(domNode2.getAttribute('step'), equals(null));
});

test('should clear attribute "step" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), step: 'some-step'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), step: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('step'), equals(null));
});

test('should not set attribute "step" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), step: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('step'), equals(null));
});

test('should set messy "step"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        step: 'some step',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        step: 'some "messy" step',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        step: "some 'messy' step",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('step'),
    equals('some step'),
  );

  expect(
    domNode2.getAttribute('step'),
    equals('some "messy" step'),
  );

  expect(
    domNode3.getAttribute('step'),
    equals("some 'messy' step"),
  );
}__Skip__);
