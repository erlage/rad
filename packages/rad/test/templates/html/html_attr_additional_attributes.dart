
test('should allow widget attributes to be set through additional attributes', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
            key: Key('some-key-3'),
              additionalAttributes: {
                'id': 'some-id',
              },
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );


    var domNode1 = app!.appDomNode.childNodes[0];

    domNode1 as HtmlElement;

    expect(domNode1.id, equals('some-id'));
}__Skip__);

test('should ignore additional attribute if already set in widget constructor', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
            key: Key('some-key-3'),
              id: 'some-id',
              additionalAttributes: {
                'id': 'ignored-id',
                'custom': 'applied',
              },
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );


    var domNode1 = app!.appDomNode.childNodes[0];

    domNode1 as HtmlElement;

    expect(domNode1.id, equals('some-id'));
    expect(domNode1.getAttribute('custom'), equals('applied'));
}__Skip__);

test('should ignore additional attribute if already set in widget constructor, during updates', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
            key: Key('some-key-3'),
              id: 'some-id',
              additionalAttributes: {
                'id': 'ignored-id',
              },
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(
            key: Key('some-key-3'),
              id: 'updated-id',
              additionalAttributes: {
                'id': 'ignored-id',
              },
            ),
        ],
        updateType: UpdateType.undefined,
        parentRenderElement: app!.appRenderElement,
    );


    var domNode1 = app!.appDomNode.childNodes[0];

    domNode1 as HtmlElement;

    expect(domNode1.id, equals('updated-id'));
}__Skip__);

test('should set data attributes', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
            key: Key('some-key-3'),
                additionalAttributes: {
                    'data-something': 'something okay',
                    'data-another': 'another okay',
                },
            ),
        ],
                parentRenderElement: app!.appRenderElement,

    );

    var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;

    expect(domNode1.dataset['something'], equals('something okay'));
    expect(domNode1.dataset['another'], equals('another okay'));
}__Skip__);

test('should set aria/any attributes', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
            key: Key('some-key-3'),
                additionalAttributes: {
                    'aria-something': 'something okay',
                    'any-another': 'another okay',
                },
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;

    expect(domNode1.getAttribute('aria-something'), equals('something okay'));
    expect(domNode1.getAttribute('any-another'), equals('another okay'));
}__Skip__);


test('should remove obsolete and add new data attributes on update', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(
            key: Key('some-key-3'),
                additionalAttributes: {
                    'data-something': 'something okay',
                },
            ),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(
                key: Key('some-key-3'),
                additionalAttributes: {
                    'data-something-new': 'something new',
                },
            ),
        ],
        updateType: UpdateType.undefined,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.appDomNode.childNodes[0];

    domNode1 as HtmlElement;

    expect(domNode1.dataset['something'], equals(null));
    expect(domNode1.dataset['something-new'], equals('something new'));
}__Skip__);
