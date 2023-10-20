test('should set children widgets', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__/**/(id: 'widget-1', [
        __WidgetClass__(
          id: 'widget-2',
        ),
        __WidgetClass__(
          id: 'widget-3',
        ),
      ],),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = domNode1.childNodes[0] as HtmlElement;
  var domNode3 = domNode1.childNodes[1] as HtmlElement;

  expect(domNode1.id, equals('widget-1'));
  expect(domNode2.id, equals('widget-2'));
  expect(domNode3.id, equals('widget-3'));
}__Skip__);