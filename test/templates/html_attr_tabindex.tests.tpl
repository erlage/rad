test('should set tab index', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        tabIndex: 1,
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        tabIndex: 2,
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        tabIndex: 3,
      ),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
  var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
  var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

  expect(element1.getAttribute('tabindex'), equals('1'));
  expect(element2.getAttribute('tabindex'), equals('2'));
  expect(element3.getAttribute('tabindex'), equals('3'));
});