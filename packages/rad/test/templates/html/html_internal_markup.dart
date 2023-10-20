test('should set correct types and markup', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('some-key-3')),
    ],
            parentRenderElement: app!.appRenderElement,

  );

  expect(
    app!.appDomNode.innerHtml,
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
        'source',
      ].contains('__WidgetTag__')
            ? [
                'input',
              ].contains('__WidgetTag__')
                // because system set attributes for some tags 
                // e.g type="something" for input tag
                ? '<__WidgetTag__' 
                : '<__WidgetTag__>'
            : '<__WidgetTag__></__WidgetTag__>',
    ),
  );
}__Skip__);