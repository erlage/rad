test('should set attribute "srcset"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), srcSet: 'some-srcset'),
        __WidgetClass__(key: Key('el-2'), srcSet: 'another-srcset'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('srcset'), equals('some-srcset'));
    expect(domNode2.getAttribute('srcset'), equals('another-srcset'));
}__Skip__);

test('should update attribute "srcset"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), srcSet: 'some-srcset'),
        __WidgetClass__(key: Key('el-2'), srcSet: 'another-srcset'),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1'), srcSet: 'updated-srcset'),
        __WidgetClass__(key: Key('el-2'), srcSet: 'another-srcset'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');

    expect(domNode1.getAttribute('srcset'), equals('updated-srcset'));
    expect(domNode2.getAttribute('srcset'), equals('another-srcset'));
}__Skip__);

test('should clear attribute "srcset"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: Key('el-1')),
        __WidgetClass__(key: Key('el-2'), srcSet: 'another-srcset'),
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

    expect(domNode1.getAttribute('srcset'), equals(null));
    expect(domNode2.getAttribute('srcset'), equals(null));
});

test('should clear attribute "srcset" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), srcSet: 'some-srcset'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), srcSet: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('srcset'), equals(null));
});

test('should not set attribute "srcset" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), srcSet: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');

    expect(domNode1.getAttribute('srcset'), equals(null));
});

test('should set messy "srcset"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        srcSet: 'some srcset',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        srcSet: 'some "messy" srcset',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        srcSet: "some 'messy' srcset",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('srcset'),
    equals('some srcset'),
  );

  expect(
    domNode2.getAttribute('srcset'),
    equals('some "messy" srcset'),
  );

  expect(
    domNode3.getAttribute('srcset'),
    equals("some 'messy' srcset"),
  );
}__Skip__);
