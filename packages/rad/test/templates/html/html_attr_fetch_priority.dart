test('should set attribute "type"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), fetchPriority: FetchPriorityType.high),
            __WidgetClass__(key: Key('el-2'), fetchPriority: FetchPriorityType.low),
            __WidgetClass__(key: Key('el-3'), fetchPriority: FetchPriorityType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('type'), equals('high'));
    expect(domNode2.getAttribute('type'), equals('low'));
    expect(domNode3.getAttribute('type'), equals('auto'));
}__Skip__);

test('should update attribute "type"', () async {
    await app!.buildChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1'), fetchPriority: FetchPriorityType.high),
            __WidgetClass__(key: Key('el-2'), fetchPriority: FetchPriorityType.low),
            __WidgetClass__(key: Key('el-3'), fetchPriority: FetchPriorityType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
    );

    await app!.updateChildren(
        widgets: [
            __WidgetClass__(key: Key('el-1')),
            __WidgetClass__(key: Key('el-2'), fetchPriority: null),
            __WidgetClass__(key: Key('el-3'), fetchPriority: FetchPriorityType.high),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
    );

    var domNode1 = app!.domNodeByKeyValue('el-1');
    var domNode2 = app!.domNodeByKeyValue('el-2');
    var domNode3 = app!.domNodeByKeyValue('el-3');

    expect(domNode1.getAttribute('type'), equals(null));
    expect(domNode2.getAttribute('type'), equals(null));
    expect(domNode3.getAttribute('type'), equals('high'));
}__Skip__);