test('should set title', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('widget-1'), title: 'some title'),
      __WidgetClass__(key: Key('widget-2'), title: 'some "messy" title'),
      __WidgetClass__(key: Key('widget-3'), title: "some 'messy' title"),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
  var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
  var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

  expect(element1.getAttribute('title'), equals('some title'));
  expect(element2.getAttribute('title'), equals('some "messy" title'));
  expect(element3.getAttribute('title'), equals("some 'messy' title"));
}__Skip__);