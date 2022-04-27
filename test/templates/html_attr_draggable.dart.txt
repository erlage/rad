test('should set draggable', () {
  app!.framework.buildChildren(
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
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
  var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

  expect(element1.getAttribute('draggable'), equals('false'));
  expect(element2.getAttribute('draggable'), equals('true'));
}__Skip__);