test('Route widget - description test', () async {
  var pap = app!;

  await pap.buildChildren(
    widgets: [
      Route(
        key: Key('widget'),
        name: 'some-name',
        page: Text('hw'),
      ),
    ],
    parentRenderElement: pap.appRenderElement,
  );

  var domNode = pap.domNodeByKeyValue('widget');

  expect(domNode.getComputedStyle().display, equals('contents'));
});
