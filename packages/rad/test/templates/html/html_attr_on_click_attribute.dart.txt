test('should set attribute "onClickAttribute"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
            __WidgetClass__(key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('onClick'), equals('some-on-click'));
    expect(domNode2.getAttribute('onClick'), equals('another-on-click'));
}__Skip__);

test('should update attribute "onClickAttribute"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
            __WidgetClass__(key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), onClickAttribute: 'updated-on-click'),
            __WidgetClass__(key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');
    var domNode2 = app!.domNodeByGlobalKey('el-2');

    expect(domNode1.getAttribute('onClick'), equals('updated-on-click'));
    expect(domNode2.getAttribute('onClick'), equals('another-on-click'));
}__Skip__);

test('should clear attribute "onClickAttribute"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1')),
            __WidgetClass__(key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
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

    expect(domNode1.getAttribute('onClick'), equals(null));
    expect(domNode2.getAttribute('onClick'), equals(null));
});

test('should clear attribute "onClickAttribute" if updated value is null', () async {
   await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), onClickAttribute: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('onClick'), equals(null));
});

test('should not set attribute "onClickAttribute" if provided value is null', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: GlobalKey('el-1'), onClickAttribute: null),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByGlobalKey('el-1');

    expect(domNode1.getAttribute('onClick'), equals(null));
});

test('should set messy "onClickAttribute"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        onClickAttribute: 'some onClick',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        onClickAttribute: 'some "messy" onClick',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        onClickAttribute: "some 'messy' onClick",
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('onclick'),
    equals('some onClick'),
  );

  expect(
    domNode2.getAttribute('onclick'),
    equals('some "messy" onClick'),
  );

  expect(
    domNode3.getAttribute('onclick'),
    equals("some 'messy' onClick"),
  );
}__Skip__);