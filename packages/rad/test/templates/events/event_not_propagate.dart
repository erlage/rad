test('should propagate event only upto matching target', () async {
  var pap = app!;

  await pap.buildChildren(
    widgets: [
      RT_EventfulWidget(
        key: GlobalKey('el-g-parent'),
        __EventAttributeName__: (_) => pap.stack.push('__EventNativeName__-g-parent'),
        children: [
          RT_EventfulWidget(
            key: GlobalKey('el-parent'),
            __EventAttributeName__: (_) => pap.stack.push('__EventNativeName__-parent'),
            children: [
              RT_EventfulWidget(key: GlobalKey('el-child')),
            ],
          ),
        ],
      )
    ],
    parentRenderElement: pap.appRenderElement,
  );

  var gparent = pap.domNodeByGlobalKey('el-g-parent');
  var parent = pap.domNodeByGlobalKey('el-parent');
  var child = pap.domNodeByGlobalKey('el-child');

  gparent.dispatchEvent(Event('__EventNativeName__')); // first
  parent.dispatchEvent(Event('__EventNativeName__')); // second
  child.dispatchEvent(Event('__EventNativeName__')); // third
  await Future.delayed(Duration(milliseconds: 50));

  // after 1st dispatch

  expect(pap.stack.popFromStart(), equals('__EventNativeName__-g-parent'));

  // after 2nd dispatch

  expect(pap.stack.popFromStart(), equals('__EventNativeName__-parent'));

  // after 3rd dispatch

  expect(pap.stack.popFromStart(), equals('__EventNativeName__-parent'));

  expect(pap.stack.canPop(), equals(false));
});