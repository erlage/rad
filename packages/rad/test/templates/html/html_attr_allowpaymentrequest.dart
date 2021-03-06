test('should set attribute "allowPaymentRequest" only if its true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), allowPaymentRequest: false),
            __WidgetClass__(key: Key('el-2'), allowPaymentRequest: null),
            __WidgetClass__(key: Key('el-3'), allowPaymentRequest: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('allowpaymentrequest'), equals(null));
    expect(domNode2.getAttribute('allowpaymentrequest'), equals(null));
    expect(domNode3.getAttribute('allowpaymentrequest'), equals('true'));
}__Skip__);

test('should clear attribute "allowPaymentRequest" if updated value is not true', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), allowPaymentRequest: true),
            __WidgetClass__(key: Key('el-2'), allowPaymentRequest: true),
            __WidgetClass__(key: Key('el-3'), allowPaymentRequest: true),
            __WidgetClass__(key: Key('el-4'), allowPaymentRequest: true),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), allowPaymentRequest: true),
            __WidgetClass__(key: Key('el-2'), allowPaymentRequest: false),
            __WidgetClass__(key: Key('el-3'), allowPaymentRequest: null),
            __WidgetClass__(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');
    var domNode4 = app!.domNodeByKeyValue('el-4');

    expect(domNode1.getAttribute('allowpaymentrequest'), equals('true'));
    expect(domNode2.getAttribute('allowpaymentrequest'), equals(null));
    expect(domNode3.getAttribute('allowpaymentrequest'), equals(null));
    expect(domNode4.getAttribute('allowpaymentrequest'), equals(null));
});