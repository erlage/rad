test('Route widget - widgetType override test', () {
  var widget = Route(
    name: '',
    page: Text('hw'),
  );

  expect(widget.widgetType,  equals('$Route'));
});

test('Route widget - description test', () async {
  var pap = app!;

  await pap.buildChildren(
    widgets: [
      Route(
        key: GlobalKey('widget'),
        name: 'some-name',
        page: Text('hw'),
      ),
    ],
    parentRenderElement: pap.appRenderElement,
  );

  var domNode = pap.domNodeByGlobalKey('widget');

  expect(domNode.getComputedStyle().display, equals('contents'));
});
