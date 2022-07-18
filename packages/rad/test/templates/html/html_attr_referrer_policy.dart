test('should set attribute "referrerpolicy"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), referrerPolicy: ReferrerPolicyType.noReferrer),
          __WidgetClass__(key: Key('el-2'), referrerPolicy: ReferrerPolicyType.noReferrerWhenDowngrade),
          __WidgetClass__(key: Key('el-3'), referrerPolicy: ReferrerPolicyType.origin),
          __WidgetClass__(key: Key('el-4'), referrerPolicy: ReferrerPolicyType.originWhenCrossOrigin),
          __WidgetClass__(key: Key('el-5'), referrerPolicy: ReferrerPolicyType.sameOrigin),
          __WidgetClass__(key: Key('el-6'), referrerPolicy: ReferrerPolicyType.strictOrigin),
          __WidgetClass__(key: Key('el-7'), referrerPolicy: ReferrerPolicyType.strictOriginWhenCrossOrigin),
          __WidgetClass__(key: Key('el-8'), referrerPolicy: ReferrerPolicyType.unSafeUrl),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');
    var domNode5 = app!.domNodeByKeyValue('el-5');
    var domNode6 = app!.domNodeByKeyValue('el-6');
    var domNode7 = app!.domNodeByKeyValue('el-7');
    var domNode8 = app!.domNodeByKeyValue('el-8');

    expect(
      domNode1.getAttribute('referrerpolicy'),
      equals('no-referrer'),
    );
    expect(
      domNode2.getAttribute('referrerpolicy'),
      equals('no-referrer-when-downgrade'),
    );
    expect(
      domNode3.getAttribute('referrerpolicy'),
      equals('origin'),
    );
    expect(
      domNode4.getAttribute('referrerpolicy'),
      equals('origin-when-cross-origin'),
    );
    expect(
      domNode5.getAttribute('referrerpolicy'),
      equals('same-origin'),
    );
    expect(
      domNode6.getAttribute('referrerpolicy'),
      equals('strict-origin'),
    );
    expect(
      domNode7.getAttribute('referrerpolicy'),
      equals('strict-origin-when-cross-origin'),
    );
    expect(
      domNode8.getAttribute('referrerpolicy'),
      equals('unsafe-url'),
    );
});

test('should update attribute "referrerpolicy"', () async {
    await app!.buildChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1'), referrerPolicy: ReferrerPolicyType.noReferrer),
          __WidgetClass__(key: Key('el-2'), referrerPolicy: ReferrerPolicyType.noReferrerWhenDowngrade),
          __WidgetClass__(key: Key('el-3'), referrerPolicy: ReferrerPolicyType.origin),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
          __WidgetClass__(key: Key('el-1')),
          __WidgetClass__(key: Key('el-2'), referrerPolicy: null),
          __WidgetClass__(key: Key('el-3'), referrerPolicy: ReferrerPolicyType.originWhenCrossOrigin),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(
        domNode1.getAttribute('referrerpolicy'),
        equals(null),
    );
    expect(
        domNode2.getAttribute('referrerpolicy'),
        equals(null),
    );
    expect(
        domNode3.getAttribute('referrerpolicy'),
        equals(ReferrerPolicyType.originWhenCrossOrigin.nativeValue),
    );
});
