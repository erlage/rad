test('should set contentEditable', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        contentEditable: false,
      ),
      __WidgetClass__(
        key: Key('widget-2'),
        contentEditable: true,
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
  var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;

  expect(domNode1.getAttribute('contentEditable'), equals('false'));
  expect(domNode2.getAttribute('contentEditable'), equals('true'));
}__Skip__);