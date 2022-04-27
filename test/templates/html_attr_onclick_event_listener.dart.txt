test('should set onclick event listener', () {
  var testStack = RT_TestStack();

  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(
        key: GlobalKey('some-global-key'),
        onClickEventListener: (event) => testStack.push('clicked'),
      ),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;

  element1
    ..click()
    ..click();

  expect(testStack.popFromStart(), equals('clicked'));
  expect(testStack.popFromStart(), equals('clicked'));
  expect(testStack.canPop(), equals(false));
}__Skip__);