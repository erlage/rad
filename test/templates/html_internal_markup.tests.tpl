test('should set correct types and markup', () {
  app!.framework.buildChildren(
    widgets: [
      __WidgetClass__(key: GlobalKey('some-global-key')),
    ],
    parentContext: RT_TestBed.rootContext,
  );

  expect(
    RT_TestBed.rootElement.innerHtml,
    startsWith(
      '<__WidgetTag__ id="some-global-key" '
      'data-${Constants.attrWidgetType}="$__WidgetClass__" '
      'data-${Constants.attrRuntimeType}="$__WidgetClass__">',
      // Better to check leading part only(without closing tag)
      // Because some tags(e.g img) might don't have a closing tag
      // '</__WidgetTag__>',
    ),
  );
});