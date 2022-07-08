test('should set id', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('some-key-1'), id: 'some-id-1'),
      __WidgetClass__(key: Key('some-key-2'), id: 'some-id-2'),
      __WidgetClass__(key: Key('some-key-3'), id: 'some-id-3'),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.domNodeByKeyValue('some-key-1');
  var domNode2 = app!.domNodeByKeyValue('some-key-2');
  var domNode3 = app!.domNodeByKeyValue('some-key-3');

  expect(domNode1.id, equals('some-id-1'));
  expect(domNode2.id, equals('some-id-2'));
  expect(domNode3.id, equals('some-id-3'));
}__Skip__);

test('should reset and update id', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('some-key-1'), id: 'some-id-1'),
      __WidgetClass__(key: Key('some-key-2'), id: 'some-id-2'),
      __WidgetClass__(key: Key('some-key-3'), id: 'some-id-3'),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.domNodeByKeyValue('some-key-1');
  var domNode2 = app!.domNodeByKeyValue('some-key-2');
  var domNode3 = app!.domNodeByKeyValue('some-key-3');

  expect(domNode1.id, equals('some-id-1'));
  expect(domNode2.id, equals('some-id-2'));
  expect(domNode3.id, equals('some-id-3'));

  await app!.updateChildren(
    widgets: [
      __WidgetClass__(
        key: Key('some-key-1'),
        id: 'some-updated-id',
      ),
      __WidgetClass__(
        key: Key('some-key-2'),
        id: 'some-local-updated-id',
      ),
      __WidgetClass__(
        key: Key('some-key-3'),
        id: 'some-global-updated-id',
      ),
    ],
    updateType: UpdateType.undefined,
    parentRenderElement: app!.appRenderElement,
  );

  expect(domNode1.id, equals('some-updated-id'));
  expect(domNode2.id, equals('some-local-updated-id'));
  expect(domNode3.id, equals('some-global-updated-id'));
}__Skip__);

test('should set messy "id"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        id: 'some id',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        id: 'some "messy" id',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        id: "some 'messy' id",
      ),
    ],
    parentRenderElement: RT_TestBed.rootRenderElement,
  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(
    domNode1.getAttribute('id'),
    equals('some id'),
  );

  expect(
    domNode2.getAttribute('id'),
    equals('some "messy" id'),
  );

  expect(
    domNode3.getAttribute('id'),
    equals("some 'messy' id"),
  );
}__Skip__);
