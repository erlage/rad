test('should set hidden', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        hidden: false,
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        hidden: true,
      ),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
  var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

  expect(element1.hidden, equals(false));
  expect(element2.hidden, equals(true));
}__Skip__);