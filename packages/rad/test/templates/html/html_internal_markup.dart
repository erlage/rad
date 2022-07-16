test('should set correct types and markup', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('some-key-3')),
    ],
            parentRenderElement: RT_TestBed.rootRenderElement,

  );

  expect(
    RT_TestBed.rootDomNode.innerHtml,
    startsWith(
      //
      // some tags might don't have a closing tag
      //
      [
        'area',
        'img',
        'col',
        'br',
        'hr',
        'input',
        'wbr',
        'track',
        'embed',
      ].contains('__WidgetTag__')
            ? [
                'input',
              ].contains('__WidgetTag__')
                // becuase system set attributes for some tags 
                // e.g type="something" for input tag
                ? '<__WidgetTag__' 
                : '<__WidgetTag__>'
            : '<__WidgetTag__></__WidgetTag__>',
    ),
  );
}__Skip__);