test('should set key', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('some-key')),
      __WidgetClass__(key: LocalKey('some-local-key')),
      __WidgetClass__(key: GlobalKey('some-global-key')),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
  var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
  var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

  expect(element1.id, endsWith('some-key'));
  expect(element2.id, endsWith('some-local-key'));
  expect(element3.id, equals('some-global-key'));
});