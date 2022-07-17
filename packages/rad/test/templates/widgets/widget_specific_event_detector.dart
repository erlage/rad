test('should return false from shouldUpdateWidgetChildren', () {
  var shouldUpdateWidgetChildren = false;
  
  var oldWidget = EventDetector(child: Text('hw'));
  var newWidget = EventDetector(child: Text('hw'));

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, false,);
  expect(shouldUpdateWidgetChildren,  equals(true));

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, true,);
  expect(shouldUpdateWidgetChildren,  equals(true));
});
