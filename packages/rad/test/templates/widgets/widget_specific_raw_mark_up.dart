test('RawMarkUp widget - widgetType override test', () {
  var widget = RawMarkUp('');

  expect(widget.widgetType,  equals('$RawMarkUp'));
});
