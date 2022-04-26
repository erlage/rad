test('should set onClick', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        onClick: 'some onClick',
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        onClick: 'some "messy" onClick',
      ),
      __WidgetClass__(
        key: Key('widget-3'),
        onClick: "some 'messy' onClick",
      ),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
  var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
  var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

  expect(
    element1.getAttribute('onclick'),
    equals('some onClick'),
  );

  expect(
    element2.getAttribute('onclick'),
    equals('some "messy" onClick'),
  );

  expect(
    element3.getAttribute('onclick'),
    equals("some 'messy' onClick"),
  );
});