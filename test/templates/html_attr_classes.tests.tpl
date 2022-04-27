test('should set classes', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        classAttribute: 'some class',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        classAttribute: 'some "messy" class',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        classAttribute: "some 'messy' class",
      ),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
  var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
  var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

  expect(element1.getAttribute('class'), equals('some class'));
  expect(element2.getAttribute('class'), equals('some "messy" class'));
  expect(element3.getAttribute('class'), equals("some 'messy' class"));
}__Skip__);