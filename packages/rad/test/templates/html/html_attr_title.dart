test('should set title', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('widget-1'), title: 'some title'),
      __WidgetClass__(key: Key('widget-2'), title: 'some "messy" title'),
      __WidgetClass__(key: Key('widget-3'), title: "some 'messy' title"),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(domNode1.getAttribute('title'), equals('some title'));
  expect(domNode2.getAttribute('title'), equals('some "messy" title'));
  expect(domNode3.getAttribute('title'), equals("some 'messy' title"));
}__Skip__);