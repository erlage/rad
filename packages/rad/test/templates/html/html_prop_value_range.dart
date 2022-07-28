test('should set property "value"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: '12'),
      __WidgetClass__(key: Key('el-2'), value: '10'),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.domNodeByKeyValue('el-1');
  var domNode2 = app!.domNodeByKeyValue('el-2');

  expect((domNode1 as InputElement).value, equals('12'));
  expect((domNode2 as InputElement).value, equals('10'));
});

test('should update property "value"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: '12'),
      __WidgetClass__(key: Key('el-2'), value: '10'),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  await app!.updateChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: '8'),
      __WidgetClass__(key: Key('el-2'), value: '10'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.domNodeByKeyValue('el-1');
  var domNode2 = app!.domNodeByKeyValue('el-2');

  expect((domNode1 as InputElement).value, equals('8'));
  expect((domNode2 as InputElement).value, equals('10'));
});

test('should clear property "value"', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1')),
      __WidgetClass__(key: Key('el-2'), value: '10'),
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

  // 50 is default

  expect((domNode1 as InputElement).value, equals('50'));
  expect((domNode2 as InputElement).value, equals('50'));
});

test('should clear property "value" if updated value is null', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: '12'),
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

  expect((domNode1 as InputElement).value, equals('50'));
});

test('should not set property "value" if provided value is null', () async {
  await app!.buildChildren(
    widgets: [
      __WidgetClass__(key: Key('el-1'), value: null),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  var domNode1 = app!.domNodeByKeyValue('el-1');

  expect((domNode1 as InputElement).value, equals('50'));
});