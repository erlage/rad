// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '_html_tests_index_test.dart';

void html_form_test() {
  group('HTML Form tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: Key('some-key'), id: 'some-id'),
          Form(key: LocalKey('some-local-key'), id: 'some-local-id'),
          Form(key: GlobalKey('some-global-key'), id: 'some-global-id'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = app!.services.walker
          .getWidgetObjectUsingKey(
            app!.services.keyGen
                .getGlobalKeyUsingKey(Key('some-key'), RT_TestBed.rootContext)
                .value,
          )!
          .element;

      var element2 = app!.services.walker
          .getWidgetObjectUsingKey(
            app!.services.keyGen
                .getGlobalKeyUsingKey(
                    LocalKey('some-local-key'), RT_TestBed.rootContext)
                .value,
          )!
          .element;

      var element3 = app!.services.walker
          .getWidgetObjectUsingKey(
            app!.services.keyGen
                .getGlobalKeyUsingKey(
                    GlobalKey('some-global-key'), RT_TestBed.rootContext)
                .value,
          )!
          .element;

      expect(element1.id, endsWith('some-id'));
      expect(element2.id, endsWith('some-local-id'));
      expect(element3.id, equals('some-global-id'));
    });

    test('should reset and update id', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: Key('some-key'), id: 'some-id'),
          Form(key: LocalKey('some-local-key'), id: 'some-local-id'),
          Form(key: GlobalKey('some-global-key'), id: 'some-global-id'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.services.walker
          .getWidgetObjectUsingKey(
            app!.services.keyGen
                .getGlobalKeyUsingKey(Key('some-key'), app!.appContext)
                .value,
          )!
          .element;

      var element2 = app!.services.walker
          .getWidgetObjectUsingKey(
            app!.services.keyGen
                .getGlobalKeyUsingKey(
                    LocalKey('some-local-key'), app!.appContext)
                .value,
          )!
          .element;

      var element3 = app!.services.walker
          .getWidgetObjectUsingKey(
            app!.services.keyGen
                .getGlobalKeyUsingKey(
                    GlobalKey('some-global-key'), app!.appContext)
                .value,
          )!
          .element;

      expect(element1.id, endsWith('some-id'));
      expect(element2.id, endsWith('some-local-id'));
      expect(element3.id, equals('some-global-id'));

      app!.framework.updateChildren(
        widgets: [
          Form(
            key: Key('some-key'),
            id: 'some-updated-id',
          ),
          Form(
            key: LocalKey('some-local-key'),
            id: 'some-local-updated-id',
          ),
          Form(
            key: GlobalKey('some-global-key'),
            id: 'some-global-updated-id',
          ),
        ],
        updateType: UpdateType.undefined,
        parentContext: app!.appContext,
      );

      expect(element1.id, endsWith('some-updated-id'));
      expect(element2.id, endsWith('some-local-updated-id'));
      expect(element3.id, equals('some-global-updated-id'));
    });

    test('should set child widget', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            id: 'widget-1',
            child: Form(
              id: 'widget-2',
            ),
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = element1.childNodes[0] as HtmlElement;

      expect(element1.id, equals('widget-1'));
      expect(element2.id, equals('widget-2'));
    });

    test('should set children widgets', () {
      app!.framework.buildChildren(
        widgets: [
          Form(id: 'widget-1', children: [
            Form(
              id: 'widget-2',
            ),
            Form(
              id: 'widget-3',
            ),
          ]),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = element1.childNodes[0] as HtmlElement;
      var element3 = element1.childNodes[1] as HtmlElement;

      expect(element1.id, equals('widget-1'));
      expect(element2.id, equals('widget-2'));
      expect(element3.id, equals('widget-3'));
    });

    test('should set classes', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            id: 'widget-1',
            classAttribute: 'some class',
          ),
          Form(
            id: 'widget-2',
            classAttribute: 'some "messy" class',
          ),
          Form(
            id: 'widget-3',
            classAttribute: "some 'messy' class",
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(element1.getAttribute('class'), equals('some class'));
      expect(element2.getAttribute('class'), equals('some "messy" class'));
      expect(element3.getAttribute('class'), equals("some 'messy' class"));
    });

    test('should set contenteditable', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            key: Key('widget-1'),
            contenteditable: false,
          ),
          Form(
            key: Key('widget-2'),
            contenteditable: true,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

      expect(element1.getAttribute('contenteditable'), equals('false'));
      expect(element2.getAttribute('contenteditable'), equals('true'));
    });

    test('should set draggable', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            key: Key('widget-1'),
            draggable: false,
          ),
          Form(
            key: Key('widget-2'),
            draggable: true,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

      expect(element1.getAttribute('draggable'), equals('false'));
      expect(element2.getAttribute('draggable'), equals('true'));
    });

    test('should set attribute "hidden" only if its true', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), hidden: false),
          Form(key: GlobalKey('el-2'), hidden: null),
          Form(key: GlobalKey('el-3'), hidden: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');

      expect(element1.getAttribute('hidden'), equals(null));
      expect(element2.getAttribute('hidden'), equals(null));
      expect(element3.getAttribute('hidden'), equals('true'));
    });

    test('should clear attribute "hidden" if updated value is not true', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), hidden: true),
          Form(key: GlobalKey('el-2'), hidden: true),
          Form(key: GlobalKey('el-3'), hidden: true),
          Form(key: GlobalKey('el-4'), hidden: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), hidden: true),
          Form(key: GlobalKey('el-2'), hidden: false),
          Form(key: GlobalKey('el-3'), hidden: null),
          Form(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');
      var element4 = app!.element('el-4');

      expect(element1.getAttribute('hidden'), equals('true'));
      expect(element2.getAttribute('hidden'), equals(null));
      expect(element3.getAttribute('hidden'), equals(null));
      expect(element4.getAttribute('hidden'), equals(null));
    });

    test('should set inner text', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            key: GlobalKey('widget-1'),
            innerText: 'hello world',
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;

      // we are using innerHtml as inner text is not accessible
      // or returns empty string for some node(e.g progress)

      expect(element1.innerHtml, equals('hello world'));
    });

    test('should set onClick', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            key: Key('widget-1'),
            onClickAttribute: 'some onClick',
          ),
          Form(
            key: Key('widget-2'),
            onClickAttribute: 'some "messy" onClick',
          ),
          Form(
            key: Key('widget-3'),
            onClickAttribute: "some 'messy' onClick",
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(
        element1.getAttribute('onclick'),
        equals('some onClick'),
      );

      expect(
        element2.getAttribute('onclick'),
        equals('some "messy" onClick'),
      );

      expect(
        element3.getAttribute('onclick'),
        equals("some 'messy' onClick"),
      );
    });

    test('should set "click" event listener', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          Form(
            key: GlobalKey('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          Form(
            key: GlobalKey('el-2'),
            onClick: (event) => testStack.push('click-2'),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.element('el-1').dispatchEvent(Event('click'));
      app!.element('el-2').dispatchEvent(Event('click'));

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('click-1'));
        expect(testStack.popFromStart(), equals('click-2'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should set "click" event listener only if provided', () async {
      void listener(event) => {};

      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2'), onClick: null),
          Form(key: GlobalKey('el-3'), onClick: listener),
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

    test('should clear "click" event listner', () {
      void listener(event) => {};

      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2'), onClick: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(listener));

      // update

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      listeners1 = app!.widget('el-1').widgetEventListeners;
      listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(null));
    });

    test('should set style', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: Key('widget-1'), style: 'some style'),
          Form(key: Key('widget-2'), style: 'some "messy" style'),
          Form(key: Key('widget-3'), style: "some 'messy' style"),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(element1.getAttribute('style'), equals('some style'));
      expect(element2.getAttribute('style'), equals('some "messy" style'));
      expect(element3.getAttribute('style'), equals("some 'messy' style"));
    });

    test('should set tab index', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            key: Key('widget-1'),
            tabIndex: 1,
          ),
          Form(
            key: Key('widget-2'),
            tabIndex: 2,
          ),
          Form(
            key: Key('widget-3'),
            tabIndex: 3,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(element1.getAttribute('tabindex'), equals('1'));
      expect(element2.getAttribute('tabindex'), equals('2'));
      expect(element3.getAttribute('tabindex'), equals('3'));
    });

    test('should set title', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: Key('widget-1'), title: 'some title'),
          Form(key: Key('widget-2'), title: 'some "messy" title'),
          Form(key: Key('widget-3'), title: "some 'messy' title"),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;
      var element3 = RT_TestBed.rootElement.childNodes[2] as HtmlElement;

      expect(element1.getAttribute('title'), equals('some title'));
      expect(element2.getAttribute('title'), equals('some "messy" title'));
      expect(element3.getAttribute('title'), equals("some 'messy' title"));
    });

    test('should set correct types and markup', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('some-global-key')),
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
          ].contains('form')
              ? [
                  'input',
                ].contains('form')
                  // becuase system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<form'
                  : '<form>'
              : '<form></form>',
        ),
      );
    });

    test('should set data attributes', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something': 'something okay',
              'another': 'another okay',
            },
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;

      expect(element1.dataset['something'], equals('something okay'));
      expect(element1.dataset['another'], equals('another okay'));
    });

    test('should remove obsolute and add new data attributes on update', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something': 'something okay',
            },
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something-new': 'something new',
            },
          ),
        ],
        updateType: UpdateType.undefined,
        parentContext: app!.appContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0].childNodes[0];

      element1 as HtmlElement;

      expect(element1.dataset['something'], equals(null));
      expect(element1.dataset['something-new'], equals('something new'));
    });

    test('should not override system reserved data attributes on build', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something': 'something okay',
              Constants.attrWidgetType: "must ignore",
            },
          ),
        ],
        parentContext: app!.appContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0].childNodes[0];

      element1 as HtmlElement;

      expect(element1.dataset['something'], equals('something okay'));

      expect(element1.dataset[Constants.attrWidgetType], equals(null));
    });

    test('should not remove system reserved data attributes on update', () {
      app!.framework.buildChildren(
        widgets: [
          Form(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something': 'something okay',
              Constants.attrWidgetType: "must ignore",
            },
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something': 'something new',
              'something-diff': 'something diff',
              Constants.attrWidgetType: "must ignore",
            },
          ),
        ],
        updateType: UpdateType.undefined,
        parentContext: app!.appContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0].childNodes[0];

      element1 as HtmlElement;

      expect(element1.dataset['something'], equals('something new'));
      expect(element1.dataset['something-diff'], equals('something diff'));
      expect(element1.dataset[Constants.attrWidgetType], equals(null));
    });

    test('should set key', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: Key('some-key')),
          Form(key: LocalKey('some-local-key')),
          Form(key: GlobalKey('some-global-key')),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = app!.services.walker.getWidgetObjectUsingKey(
        app!.services.keyGen
            .getGlobalKeyUsingKey(Key('some-key'), RT_TestBed.rootContext)
            .value,
      );

      var element2 = app!.services.walker.getWidgetObjectUsingKey(
        app!.services.keyGen
            .getGlobalKeyUsingKey(
                LocalKey('some-local-key'), RT_TestBed.rootContext)
            .value,
      );

      var element3 = app!.services.walker.getWidgetObjectUsingKey(
        app!.services.keyGen
            .getGlobalKeyUsingKey(
                GlobalKey('some-global-key'), RT_TestBed.rootContext)
            .value,
      );

      expect(element1!.context.key.value, endsWith('some-key'));
      expect(element2!.context.key.value, endsWith('some-local-key'));
      expect(element3!.context.key.value, equals('some-global-key'));
    });

    test('should set attribute "name"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), name: 'some-name'),
          Form(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('name'), equals('some-name'));
      expect(element2.getAttribute('name'), equals('another-name'));
    });

    test('should update attribute "name"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), name: 'some-name'),
          Form(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), name: 'updated-name'),
          Form(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('name'), equals('updated-name'));
      expect(element2.getAttribute('name'), equals('another-name'));
    });

    test('should clear attribute "name"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('name'), equals(null));
      expect(element2.getAttribute('name'), equals(null));
    });

    test('should clear attribute "name" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), name: 'some-name'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), name: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('name'), equals(null));
    });

    test('should not set attribute "name" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), name: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('name'), equals(null));
    });

    test('should set attribute "action"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), action: 'some-action'),
          Form(key: GlobalKey('el-2'), action: 'another-action'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('action'), equals('some-action'));
      expect(element2.getAttribute('action'), equals('another-action'));
    });

    test('should update attribute "action"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), action: 'some-action'),
          Form(key: GlobalKey('el-2'), action: 'another-action'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), action: 'updated-action'),
          Form(key: GlobalKey('el-2'), action: 'another-action'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('action'), equals('updated-action'));
      expect(element2.getAttribute('action'), equals('another-action'));
    });

    test('should clear attribute "action"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2'), action: 'another-action'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('action'), equals(null));
      expect(element2.getAttribute('action'), equals(null));
    });

    test('should clear attribute "action" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), action: 'some-action'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), action: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('action'), equals(null));
    });

    test('should not set attribute "action" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), action: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('action'), equals(null));
    });

    test('should set attribute "accept"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), accept: 'some-accept'),
          Form(key: GlobalKey('el-2'), accept: 'another-accept'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('accept'), equals('some-accept'));
      expect(element2.getAttribute('accept'), equals('another-accept'));
    });

    test('should update attribute "accept"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), accept: 'some-accept'),
          Form(key: GlobalKey('el-2'), accept: 'another-accept'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), accept: 'updated-accept'),
          Form(key: GlobalKey('el-2'), accept: 'another-accept'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('accept'), equals('updated-accept'));
      expect(element2.getAttribute('accept'), equals('another-accept'));
    });

    test('should clear attribute "accept"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2'), accept: 'another-accept'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('accept'), equals(null));
      expect(element2.getAttribute('accept'), equals(null));
    });

    test('should clear attribute "accept" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), accept: 'some-accept'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), accept: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('accept'), equals(null));
    });

    test('should not set attribute "accept" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), accept: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('accept'), equals(null));
    });

    test('should set attribute "target"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), target: 'some-target'),
          Form(key: GlobalKey('el-2'), target: 'another-target'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('target'), equals('some-target'));
      expect(element2.getAttribute('target'), equals('another-target'));
    });

    test('should update attribute "target"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), target: 'some-target'),
          Form(key: GlobalKey('el-2'), target: 'another-target'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), target: 'updated-target'),
          Form(key: GlobalKey('el-2'), target: 'another-target'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('target'), equals('updated-target'));
      expect(element2.getAttribute('target'), equals('another-target'));
    });

    test('should clear attribute "target"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2'), target: 'another-target'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('target'), equals(null));
      expect(element2.getAttribute('target'), equals(null));
    });

    test('should clear attribute "target" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), target: 'some-target'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), target: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('target'), equals(null));
    });

    test('should not set attribute "target" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), target: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('target'), equals(null));
    });

    test('should set form attribute "method"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), method: FormMethod.get),
          Form(key: GlobalKey('el-2'), method: FormMethod.post),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(
        element1.getAttribute('method'),
        equals(fnMapFormMethod(FormMethod.get)),
      );
      expect(
        element2.getAttribute('method'),
        equals(fnMapFormMethod(FormMethod.post)),
      );
    });

    test('should update form attribute "method"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), method: FormMethod.get),
          Form(key: GlobalKey('el-2'), method: FormMethod.post),
          Form(key: GlobalKey('el-3'), method: FormMethod.get),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2'), method: null),
          Form(key: GlobalKey('el-3'), method: FormMethod.post),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');

      expect(
        element1.getAttribute('method'),
        equals(null),
      );
      expect(
        element2.getAttribute('method'),
        equals(null),
      );
      expect(
        element3.getAttribute('method'),
        equals(fnMapFormMethod(FormMethod.post)),
      );
    });

    test('should set form attribute "enctype"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), enctype: FormEncType.textPlain),
          Form(key: GlobalKey('el-2'), enctype: FormEncType.multipartFormData),
          Form(
            key: GlobalKey('el-3'),
            enctype: FormEncType.applicationXwwwFormUrlEncoded,
          ),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');

      expect(
        element1.getAttribute('enctype'),
        equals(fnMapFormEncType(FormEncType.textPlain)),
      );
      expect(
        element2.getAttribute('enctype'),
        equals(fnMapFormEncType(FormEncType.multipartFormData)),
      );
      expect(
        element3.getAttribute('enctype'),
        equals(fnMapFormEncType(FormEncType.applicationXwwwFormUrlEncoded)),
      );
    });

    test('should update form attribute "enctype"', () {
      app!.framework.buildChildren(
        widgets: [
          Form(key: GlobalKey('el-1'), enctype: FormEncType.textPlain),
          Form(key: GlobalKey('el-2'), enctype: FormEncType.multipartFormData),
          Form(
            key: GlobalKey('el-3'),
            enctype: FormEncType.applicationXwwwFormUrlEncoded,
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Form(key: GlobalKey('el-1')),
          Form(key: GlobalKey('el-2'), enctype: null),
          Form(key: GlobalKey('el-3'), enctype: FormEncType.multipartFormData),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');

      expect(element1.getAttribute('enctype'), equals(null));
      expect(element2.getAttribute('enctype'), equals(null));

      expect(
        element3.getAttribute('enctype'),
        equals(fnMapFormEncType(FormEncType.multipartFormData)),
      );
    });
  });
}
