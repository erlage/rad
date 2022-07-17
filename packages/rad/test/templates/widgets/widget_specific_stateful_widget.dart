test('should return false from shouldUpdateWidgetChildren', () {
  var shouldUpdateWidgetChildren = true;
  
  var oldWidget = RT_StatefulTestWidget();
  var newWidget = RT_StatefulTestWidget();

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, false,);
  expect(shouldUpdateWidgetChildren,  equals(false));

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, true,);
  expect(shouldUpdateWidgetChildren,  equals(false));
}, skip: 'Core is now responsible for building/updating childs');
