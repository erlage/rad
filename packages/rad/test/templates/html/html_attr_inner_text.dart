test('should set inner text', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(
        key: Key('widget-1'),
        innerText: 'hello world',
      ),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;

  
  // we are using innerHtml as inner text is not accessible 
  // or returns empty string for some node(e.g progress)

  expect(domNode1.innerHtml, equals('hello world'));
}__Skip__);