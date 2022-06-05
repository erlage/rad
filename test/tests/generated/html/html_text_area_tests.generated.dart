// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

void html_text_area_test() {
  group('HTML TextArea tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: Key('some-key'), id: 'some-id'),
          TextArea(key: LocalKey('some-local-key'), id: 'some-local-id'),
          TextArea(key: GlobalKey('some-global-key'), id: 'some-global-id'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = app!.domNodeByKey('some-key', RT_TestBed.rootContext);
      var domNode2 = app!.domNodeByLocalKey('some-local-key');
      var domNode3 = app!.domNodeByGlobalKey('some-global-key');

      expect(domNode1.id, equals('some-id'));
      expect(domNode2.id, equals('some-local-id'));
      expect(domNode3.id, equals('some-global-id'));
    });

    test('should reset and update id', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: Key('some-key'), id: 'some-id'),
          TextArea(key: LocalKey('some-local-key'), id: 'some-local-id'),
          TextArea(key: GlobalKey('some-global-key'), id: 'some-global-id'),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByKey('some-key', app!.appContext);
      var domNode2 = app!.domNodeByLocalKey('some-local-key');
      var domNode3 = app!.domNodeByGlobalKey('some-global-key');

      expect(domNode1.id, equals('some-id'));
      expect(domNode2.id, equals('some-local-id'));
      expect(domNode3.id, equals('some-global-id'));

      await app!.updateChildren(
        widgets: [
          TextArea(
            key: Key('some-key'),
            id: 'some-updated-id',
          ),
          TextArea(
            key: LocalKey('some-local-key'),
            id: 'some-local-updated-id',
          ),
          TextArea(
            key: GlobalKey('some-global-key'),
            id: 'some-global-updated-id',
          ),
        ],
        updateType: UpdateType.undefined,
        parentContext: app!.appContext,
      );

      expect(domNode1.id, equals('some-updated-id'));
      expect(domNode2.id, equals('some-local-updated-id'));
      expect(domNode3.id, equals('some-global-updated-id'));
    });

    test('should set messy "id"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            id: 'some id',
          ),
          TextArea(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          TextArea(
            key: Key('widget-3'),
            id: "some 'messy' id",
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

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
          TextArea(
            id: 'widget-1',
            child: TextArea(
              id: 'widget-2',
            ),
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = domNode1.childNodes[0] as HtmlElement;

      expect(domNode1.id, equals('widget-1'));
      expect(domNode2.id, equals('widget-2'));
    });

    test('should set children widgets', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            id: 'widget-1',
            children: [
              TextArea(
                id: 'widget-2',
              ),
              TextArea(
                id: 'widget-3',
              ),
            ],
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = domNode1.childNodes[0] as HtmlElement;
      var domNode3 = domNode1.childNodes[1] as HtmlElement;

      expect(domNode1.id, equals('widget-1'));
      expect(domNode2.id, equals('widget-2'));
      expect(domNode3.id, equals('widget-3'));
    });

    test('should set attribute "classes"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: GlobalKey('el-1'),
            classAttribute: 'some-classes',
          ),
          TextArea(
            key: GlobalKey('el-2'),
            classAttribute: 'another-classes',
          ),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('class'), equals('some-classes'));
      expect(domNode2.getAttribute('class'), equals('another-classes'));
    });

    test('should update attribute "classes"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: GlobalKey('el-1'),
            classAttribute: 'some-classes',
          ),
          TextArea(
            key: GlobalKey('el-2'),
            classAttribute: 'another-classes',
          ),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(
            key: GlobalKey('el-1'),
            classAttribute: 'updated-classes',
          ),
          TextArea(
            key: GlobalKey('el-2'),
            classAttribute: 'another-classes',
          ),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('class'), equals('updated-classes'));
      expect(domNode2.getAttribute('class'), equals('another-classes'));
    });

    test('should clear attribute "classes"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(
            key: GlobalKey('el-2'),
            classAttribute: 'another-classes',
          ),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('class'), equals(null));
      expect(domNode2.getAttribute('class'), equals(null));
    });

    test('should clear attribute "classes" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: GlobalKey('el-1'),
            classAttribute: 'some-classes',
          ),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), classAttribute: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should not set attribute "classes" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), classAttribute: null),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            classAttribute: 'some classes',
          ),
          TextArea(
            key: Key('widget-2'),
            classAttribute: 'some "messy" classes',
          ),
          TextArea(
            key: Key('widget-3'),
            classAttribute: "some 'messy' classes",
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

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

    test('should set contenteditable', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            contenteditable: false,
          ),
          TextArea(
            key: Key('widget-2'),
            contenteditable: true,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

      expect(domNode1.getAttribute('contenteditable'), equals('false'));
      expect(domNode2.getAttribute('contenteditable'), equals('true'));
    });

    test('should set draggable', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            draggable: false,
          ),
          TextArea(
            key: Key('widget-2'),
            draggable: true,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

      expect(domNode1.getAttribute('draggable'), equals('false'));
      expect(domNode2.getAttribute('draggable'), equals('true'));
    });

    test('should set attribute "hidden" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), hidden: false),
          TextArea(key: GlobalKey('el-2'), hidden: null),
          TextArea(key: GlobalKey('el-3'), hidden: true),
        ],
        parentContext: app!.appContext,
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
          TextArea(key: GlobalKey('el-1'), hidden: true),
          TextArea(key: GlobalKey('el-2'), hidden: true),
          TextArea(key: GlobalKey('el-3'), hidden: true),
          TextArea(key: GlobalKey('el-4'), hidden: true),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), hidden: true),
          TextArea(key: GlobalKey('el-2'), hidden: false),
          TextArea(key: GlobalKey('el-3'), hidden: null),
          TextArea(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
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
          TextArea(
            key: GlobalKey('widget-1'),
            innerText: 'hello world',
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;

      // we are using innerHtml as inner text is not accessible
      // or returns empty string for some node(e.g progress)

      expect(domNode1.innerHtml, equals('hello world'));
    });

    test('should set attribute "onClickAttribute"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
          TextArea(
              key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('onClick'), equals('some-on-click'));
      expect(domNode2.getAttribute('onClick'), equals('another-on-click'));
    });

    test('should update attribute "onClickAttribute"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
          TextArea(
              key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(
              key: GlobalKey('el-1'), onClickAttribute: 'updated-on-click'),
          TextArea(
              key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('onClick'), equals('updated-on-click'));
      expect(domNode2.getAttribute('onClick'), equals('another-on-click'));
    });

    test('should clear attribute "onClickAttribute"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(
              key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
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
          TextArea(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), onClickAttribute: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('onClick'), equals(null));
    });

    test(
        'should not set attribute "onClickAttribute" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), onClickAttribute: null),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('onClick'), equals(null));
    });

    test('should set messy "onClickAttribute"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            onClickAttribute: 'some onClick',
          ),
          TextArea(
            key: Key('widget-2'),
            onClickAttribute: 'some "messy" onClick',
          ),
          TextArea(
            key: Key('widget-3'),
            onClickAttribute: "some 'messy' onClick",
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

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
          TextArea(
            key: GlobalKey('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          TextArea(
            key: GlobalKey('el-2'),
            onClick: (event) => testStack.push('click-2'),
          ),
        ],
        parentContext: app!.appContext,
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
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), onClick: null),
          TextArea(key: GlobalKey('el-3'), onClick: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;
      var listeners3 = app!.widget('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(null));
      expect(listeners3[DomEventType.click], equals(listener));
    });

    test('should clear "click" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), onClick: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      listeners1 = app!.widget('el-1').widgetEventListeners;
      listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(null));
    });

    test('should set style', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: Key('widget-1'), style: 'some style'),
          TextArea(key: Key('widget-2'), style: 'some "messy" style'),
          TextArea(key: Key('widget-3'), style: "some 'messy' style"),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(domNode1.getAttribute('style'), equals('some style'));
      expect(domNode2.getAttribute('style'), equals('some "messy" style'));
      expect(domNode3.getAttribute('style'), equals("some 'messy' style"));
    });

    test('should set tab index', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            tabIndex: 1,
          ),
          TextArea(
            key: Key('widget-2'),
            tabIndex: 2,
          ),
          TextArea(
            key: Key('widget-3'),
            tabIndex: 3,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(domNode1.getAttribute('tabindex'), equals('1'));
      expect(domNode2.getAttribute('tabindex'), equals('2'));
      expect(domNode3.getAttribute('tabindex'), equals('3'));
    });

    test('should set title', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: Key('widget-1'), title: 'some title'),
          TextArea(key: Key('widget-2'), title: 'some "messy" title'),
          TextArea(key: Key('widget-3'), title: "some 'messy' title"),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(domNode1.getAttribute('title'), equals('some title'));
      expect(domNode2.getAttribute('title'), equals('some "messy" title'));
      expect(domNode3.getAttribute('title'), equals("some 'messy' title"));
    });

    test('should set correct types and markup', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('some-global-key')),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(
        RT_TestBed.rootElement.innerHtml,
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
          ].contains('textarea')
              ? [
                  'input',
                ].contains('textarea')
                  // becuase system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<textarea'
                  : '<textarea>'
              : '<textarea></textarea>',
        ),
      );
    });

    test('should set data attributes', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something': 'something okay',
              'another': 'another okay',
            },
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;

      expect(domNode1.dataset['something'], equals('something okay'));
      expect(domNode1.dataset['another'], equals('another okay'));
    });

    test('should remove obsolute and add new data attributes on update',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something': 'something okay',
            },
          ),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something-new': 'something new',
            },
          ),
        ],
        updateType: UpdateType.undefined,
        parentContext: app!.appContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0].childNodes[0];

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
            TextArea(
              key: GlobalKey('some-global-key'),
              dataAttributes: {
                'something': 'something okay',
                reservedAttribute: 'must ignore',
              },
            ),
          ],
          parentContext: app!.appContext,
        );

        var domNode1 = RT_TestBed.rootElement.childNodes[0].childNodes[0];

        domNode1 as HtmlElement;

        expect(domNode1.dataset['something'], equals('something okay'));

        expect(domNode1.dataset[reservedAttribute], equals(null));
      });

      test(
          'should not remove system reserved data attribute: $reservedAttribute on update',
          () async {
        await app!.buildChildren(
          widgets: [
            TextArea(
              key: GlobalKey('some-global-key'),
              dataAttributes: {
                'something': 'something okay',
                reservedAttribute: 'must ignore',
              },
            ),
          ],
          parentContext: app!.appContext,
        );

        await app!.updateChildren(
          widgets: [
            TextArea(
              key: GlobalKey('some-global-key'),
              dataAttributes: {
                'something': 'something new',
                'something-diff': 'something diff',
                reservedAttribute: 'must ignore',
              },
            ),
          ],
          updateType: UpdateType.undefined,
          parentContext: app!.appContext,
        );

        var domNode1 = RT_TestBed.rootElement.childNodes[0].childNodes[0];

        domNode1 as HtmlElement;

        expect(domNode1.dataset['something'], equals('something new'));
        expect(domNode1.dataset['something-diff'], equals('something diff'));
        expect(domNode1.dataset[reservedAttribute], equals(null));
      });
    }

    test('should have a short-tag alias', () async {
      var widget = TextArea();
      var widgetShort = textarea();

      expect(
        widget.runtimeType,
        equals(widgetShort.runtimeType),
      );
    });

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: Key('some-key')),
          TextArea(key: LocalKey('some-local-key')),
          TextArea(key: GlobalKey('some-global-key')),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var wO1 = app!.widgetObjectByKey('some-key', RT_TestBed.rootContext);
      var wO2 = app!.widgetObjectByLocalKey('some-local-key');
      var wO3 = app!.widgetObjectByGlobalKey('some-global-key');

      expect(wO1.context.key.value, endsWith('some-key'));
      expect(wO2.context.key.value, endsWith('some-local-key'));
      expect(wO3.context.key.value, equals('some-global-key'));
    });

    test('should set attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), name: 'some-name'),
          TextArea(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('name'), equals('some-name'));
      expect(domNode2.getAttribute('name'), equals('another-name'));
    });

    test('should update attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), name: 'some-name'),
          TextArea(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), name: 'updated-name'),
          TextArea(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('name'), equals('updated-name'));
      expect(domNode2.getAttribute('name'), equals('another-name'));
    });

    test('should clear attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('name'), equals(null));
      expect(domNode2.getAttribute('name'), equals(null));
    });

    test('should clear attribute "name" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), name: 'some-name'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), name: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('name'), equals(null));
    });

    test('should not set attribute "name" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), name: null),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('name'), equals(null));
    });

    test('should set messy "name"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(
            key: Key('widget-1'),
            name: 'some name',
          ),
          TextArea(
            key: Key('widget-2'),
            name: 'some "messy" name',
          ),
          TextArea(
            key: Key('widget-3'),
            name: "some 'messy' name",
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var domNode1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('name'),
        equals('some name'),
      );

      expect(
        domNode2.getAttribute('name'),
        equals('some "messy" name'),
      );

      expect(
        domNode3.getAttribute('name'),
        equals("some 'messy' name"),
      );
    });

    test('should set attribute "placeholder"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
          TextArea(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('placeholder'), equals('some-placeholder'));
      expect(
          domNode2.getAttribute('placeholder'), equals('another-placeholder'));
    });

    test('should update attribute "placeholder"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
          TextArea(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: 'updated-placeholder'),
          TextArea(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(
          domNode1.getAttribute('placeholder'), equals('updated-placeholder'));
      expect(
          domNode2.getAttribute('placeholder'), equals('another-placeholder'));
    });

    test('should clear attribute "placeholder"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('placeholder'), equals(null));
      expect(domNode2.getAttribute('placeholder'), equals(null));
    });

    test('should clear attribute "placeholder" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('placeholder'), equals(null));
    });

    test('should not set attribute "placeholder" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: null),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('placeholder'), equals(null));
    });

    test('should set attribute "rows"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: 10),
          TextArea(key: GlobalKey('el-2'), rows: 0),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('rows'), equals('10'));
      expect(domNode2.getAttribute('rows'), equals('0'));
    });

    test('should update attribute "rows"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: 10),
          TextArea(key: GlobalKey('el-2'), rows: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: 20),
          TextArea(key: GlobalKey('el-2'), rows: 20),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('rows'), equals('20'));
      expect(domNode2.getAttribute('rows'), equals('20'));
    });

    test('should clear attribute "rows"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), rows: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('rows'), equals(null));
      expect(domNode2.getAttribute('rows'), equals(null));
    });

    test('should clear attribute "rows" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('rows'), equals(null));
    });

    test('should not set attribute "rows" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: null),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('rows'), equals(null));
    });

    test('should set attribute "cols"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: 10),
          TextArea(key: GlobalKey('el-2'), cols: 0),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('cols'), equals('10'));
      expect(domNode2.getAttribute('cols'), equals('0'));
    });

    test('should update attribute "cols"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: 10),
          TextArea(key: GlobalKey('el-2'), cols: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: 20),
          TextArea(key: GlobalKey('el-2'), cols: 20),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('cols'), equals('20'));
      expect(domNode2.getAttribute('cols'), equals('20'));
    });

    test('should clear attribute "cols"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), cols: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('cols'), equals(null));
      expect(domNode2.getAttribute('cols'), equals(null));
    });

    test('should clear attribute "cols" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('cols'), equals(null));
    });

    test('should not set attribute "cols" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: null),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('cols'), equals(null));
    });

    test('should set attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: 10),
          TextArea(key: GlobalKey('el-2'), minLength: 0),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('minlength'), equals('10'));
      expect(domNode2.getAttribute('minlength'), equals('0'));
    });

    test('should update attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: 10),
          TextArea(key: GlobalKey('el-2'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: 20),
          TextArea(key: GlobalKey('el-2'), minLength: 20),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('minlength'), equals('20'));
      expect(domNode2.getAttribute('minlength'), equals('20'));
    });

    test('should clear attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('minlength'), equals(null));
      expect(domNode2.getAttribute('minlength'), equals(null));
    });

    test('should clear attribute "minLength" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('minlength'), equals(null));
    });

    test('should not set attribute "minLength" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: null),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('minlength'), equals(null));
    });

    test('should set attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: 10),
          TextArea(key: GlobalKey('el-2'), maxLength: 0),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('maxlength'), equals('10'));
      expect(domNode2.getAttribute('maxlength'), equals('0'));
    });

    test('should update attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: 10),
          TextArea(key: GlobalKey('el-2'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: 20),
          TextArea(key: GlobalKey('el-2'), maxLength: 20),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('maxlength'), equals('20'));
      expect(domNode2.getAttribute('maxlength'), equals('20'));
    });

    test('should clear attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('maxlength'), equals(null));
      expect(domNode2.getAttribute('maxlength'), equals(null));
    });

    test('should clear attribute "maxLength" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('maxlength'), equals(null));
    });

    test('should not set attribute "maxLength" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: null),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('maxlength'), equals(null));
    });

    test('should set attribute "required" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), required: false),
          TextArea(key: GlobalKey('el-2'), required: null),
          TextArea(key: GlobalKey('el-3'), required: true),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');

      expect(domNode1.getAttribute('required'), equals(null));
      expect(domNode2.getAttribute('required'), equals(null));
      expect(domNode3.getAttribute('required'), equals('true'));
    });

    test('should clear attribute "required" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), required: true),
          TextArea(key: GlobalKey('el-2'), required: true),
          TextArea(key: GlobalKey('el-3'), required: true),
          TextArea(key: GlobalKey('el-4'), required: true),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), required: true),
          TextArea(key: GlobalKey('el-2'), required: false),
          TextArea(key: GlobalKey('el-3'), required: null),
          TextArea(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');
      var domNode4 = app!.domNodeByGlobalKey('el-4');

      expect(domNode1.getAttribute('required'), equals('true'));
      expect(domNode2.getAttribute('required'), equals(null));
      expect(domNode3.getAttribute('required'), equals(null));
      expect(domNode4.getAttribute('required'), equals(null));
    });

    test('should set attribute "readonly" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), readOnly: false),
          TextArea(key: GlobalKey('el-2'), readOnly: null),
          TextArea(key: GlobalKey('el-3'), readOnly: true),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');

      expect(domNode1.getAttribute('readonly'), equals(null));
      expect(domNode2.getAttribute('readonly'), equals(null));
      expect(domNode3.getAttribute('readonly'), equals('true'));
    });

    test('should clear attribute "readonly" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), readOnly: true),
          TextArea(key: GlobalKey('el-2'), readOnly: true),
          TextArea(key: GlobalKey('el-3'), readOnly: true),
          TextArea(key: GlobalKey('el-4'), readOnly: true),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), readOnly: true),
          TextArea(key: GlobalKey('el-2'), readOnly: false),
          TextArea(key: GlobalKey('el-3'), readOnly: null),
          TextArea(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');
      var domNode4 = app!.domNodeByGlobalKey('el-4');

      expect(domNode1.getAttribute('readonly'), equals('true'));
      expect(domNode2.getAttribute('readonly'), equals(null));
      expect(domNode3.getAttribute('readonly'), equals(null));
      expect(domNode4.getAttribute('readonly'), equals(null));
    });

    test('should set attribute "disabled" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), disabled: false),
          TextArea(key: GlobalKey('el-2'), disabled: null),
          TextArea(key: GlobalKey('el-3'), disabled: true),
        ],
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');

      expect(domNode1.getAttribute('disabled'), equals(null));
      expect(domNode2.getAttribute('disabled'), equals(null));
      expect(domNode3.getAttribute('disabled'), equals('true'));
    });

    test('should clear attribute "disabled" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), disabled: true),
          TextArea(key: GlobalKey('el-2'), disabled: true),
          TextArea(key: GlobalKey('el-3'), disabled: true),
          TextArea(key: GlobalKey('el-4'), disabled: true),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), disabled: true),
          TextArea(key: GlobalKey('el-2'), disabled: false),
          TextArea(key: GlobalKey('el-3'), disabled: null),
          TextArea(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');
      var domNode4 = app!.domNodeByGlobalKey('el-4');

      expect(domNode1.getAttribute('disabled'), equals('true'));
      expect(domNode2.getAttribute('disabled'), equals(null));
      expect(domNode3.getAttribute('disabled'), equals(null));
      expect(domNode4.getAttribute('disabled'), equals(null));
    });
  });
}
