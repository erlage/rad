test('should set attribute "classes"', () async {
    await app!.buildChildren(
    widgets: [
        __WidgetClass__(key: GlobalKey('el-1'), classAttribute: 'some-classes',),
        __WidgetClass__(key: GlobalKey('el-2'), classAttribute: 'another-classes',),
    ],
    parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('class'), equals('some-classes'));
    expect(domNode2.getAttribute('class'), equals('another-classes'));
}__Skip__);

test('should update attribute "classes"', () async {
    await app!.buildChildren(
      widgets: [
          __WidgetClass__(key: GlobalKey('el-1'), classAttribute: 'some-classes',),
          __WidgetClass__(key: GlobalKey('el-2'), classAttribute: 'another-classes',),
      ],
      parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
      widgets: [
          __WidgetClass__(key: GlobalKey('el-1'), classAttribute: 'updated-classes',),
          __WidgetClass__(key: GlobalKey('el-2'), classAttribute: 'another-classes',),
      ],
      updateType: UpdateType.setState,
      parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('class'), equals('updated-classes'));
    expect(domNode2.getAttribute('class'), equals('another-classes'));
}__Skip__);

test('should clear attribute "classes"', () async {
    await app!.buildChildren(
      widgets: [
          __WidgetClass__(key: GlobalKey('el-1')),
          __WidgetClass__(key: GlobalKey('el-2'), classAttribute: 'another-classes',),
      ],
      parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
      widgets: [
          __WidgetClass__(key: GlobalKey('el-1')),
          __WidgetClass__(key: GlobalKey('el-2')),
      ],
      updateType: UpdateType.setState,
      parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('class'), equals(null));
    expect(domNode2.getAttribute('class'), equals(null));
});

test('should clear attribute "classes" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), classAttribute: 'some-classes',),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), classAttribute: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('class'), equals(null));
});

test('should not set attribute "classes" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), classAttribute: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('class'), equals(null));
});

test('should set messy "classes"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        classAttribute: 'some classes',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        classAttribute: 'some "messy" classes',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        classAttribute: "some 'messy' classes",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('class'),
    equals('some classes'),
  );

  expect(
    domNode2.getAttribute('class'),
    equals('some "messy" classes'),
  );

  expect(
    domNode3.getAttribute('class'),
    equals("some 'messy' classes"),
  );
}__Skip__);
