test('should dispatch event', () async {
  var pap = app!;

  await pap.buildChildren(
    widgets: [
      RT_EventfulWidget(
        key: Key('domNode'),
        __EventAttributeName__: (_) => pap.stack.push('__EventNativeName__-domNode'),
      ),
    ],
    parentRenderElement: pap.appRenderElement,
  );

  var domNode = pap.domNodeByKeyValue('domNode');

  domNode.dispatchEvent(Event('__EventNativeName__'));
  await Future.delayed(Duration(milliseconds: 50));

  expect(pap.stack.popFromStart(), equals('__EventNativeName__-domNode'));

  expect(pap.stack.canPop(), equals(false));
}__Skip__);
