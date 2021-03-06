test(
  'should restart propagation if called restartPropagationIfStopped',
  () async {
    var pap = app!;

    await pap.buildChildren(
      widgets: [
        RT_EventfulWidget(
          key: Key('el-g-parent'),
          __EventAttributeName__: (_) => pap.stack.push('__EventNativeName__-g-parent'),
          children: [
            RT_EventfulWidget(
              key: Key('el-parent'),
              __EventAttributeName__: (event) {
                pap.stack.push('__EventNativeName__-parent');

                event.restartPropagationIfStopped();
              },
              children: [
                RT_EventfulWidget(key: Key('el-child')),
              ],
            ),
          ],
        )
      ],
      parentRenderElement: pap.appRenderElement,
    );

    var child = pap.domNodeByKeyValue('el-child');

    child.dispatchEvent(Event('__EventNativeName__')); // third
    await Future.delayed(Duration(milliseconds: 50));

    expect(pap.stack.popFromStart(), equals('__EventNativeName__-parent'));
    expect(pap.stack.popFromStart(), equals('__EventNativeName__-g-parent'));

    expect(pap.stack.canPop(), equals(false));
  },
);

test(
  'should stop propagation if stopped after restartPropagationIfStopped',
  () async {
    var pap = app!;

    await pap.buildChildren(
      widgets: [
        RT_EventfulWidget(
          key: Key('el-g-parent'),
          __EventAttributeName__: (_) => pap.stack.push('__EventNativeName__-g-parent'),
          children: [
            RT_EventfulWidget(
              key: Key('el-parent'),
              __EventAttributeName__: (event) {
                pap.stack.push('__EventNativeName__-parent');

                event.stopPropagation();
              },
              children: [
                RT_EventfulWidget(
                  __EventAttributeName__: (event) {
                    pap.stack.push('__EventNativeName__-child');

                    event.restartPropagationIfStopped();
                  },
                  key: Key('el-child'),
                ),
              ],
            ),
          ],
        )
      ],
      parentRenderElement: pap.appRenderElement,
    );

    var child = pap.domNodeByKeyValue('el-child');

    child.dispatchEvent(Event('__EventNativeName__'));
    await Future.delayed(Duration(milliseconds: 50));

    expect(pap.stack.popFromStart(), equals('__EventNativeName__-child'));
    expect(pap.stack.popFromStart(), equals('__EventNativeName__-parent'));

    expect(pap.stack.canPop(), equals(false));
  },
);