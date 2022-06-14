test('should set style', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('widget-1'), style: 'some style'),
      __WidgetClass__(key: Key('widget-2'), style: 'some "messy" style'),
      __WidgetClass__(key: Key('widget-3'), style: "some 'messy' style"),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
  var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
  var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

  expect(domNode1.getAttribute('style'), equals('some style'));
  expect(domNode2.getAttribute('style'), equals('some "messy" style'));
  expect(domNode3.getAttribute('style'), equals("some 'messy' style"));
}__Skip__);
