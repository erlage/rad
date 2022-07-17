test('Navigator widget - description test', () async {
  var pap = app!;

  await pap.buildChildren(
    widgets: [
      Navigator(
        key: Key('widget'),
        routes: [
          Route(name: 'name', page: Text('hw')),
        ],
      ),
    ],
    parentRenderElement: pap.appRenderElement,
  );

  var domNode = pap.domNodeByKeyValue('widget');

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

