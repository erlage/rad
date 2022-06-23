test('should set child widget', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        id: 'widget-1',
        child: __WidgetClass__(
          id: 'widget-2',
        ),
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = domNode1.childNodes[0] as HtmlElement;

  expect(domNode1.id, equals('widget-1'));
  expect(domNode2.id, equals('widget-2'));
}__Skip__);