test('should set attribute "srcdoc"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), srcDoc: 'some-srcdoc'),
        __WidgetClass__(key: Key('el-2'), srcDoc: 'another-srcdoc'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('srcdoc'), equals('some-srcdoc'));
    expect(domNode2.getAttribute('srcdoc'), equals('another-srcdoc'));
}__Skip__);

test('should update attribute "srcdoc"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), srcDoc: 'some-srcdoc'),
        __WidgetClass__(key: Key('el-2'), srcDoc: 'another-srcdoc'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), srcDoc: 'updated-srcdoc'),
        __WidgetClass__(key: Key('el-2'), srcDoc: 'another-srcdoc'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('srcdoc'), equals('updated-srcdoc'));
    expect(domNode2.getAttribute('srcdoc'), equals('another-srcdoc'));
}__Skip__);

test('should clear attribute "srcdoc"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), srcDoc: 'another-srcdoc'),
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

    expect(domNode1.getAttribute('srcdoc'), equals(null));
    expect(domNode2.getAttribute('srcdoc'), equals(null));
});

test('should clear attribute "srcdoc" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), srcDoc: 'some-srcdoc'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), srcDoc: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('srcdoc'), equals(null));
});

test('should not set attribute "srcdoc" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), srcDoc: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('srcdoc'), equals(null));
});

test('should set messy "srcdoc"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        srcDoc: 'some srcdoc',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        srcDoc: 'some "messy" srcdoc',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        srcDoc: "some 'messy' srcdoc",
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('srcdoc'),
    equals('some srcdoc'),
  );

  expect(
    domNode2.getAttribute('srcdoc'),
    equals('some "messy" srcdoc'),
  );

  expect(
    domNode3.getAttribute('srcdoc'),
    equals("some 'messy' srcdoc"),
  );
}__Skip__);
