test('should set contenteditable', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        contenteditable: false,
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        contenteditable: true,
      ),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
  var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

  expect(element1.getAttribute('contenteditable'), equals('false'));
  expect(element2.getAttribute('contenteditable'), equals('true'));
});