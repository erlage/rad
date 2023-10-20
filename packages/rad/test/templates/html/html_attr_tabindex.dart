test('should set tab index', () async {
  await app!.buildChildren(
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
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
  var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

  expect(domNode1.getAttribute('tabindex'), equals('1'));
  expect(domNode2.getAttribute('tabindex'), equals('2'));
  expect(domNode3.getAttribute('tabindex'), equals('3'));
}__Skip__);