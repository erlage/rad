test('should set inner text', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(
        key: GlobalKey('widget-1'),
        innerText: 'hello world',
      ),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;

  expect(element1.innerText, equals('hello world'));
});