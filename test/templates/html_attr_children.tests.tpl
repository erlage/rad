test('should set children widgets', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(key: GlobalKey('widget-1'), children: [
        __WidgetClass__(
          key: GlobalKey('widget-2'),
        ),
        __WidgetClass__(
          key: GlobalKey('widget-3'),
        ),
      ]),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
  var element2 = element1.childNodes[0] as HtmlElement;
  var element3 = element1.childNodes[1] as HtmlElement;

  expect(element1.id, equals('widget-1'));
  expect(element2.id, equals('widget-2'));
  expect(element3.id, equals('widget-3'));
});