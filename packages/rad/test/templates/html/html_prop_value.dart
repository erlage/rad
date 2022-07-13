test('should set property "value"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: 'some-value'),
      __WidgetClass__(key: Key('el-2'), value: 'another-value'),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.domNodeByKeyValue('el-1');
  var domNode2 = app!.domNodeByKeyValue('el-2');

  expect((domNode1 as __WidgetClass__Element).value, equals('some-value'));
  expect((domNode2 as __WidgetClass__Element).value, equals('another-value'));
});

test('should update property "value"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: 'some-value'),
      __WidgetClass__(key: Key('el-2'), value: 'another-value'),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  await app!.updateChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: 'updated-value'),
      __WidgetClass__(key: Key('el-2'), value: 'another-value'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.domNodeByKeyValue('el-1');
  var domNode2 = app!.domNodeByKeyValue('el-2');

  expect((domNode1 as __WidgetClass__Element).value, equals('updated-value'));
  expect((domNode2 as __WidgetClass__Element).value, equals('another-value'));
});

test('should clear property "value"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1')),
      __WidgetClass__(key: Key('el-2'), value: 'another-value'),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  await app!.updateChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1')),
      __WidgetClass__(key: Key('el-2')),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.domNodeByKeyValue('el-1');
  var domNode2 = app!.domNodeByKeyValue('el-2');

  expect((domNode1 as __WidgetClass__Element).value, equals(''));
  expect((domNode2 as __WidgetClass__Element).value, equals(''));
});

test('should clear property "value" if updated value is null', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: 'some-value'),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  await app!.updateChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: null),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.domNodeByKeyValue('el-1');

  expect((domNode1 as __WidgetClass__Element).value, equals(''));
});

test('should not set property "value" if provided value is null', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: null),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.domNodeByKeyValue('el-1');

  expect((domNode1 as __WidgetClass__Element).value, equals(''));
});