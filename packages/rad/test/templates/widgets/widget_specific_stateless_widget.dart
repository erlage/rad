test('Stateless widget - widgetType override test', () {
  var widget = RT_StatelessWidget();

  expect(widget.widgetType,  equals('$StatelessWidget'));
});

test('should return false from shouldUpdateWidgetChildren', () {
  var shouldUpdateWidgetChildren = true;
  
  var oldWidget = RT_StatelessWidget();
  var newWidget = RT_StatelessWidget();

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, false,);
  expect(shouldUpdateWidgetChildren,  equals(false));

  shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(oldWidget, true,);
  expect(shouldUpdateWidgetChildren,  equals(false));
}, skip: 'Core is now responsible for building/updating childs');
