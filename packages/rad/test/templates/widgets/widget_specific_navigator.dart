test('Navigator widget - widgetType override test', () {
  var widget = Navigator(routes: []);

  // for some reason, '$Navigator' returns Navigator0
  // if we dont add this line xD
  widget.runtimeType;

  expect(widget.widgetType, equals('$Navigator'));
});

test('Navigator widget - description test', () async {
  var pap = app!;

  await pap.buildChildren(
    widgets: [
      Navigator(
        key: GlobalKey('widget'),
        routes: [
          Route(name: 'name', page: Text('hw')),
        ],
      ),
    ],
    parentRenderElement: pap.appRenderElement,
  );

  var domNode = pap.domNodeByGlobalKey('widget');

  expect(domNode.getComputedStyle().display, equals('contents'));
});

test('should return true from shouldUpdateWidgetChildren', () {
  var shouldUpdateWidgetChildren = true;
  
  var oldWidget = Navigator(routes: []);
  var newWidget = Navigator(routes: []);

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, false,);
  expect(shouldUpdateWidgetChildren,  equals(false));

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, true,);
  expect(shouldUpdateWidgetChildren,  equals(false));
});

