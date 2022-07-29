test('should propagate event', () async {
  var pap = app!;

  await pap.buildChildren(
    widgets: [
      RT_EventfulWidget(
          key: Key('el-g-parent'),
          __EventAttributeName__: (_) => pap.stack.push('__EventNativeName__-g-parent'),
          children: [
          RT_EventfulWidget(
            key: Key('el-parent'),
            __EventAttributeName__: (_) => pap.stack.push('__EventNativeName__-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-child'),
                __EventAttributeName__: (_) => pap.stack.push('__EventNativeName__-child'),
              ),
            ],
          ),
        ],
      ),
    ],
    parentRenderElement: pap.appRenderElement,
  );

  var gParent = pap.domNodeByKeyValue('el-g-parent');
  var parent = pap.domNodeByKeyValue('el-parent');
  var child = pap.domNodeByKeyValue('el-child');

  gParent.dispatchEvent(Event('__EventNativeName__')); // first
  parent.dispatchEvent(Event('__EventNativeName__'));  // second
  child.dispatchEvent(Event('__EventNativeName__'));   // third
  await Future.delayed(Duration(milliseconds: 50));

  // after 1st dispatch

  expect(pap.stack.popFromStart(), equals('__EventNativeName__-g-parent'));

  // after 2nd dispatch

  expect(pap.stack.popFromStart(), equals('__EventNativeName__-parent'));
  expect(pap.stack.popFromStart(), equals('__EventNativeName__-g-parent'));

  // after 3rd dispatch

  expect(pap.stack.popFromStart(), equals('__EventNativeName__-child'));
  expect(pap.stack.popFromStart(), equals('__EventNativeName__-parent'));
  expect(pap.stack.popFromStart(), equals('__EventNativeName__-g-parent'));

  expect(pap.stack.canPop(), equals(false));
}__Skip__);
