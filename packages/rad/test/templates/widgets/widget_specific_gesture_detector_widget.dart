test('GestureDetector widget - description test', () async {
  var pap = app!;

  await pap.buildChildren(
    widgets: [
      GestureDetector(
        key: Key('widget'),
        child: Text('hw')
      ),
    ],
    parentRenderElement: pap.appRenderElement,
  );

  var domNode = pap.domNodeByKeyValue('widget');

  expect(domNode.getComputedStyle().display, equals('contents'));
});

test('should return false from shouldUpdateWidgetChildren', () {
  var shouldUpdateWidgetChildren = false;
  
  var oldWidget = GestureDetector(child: Text('hw'));
  var newWidget = GestureDetector(child: Text('hw'));

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, false,);
  expect(shouldUpdateWidgetChildren,  equals(true));

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, true,);
  expect(shouldUpdateWidgetChildren,  equals(true));
});
