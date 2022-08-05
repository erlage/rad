test('should call ref with correct element', () async {
  Element? el1;
  Element? el2;
  Element? el3;

  await app!.buildChildren(
    widgets: [
      __WidgetClass__(id: 'some-id-1', ref: (el) => el1 = el),
      __WidgetClass__(id: 'some-id-2', ref: (el) => el2 = el),
      __WidgetClass__(id: 'some-id-3', ref: (el) => el3 = el),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  expect(el1, equals(document.getElementById('some-id-1')));
  expect(el2, equals(document.getElementById('some-id-2')));
  expect(el3, equals(document.getElementById('some-id-3')));
}__Skip__);

test('should call ref-callback before afterMounts', () async {
  Element? el1;
  var stack = RT_TestStack();

  await app!.buildChildren(
    widgets: [
      RT_TestWidget(roEventAfterMount: () {
        stack.push('after mount');
        expect(el1, equals(document.getElementById('some-id-1')));
      }),
      __WidgetClass__(id: 'some-id-1', ref: (el) => el1 = el),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  expect(stack.popFromStart(), equals('after mount'));
  expect(stack.canPop(), equals(false));
}__Skip__);

test('should call ref-callback with null on dispose', () async {
  Element? el1;
  var stack = RT_TestStack();

  await app!.buildChildren(
    widgets: [
      RT_TestWidget(
        roEventDispose: () {
          stack.push('dispose');
          expect(el1, equals(null));
        },
        // child widgets are disposed first
        children: [
          __WidgetClass__(id: 'some-id-1', ref: (el) => el1 = el),
        ],
      ),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  await app!.updateChildren(
    widgets: [__WidgetClass__()],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
  );

  expect(stack.popFromStart(), equals('dispose'));
  expect(stack.canPop(), equals(false));
}__Skip__);

test('should not call ref-callback on update', () async {
  var stack = RT_TestStack();

  await app!.buildChildren(
    widgets: [
      __WidgetClass__(ref: (el) {
        stack.push('callback');
      }),
    ],
    parentRenderElement: app!.appRenderElement,
  );

  await app!.updateChildren(
    widgets: [
      __WidgetClass__(ref: (el) {
        stack.push('callback');
      }),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app!.appRenderElement,
  );

  expect(stack.popFromStart(), equals('callback'));
  expect(stack.canPop(), equals(false));
}__Skip__);