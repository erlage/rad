test('should set inner text', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        innerText: 'hello world',
      ),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;

  
  // we are using innerHtml as inner text is not accessible 
  // or returns empty string for some node(e.g progress)

  expect(domNode1.innerHtml, equals('hello world'));
}__Skip__);