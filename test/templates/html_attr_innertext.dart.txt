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

  
  // we are using innerHtml as inner text is not accessible 
  // or returns empty string for some node(e.g progress)

  expect(element1.innerHtml, equals('hello world'));
}__Skip__);