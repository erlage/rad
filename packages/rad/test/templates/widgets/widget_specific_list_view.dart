test('ListView widget - widgetType override test', () {
  var widget = ListView(children: []);

  expect(widget.widgetType,  equals('$ListView'));
});