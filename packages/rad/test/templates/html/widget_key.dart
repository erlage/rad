test('should set key', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('some-key-1')),
      __WidgetClass__(key: Key('some-key-2')),
      __WidgetClass__(key: Key('some-key-3')),
    ],
    parentRenderElement: app!.appRenderElement,
  );
  
  var wO1 = app!.renderElementByKeyValue('some-key-1')!;
  var wO2 = app!.renderElementByKeyValue('some-key-2')!;
  var wO3 = app!.renderElementByKeyValue('some-key-3')!;

  expect(wO1.key?.frameworkValue, endsWith('some-key-1'));
  expect(wO2.key?.frameworkValue, endsWith('some-key-2'));
  expect(wO3.key?.frameworkValue, equals('some-key-3'));
}__Skip__);