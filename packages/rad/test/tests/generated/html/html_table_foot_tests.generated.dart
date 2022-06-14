// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

void html_table_foot_test() {
  group('HTML TableFoot tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('some-key-1'), id: 'some-id-1'),
          TableFoot(key: GlobalKey('some-key-2'), id: 'some-id-2'),
          TableFoot(key: GlobalKey('some-key-3'), id: 'some-id-3'),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('some-key-1');
      var domNode2 = app!.domNodeByGlobalKey('some-key-2');
      var domNode3 = app!.domNodeByGlobalKey('some-key-3');

      expect(domNode1.id, equals('some-id-1'));
      expect(domNode2.id, equals('some-id-2'));
      expect(domNode3.id, equals('some-id-3'));
    });

    test('should reset and update id', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('some-key-1'), id: 'some-id-1'),
          TableFoot(key: GlobalKey('some-key-2'), id: 'some-id-2'),
          TableFoot(key: GlobalKey('some-key-3'), id: 'some-id-3'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('some-key-1');
      var domNode2 = app!.domNodeByGlobalKey('some-key-2');
      var domNode3 = app!.domNodeByGlobalKey('some-key-3');

      expect(domNode1.id, equals('some-id-1'));
      expect(domNode2.id, equals('some-id-2'));
      expect(domNode3.id, equals('some-id-3'));

      await app!.updateChildren(
        widgets: [
          TableFoot(
            key: GlobalKey('some-key-1'),
            id: 'some-updated-id',
          ),
          TableFoot(
            key: GlobalKey('some-key-2'),
            id: 'some-local-updated-id',
          ),
          TableFoot(
            key: GlobalKey('some-key-3'),
            id: 'some-global-updated-id',
          ),
        ],
        updateType: UpdateType.undefined,
        parentRenderElement: app!.appRenderElement,
      );

      expect(domNode1.id, equals('some-updated-id'));
      expect(domNode2.id, equals('some-local-updated-id'));
      expect(domNode3.id, equals('some-global-updated-id'));
    });

    test('should set messy "id"', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: Key('widget-1'),
            id: 'some id',
          ),
          TableFoot(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          TableFoot(
            key: Key('widget-3'),
            id: "some 'messy' id",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('id'),
        equals('some id'),
      );

      expect(
        domNode2.getAttribute('id'),
        equals('some "messy" id'),
      );

      expect(
        domNode3.getAttribute('id'),
        equals("some 'messy' id"),
      );
    });

    test('should set child widget', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            id: 'widget-1',
            child: TableFoot(
              id: 'widget-2',
            ),
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = domNode1.childNodes[0] as HtmlElement;

      expect(domNode1.id, equals('widget-1'));
      expect(domNode2.id, equals('widget-2'));
    });

    test('should set children widgets', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            id: 'widget-1',
            children: [
              TableFoot(
                id: 'widget-2',
              ),
              TableFoot(
                id: 'widget-3',
              ),
            ],
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = domNode1.childNodes[0] as HtmlElement;
      var domNode3 = domNode1.childNodes[1] as HtmlElement;

      expect(domNode1.id, equals('widget-1'));
      expect(domNode2.id, equals('widget-2'));
      expect(domNode3.id, equals('widget-3'));
    });

    test('should set attribute "classes"', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: GlobalKey('el-1'),
            classAttribute: 'some-classes',
          ),
          TableFoot(
            key: GlobalKey('el-2'),
            classAttribute: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('class'), equals('some-classes'));
      expect(domNode2.getAttribute('class'), equals('another-classes'));
    });

    test('should update attribute "classes"', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: GlobalKey('el-1'),
            classAttribute: 'some-classes',
          ),
          TableFoot(
            key: GlobalKey('el-2'),
            classAttribute: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          TableFoot(
            key: GlobalKey('el-1'),
            classAttribute: 'updated-classes',
          ),
          TableFoot(
            key: GlobalKey('el-2'),
            classAttribute: 'another-classes',
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('class'), equals('updated-classes'));
      expect(domNode2.getAttribute('class'), equals('another-classes'));
    });

    test('should clear attribute "classes"', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1')),
          TableFoot(
            key: GlobalKey('el-2'),
            classAttribute: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1')),
          TableFoot(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('class'), equals(null));
      expect(domNode2.getAttribute('class'), equals(null));
    });

    test('should clear attribute "classes" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: GlobalKey('el-1'),
            classAttribute: 'some-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1'), classAttribute: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should not set attribute "classes" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1'), classAttribute: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: Key('widget-1'),
            classAttribute: 'some classes',
          ),
          TableFoot(
            key: Key('widget-2'),
            classAttribute: 'some "messy" classes',
          ),
          TableFoot(
            key: Key('widget-3'),
            classAttribute: "some 'messy' classes",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('class'),
        equals('some classes'),
      );

      expect(
        domNode2.getAttribute('class'),
        equals('some "messy" classes'),
      );

      expect(
        domNode3.getAttribute('class'),
        equals("some 'messy' classes"),
      );
    });

    test('should set contentEditable', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: Key('widget-1'),
            contentEditable: false,
          ),
          TableFoot(
            key: Key('widget-2'),
            contentEditable: true,
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;

      expect(domNode1.getAttribute('contentEditable'), equals('false'));
      expect(domNode2.getAttribute('contentEditable'), equals('true'));
    });

    test('should set draggable', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: Key('widget-1'),
            draggable: false,
          ),
          TableFoot(
            key: Key('widget-2'),
            draggable: true,
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;

      expect(domNode1.getAttribute('draggable'), equals('false'));
      expect(domNode2.getAttribute('draggable'), equals('true'));
    });

    test('should set attribute "hidden" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1'), hidden: false),
          TableFoot(key: GlobalKey('el-2'), hidden: null),
          TableFoot(key: GlobalKey('el-3'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');

      expect(domNode1.getAttribute('hidden'), equals(null));
      expect(domNode2.getAttribute('hidden'), equals(null));
      expect(domNode3.getAttribute('hidden'), equals('true'));
    });

    test('should clear attribute "hidden" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1'), hidden: true),
          TableFoot(key: GlobalKey('el-2'), hidden: true),
          TableFoot(key: GlobalKey('el-3'), hidden: true),
          TableFoot(key: GlobalKey('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1'), hidden: true),
          TableFoot(key: GlobalKey('el-2'), hidden: false),
          TableFoot(key: GlobalKey('el-3'), hidden: null),
          TableFoot(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');
      var domNode4 = app!.domNodeByGlobalKey('el-4');

      expect(domNode1.getAttribute('hidden'), equals('true'));
      expect(domNode2.getAttribute('hidden'), equals(null));
      expect(domNode3.getAttribute('hidden'), equals(null));
      expect(domNode4.getAttribute('hidden'), equals(null));
    });

    test('should set inner text', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: GlobalKey('widget-1'),
            innerText: 'hello world',
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;

      // we are using innerHtml as inner text is not accessible
      // or returns empty string for some node(e.g progress)

      expect(domNode1.innerHtml, equals('hello world'));
    });

    test('should set attribute "onClickAttribute"', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
          TableFoot(
              key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('onClick'), equals('some-on-click'));
      expect(domNode2.getAttribute('onClick'), equals('another-on-click'));
    });

    test('should update attribute "onClickAttribute"', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
          TableFoot(
              key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          TableFoot(
              key: GlobalKey('el-1'), onClickAttribute: 'updated-on-click'),
          TableFoot(
              key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('onClick'), equals('updated-on-click'));
      expect(domNode2.getAttribute('onClick'), equals('another-on-click'));
    });

    test('should clear attribute "onClickAttribute"', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1')),
          TableFoot(
              key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1')),
          TableFoot(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('onClick'), equals(null));
      expect(domNode2.getAttribute('onClick'), equals(null));
    });

    test('should clear attribute "onClickAttribute" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1'), onClickAttribute: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('onClick'), equals(null));
    });

    test(
        'should not set attribute "onClickAttribute" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1'), onClickAttribute: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('onClick'), equals(null));
    });

    test('should set messy "onClickAttribute"', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: Key('widget-1'),
            onClickAttribute: 'some onClick',
          ),
          TableFoot(
            key: Key('widget-2'),
            onClickAttribute: 'some "messy" onClick',
          ),
          TableFoot(
            key: Key('widget-3'),
            onClickAttribute: "some 'messy' onClick",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('onclick'),
        equals('some onClick'),
      );

      expect(
        domNode2.getAttribute('onclick'),
        equals('some "messy" onClick'),
      );

      expect(
        domNode3.getAttribute('onclick'),
        equals("some 'messy' onClick"),
      );
    });

    test('should set "click" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: GlobalKey('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          TableFoot(
            key: GlobalKey('el-2'),
            onClick: (event) => testStack.push('click-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByGlobalKey('el-1').dispatchEvent(Event('click'));
      app!.domNodeByGlobalKey('el-2').dispatchEvent(Event('click'));

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('click-1'));
        expect(testStack.popFromStart(), equals('click-2'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should set "click" event listener only if provided', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1')),
          TableFoot(key: GlobalKey('el-2'), onClick: null),
          TableFoot(key: GlobalKey('el-3'), onClick: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByGlobalKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(null));
      expect(listeners3[DomEventType.click], equals(listener));
    });

    test('should clear "click" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1')),
          TableFoot(key: GlobalKey('el-2'), onClick: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          TableFoot(key: GlobalKey('el-1')),
          TableFoot(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(null));
    });

    test('should set style', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: Key('widget-1'), style: 'some style'),
          TableFoot(key: Key('widget-2'), style: 'some "messy" style'),
          TableFoot(key: Key('widget-3'), style: "some 'messy' style"),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(domNode1.getAttribute('style'), equals('some style'));
      expect(domNode2.getAttribute('style'), equals('some "messy" style'));
      expect(domNode3.getAttribute('style'), equals("some 'messy' style"));
    });

    test('should set tab index', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
            key: Key('widget-1'),
            tabIndex: 1,
          ),
          TableFoot(
            key: Key('widget-2'),
            tabIndex: 2,
          ),
          TableFoot(
            key: Key('widget-3'),
            tabIndex: 3,
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(domNode1.getAttribute('tabindex'), equals('1'));
      expect(domNode2.getAttribute('tabindex'), equals('2'));
      expect(domNode3.getAttribute('tabindex'), equals('3'));
    });

    test('should set title', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: Key('widget-1'), title: 'some title'),
          TableFoot(key: Key('widget-2'), title: 'some "messy" title'),
          TableFoot(key: Key('widget-3'), title: "some 'messy' title"),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(domNode1.getAttribute('title'), equals('some title'));
      expect(domNode2.getAttribute('title'), equals('some "messy" title'));
      expect(domNode3.getAttribute('title'), equals("some 'messy' title"));
    });

    test('should set correct types and markup', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('some-key-3')),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      expect(
        RT_TestBed.rootDomNode.innerHtml,
        startsWith(
          //
          // img/col tags might don't have a closing tag
          //
          [
            'img',
            'col',
            'br',
            'hr',
            'input',
          ].contains('tfoot')
              ? [
                  'input',
                ].contains('tfoot')
                  // becuase system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<tfoot'
                  : '<tfoot>'
              : '<tfoot></tfoot>',
        ),
      );
    });

    test('should set data attributes', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
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
    });

    test('should remove obsolute and add new data attributes on update',
        () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(
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
          TableFoot(
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
    });

    for (final reservedAttribute in Constants.reservedAttributes) {
      test(
          'should not override system reserved attribute: $reservedAttribute on build',
          () async {
        await app!.buildChildren(
          widgets: [
            TableFoot(
              key: GlobalKey('some-key-3'),
              dataAttributes: {
                'something': 'something okay',
                reservedAttribute: 'must ignore',
              },
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var domNode1 = RT_TestBed.rootDomNode.childNodes[0].childNodes[0];

        domNode1 as HtmlElement;

        expect(domNode1.dataset['something'], equals('something okay'));

        expect(domNode1.dataset[reservedAttribute], equals(null));
      });

      test(
          'should not remove system reserved data attribute: $reservedAttribute on update',
          () async {
        await app!.buildChildren(
          widgets: [
            TableFoot(
              key: GlobalKey('some-key-3'),
              dataAttributes: {
                'something': 'something okay',
                reservedAttribute: 'must ignore',
              },
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [
            TableFoot(
              key: GlobalKey('some-key-3'),
              dataAttributes: {
                'something': 'something new',
                'something-diff': 'something diff',
                reservedAttribute: 'must ignore',
              },
            ),
          ],
          updateType: UpdateType.undefined,
          parentRenderElement: app!.appRenderElement,
        );

        var domNode1 = RT_TestBed.rootDomNode.childNodes[0].childNodes[0];

        domNode1 as HtmlElement;

        expect(domNode1.dataset['something'], equals('something new'));
        expect(domNode1.dataset['something-diff'], equals('something diff'));
        expect(domNode1.dataset[reservedAttribute], equals(null));
      });
    }

    test('should have a short-tag alias', () async {
      var widget = TableFoot();
      var widgetShort = tfoot();

      expect(
        widget.runtimeType,
        equals(widgetShort.runtimeType),
      );
    });

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          TableFoot(key: GlobalKey('some-key-1')),
          TableFoot(key: GlobalKey('some-key-2')),
          TableFoot(key: GlobalKey('some-key-3')),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var wO1 = app!.renderElementByGlobalKey('some-key-1')!;
      var wO2 = app!.renderElementByGlobalKey('some-key-2')!;
      var wO3 = app!.renderElementByGlobalKey('some-key-3')!;

      expect(wO1.key?.value, endsWith('some-key-1'));
      expect(wO2.key?.value, endsWith('some-key-2'));
      expect(wO3.key?.value, equals('some-key-3'));
    });
  });
}
