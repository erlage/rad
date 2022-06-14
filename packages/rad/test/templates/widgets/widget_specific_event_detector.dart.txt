test('EventDetector widget - widgetType override test', () {
  var widget = EventDetector(child: Text('hw'));

  expect(widget.widgetType,  equals('$EventDetector'));
});

test('should return false from shouldUpdateWidgetChildren', () {
  var shouldUpdateWidgetChildren = false;
  
  var oldWidget = EventDetector(child: Text('hw'));
  var newWidget = EventDetector(child: Text('hw'));

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, false,);
  expect(shouldUpdateWidgetChildren,  equals(true));

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, true,);
  expect(shouldUpdateWidgetChildren,  equals(true));
});
