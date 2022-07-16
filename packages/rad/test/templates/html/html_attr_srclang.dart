test('should set attribute "srclang"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), srcLang: 'some-srclang'),
        __WidgetClass__(key: Key('el-2'), srcLang: 'another-srclang'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('srclang'), equals('some-srclang'));
    expect(domNode2.getAttribute('srclang'), equals('another-srclang'));
}__Skip__);

test('should update attribute "srclang"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), srcLang: 'some-srclang'),
        __WidgetClass__(key: Key('el-2'), srcLang: 'another-srclang'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), srcLang: 'updated-srclang'),
        __WidgetClass__(key: Key('el-2'), srcLang: 'another-srclang'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('srclang'), equals('updated-srclang'));
    expect(domNode2.getAttribute('srclang'), equals('another-srclang'));
}__Skip__);

test('should clear attribute "srclang"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), srcLang: 'another-srclang'),
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

    expect(domNode1.getAttribute('srclang'), equals(null));
    expect(domNode2.getAttribute('srclang'), equals(null));
});

test('should clear attribute "srclang" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), srcLang: 'some-srclang'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), srcLang: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('srclang'), equals(null));
});

test('should not set attribute "srclang" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), srcLang: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('srclang'), equals(null));
});

test('should set messy "srclang"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        srcLang: 'some srclang',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        srcLang: 'some "messy" srclang',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        srcLang: "some 'messy' srclang",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('srclang'),
    equals('some srclang'),
  );

  expect(
    domNode2.getAttribute('srclang'),
    equals('some "messy" srclang'),
  );

  expect(
    domNode3.getAttribute('srclang'),
    equals("some 'messy' srclang"),
  );
}__Skip__);
