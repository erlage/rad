test('should set draggable', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        draggable: false,
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        draggable: true,
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;

  expect(domNode1.getAttribute('draggable'), equals('false'));
  expect(domNode2.getAttribute('draggable'), equals('true'));
}__Skip__);