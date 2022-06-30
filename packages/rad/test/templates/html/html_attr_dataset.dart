test('should set data attributes', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
            key: GlobalKey('some-key-3'),
                dataAttributes: {
                    'something': 'something okay',
                    'another': 'another okay',
                },
            ),
        ],
                parentRenderElement: RT_TestBed.rootRenderElement,

    );

    var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;

    expect(domNode1.dataset['something'], equals('something okay'));
    expect(domNode1.dataset['another'], equals('another okay'));
}__Skip__);


test('should remove obsolute and add new data attributes on update', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
            key: GlobalKey('some-key-3'),
                dataAttributes: {
                    'something': 'something okay',
                },
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(
                key: GlobalKey('some-key-3'),
                dataAttributes: {
                    'something-new': 'something new',
                },
            ),
        ],
        updateType: UpdateType.undefined,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = RT_TestBed.rootDomNode.childNodes[0].childNodes[0];

    domNode1 as HtmlElement;

    expect(domNode1.dataset['something'], equals(null));
    expect(domNode1.dataset['something-new'], equals('something new'));
}__Skip__);
