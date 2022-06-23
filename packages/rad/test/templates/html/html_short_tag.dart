test('should have a short-tag alias', () async {
  var widget =  __WidgetClass__();
  var widgetShort =  __WidgetTag__();


  expect(
    widget.runtimeType,
    equals(widgetShort.runtimeType),
  );
}__Skip__);