test('should set style', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('widget-1'), style: 'some style'),
      __WidgetClass__(key: Key('widget-2'), style: 'some "messy" style'),
      __WidgetClass__(key: Key('widget-3'), style: "some 'messy' style"),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
  var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
  var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

  expect(element1.getAttribute('style'), equals('some style'));
  expect(element2.getAttribute('style'), equals('some "messy" style'));
  expect(element3.getAttribute('style'), equals("some 'messy' style"));
});
