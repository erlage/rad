// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '_html_tests_index_test.dart';

void html_input_text_test() {
  group('HTML InputText tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('some-key'), id: 'some-id'),
          InputText(key: LocalKey('some-local-key'), id: 'some-local-id'),
          InputText(key: GlobalKey('some-global-key'), id: 'some-global-id'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = app!.elementByKey('some-key', RT_TestBed.rootContext);
      var element2 = app!.elementByLocalKey('some-local-key');
      var element3 = app!.elementByGlobalKey('some-global-key');

      expect(element1.id, endsWith('some-id'));
      expect(element2.id, endsWith('some-local-id'));
      expect(element3.id, equals('some-global-id'));
    });

    test('should reset and update id', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('some-key'), id: 'some-id'),
          InputText(key: LocalKey('some-local-key'), id: 'some-local-id'),
          InputText(key: GlobalKey('some-global-key'), id: 'some-global-id'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByKey('some-key', app!.appContext);
      var element2 = app!.elementByLocalKey('some-local-key');
      var element3 = app!.elementByGlobalKey('some-global-key');

      expect(element1.id, endsWith('some-id'));
      expect(element2.id, endsWith('some-local-id'));
      expect(element3.id, equals('some-global-id'));

      await app!.updateChildren(
        widgets: [
          InputText(
            key: Key('some-key'),
            id: 'some-updated-id',
          ),
          InputText(
            key: LocalKey('some-local-key'),
            id: 'some-local-updated-id',
          ),
          InputText(
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

    test('should set child widget', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            id: 'widget-1',
            child: InputText(
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

    test('should set children widgets', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            id: 'widget-1',
            children: [
              InputText(
                id: 'widget-2',
              ),
              InputText(
                id: 'widget-3',
              ),
            ],
          ),
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

    test('should set classes', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            id: 'widget-1',
            classAttribute: 'some class',
          ),
          InputText(
            id: 'widget-2',
            classAttribute: 'some "messy" class',
          ),
          InputText(
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

    test('should set contenteditable', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            contenteditable: false,
          ),
          InputText(
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

    test('should set draggable', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            draggable: false,
          ),
          InputText(
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

    test('should set attribute "hidden" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), hidden: false),
          InputText(key: GlobalKey('el-2'), hidden: null),
          InputText(key: GlobalKey('el-3'), hidden: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');
      var element3 = app!.elementByGlobalKey('el-3');

      expect(element1.getAttribute('hidden'), equals(null));
      expect(element2.getAttribute('hidden'), equals(null));
      expect(element3.getAttribute('hidden'), equals('true'));
    });

    test('should clear attribute "hidden" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), hidden: true),
          InputText(key: GlobalKey('el-2'), hidden: true),
          InputText(key: GlobalKey('el-3'), hidden: true),
          InputText(key: GlobalKey('el-4'), hidden: true),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), hidden: true),
          InputText(key: GlobalKey('el-2'), hidden: false),
          InputText(key: GlobalKey('el-3'), hidden: null),
          InputText(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');
      var element3 = app!.elementByGlobalKey('el-3');
      var element4 = app!.elementByGlobalKey('el-4');

      expect(element1.getAttribute('hidden'), equals('true'));
      expect(element2.getAttribute('hidden'), equals(null));
      expect(element3.getAttribute('hidden'), equals(null));
      expect(element4.getAttribute('hidden'), equals(null));
    });

    test('should set inner text', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
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
    }, onPlatform: {
      'chrome': Skip('Failing for input on chrome'),
    });

    test('should set onClick', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            onClickAttribute: 'some onClick',
          ),
          InputText(
            key: Key('widget-2'),
            onClickAttribute: 'some "messy" onClick',
          ),
          InputText(
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

      await app!.buildChildren(
        widgets: [
          InputText(
            key: GlobalKey('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          InputText(
            key: GlobalKey('el-2'),
            onClick: (event) => testStack.push('click-2'),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('el-1').dispatchEvent(Event('click'));
      app!.elementByGlobalKey('el-2').dispatchEvent(Event('click'));

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
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onClick: null),
          InputText(key: GlobalKey('el-3'), onClick: listener),
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
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onClick: listener),
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
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
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
          InputText(key: Key('widget-1'), style: 'some style'),
          InputText(key: Key('widget-2'), style: 'some "messy" style'),
          InputText(key: Key('widget-3'), style: "some 'messy' style"),
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

    test('should set tab index', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            tabIndex: 1,
          ),
          InputText(
            key: Key('widget-2'),
            tabIndex: 2,
          ),
          InputText(
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

    test('should set title', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('widget-1'), title: 'some title'),
          InputText(key: Key('widget-2'), title: 'some "messy" title'),
          InputText(key: Key('widget-3'), title: "some 'messy' title"),
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

    test('should set correct types and markup', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('some-global-key')),
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
          ].contains('input')
              ? [
                  'input',
                ].contains('input')
                  // becuase system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<input'
                  : '<input>'
              : '<input></input>',
        ),
      );
    });

    test('should set data attributes', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
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

    test('should remove obsolute and add new data attributes on update',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(
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
          InputText(
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

    test('should not override system reserved data attributes on build',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something': 'something okay',
              Constants.attrWidgetType: 'must ignore',
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

    test('should not remove system reserved data attributes on update',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something': 'something okay',
              Constants.attrWidgetType: 'must ignore',
            },
          ),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(
            key: GlobalKey('some-global-key'),
            dataAttributes: {
              'something': 'something new',
              'something-diff': 'something diff',
              Constants.attrWidgetType: 'must ignore',
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

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('some-key')),
          InputText(key: LocalKey('some-local-key')),
          InputText(key: GlobalKey('some-global-key')),
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
          InputText(key: GlobalKey('el-1'), name: 'some-name'),
          InputText(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('name'), equals('some-name'));
      expect(element2.getAttribute('name'), equals('another-name'));
    });

    test('should update attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), name: 'some-name'),
          InputText(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), name: 'updated-name'),
          InputText(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('name'), equals('updated-name'));
      expect(element2.getAttribute('name'), equals('another-name'));
    });

    test('should clear attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('name'), equals(null));
      expect(element2.getAttribute('name'), equals(null));
    });

    test('should clear attribute "name" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), name: 'some-name'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), name: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('name'), equals(null));
    });

    test('should not set attribute "name" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), name: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('name'), equals(null));
    });

    test('should set attribute "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), value: 'some-value'),
          InputText(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('value'), equals('some-value'));
      expect(element2.getAttribute('value'), equals('another-value'));
    });

    test('should update attribute "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), value: 'some-value'),
          InputText(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), value: 'updated-value'),
          InputText(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('value'), equals('updated-value'));
      expect(element2.getAttribute('value'), equals('another-value'));
    });

    test('should clear attribute "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('value'), equals(null));
      expect(element2.getAttribute('value'), equals(null));
    });

    test('should clear attribute "value" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), value: 'some-value'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), value: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('value'), equals(null));
    });

    test('should not set attribute "value" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), value: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('value'), equals(null));
    });

    test('should set attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), minLength: 10),
          InputText(key: GlobalKey('el-2'), minLength: 0),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('minlength'), equals('10'));
      expect(element2.getAttribute('minlength'), equals('0'));
    });

    test('should update attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), minLength: 10),
          InputText(key: GlobalKey('el-2'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), minLength: 20),
          InputText(key: GlobalKey('el-2'), minLength: 20),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('minlength'), equals('20'));
      expect(element2.getAttribute('minlength'), equals('20'));
    });

    test('should clear attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('minlength'), equals(null));
      expect(element2.getAttribute('minlength'), equals(null));
    });

    test('should clear attribute "minLength" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), minLength: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('minlength'), equals(null));
    });

    test('should not set attribute "minLength" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), minLength: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('minlength'), equals(null));
    });

    test('should set attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), maxLength: 10),
          InputText(key: GlobalKey('el-2'), maxLength: 0),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('maxlength'), equals('10'));
      expect(element2.getAttribute('maxlength'), equals('0'));
    });

    test('should update attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), maxLength: 10),
          InputText(key: GlobalKey('el-2'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), maxLength: 20),
          InputText(key: GlobalKey('el-2'), maxLength: 20),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('maxlength'), equals('20'));
      expect(element2.getAttribute('maxlength'), equals('20'));
    });

    test('should clear attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('maxlength'), equals(null));
      expect(element2.getAttribute('maxlength'), equals(null));
    });

    test('should clear attribute "maxLength" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), maxLength: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('maxlength'), equals(null));
    });

    test('should not set attribute "maxLength" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), maxLength: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('maxlength'), equals(null));
    });

    test('should set attribute "pattern"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), pattern: 'some-pattern'),
          InputText(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('pattern'), equals('some-pattern'));
      expect(element2.getAttribute('pattern'), equals('another-pattern'));
    });

    test('should update attribute "pattern"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), pattern: 'some-pattern'),
          InputText(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), pattern: 'updated-pattern'),
          InputText(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('pattern'), equals('updated-pattern'));
      expect(element2.getAttribute('pattern'), equals('another-pattern'));
    });

    test('should clear attribute "pattern"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('pattern'), equals(null));
      expect(element2.getAttribute('pattern'), equals(null));
    });

    test('should clear attribute "pattern" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), pattern: 'some-pattern'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), pattern: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('pattern'), equals(null));
    });

    test('should not set attribute "pattern" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), pattern: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('pattern'), equals(null));
    });

    test('should set attribute "placeholder"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
          InputText(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('placeholder'), equals('some-placeholder'));
      expect(
          element2.getAttribute('placeholder'), equals('another-placeholder'));
    });

    test('should update attribute "placeholder"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
          InputText(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), placeholder: 'updated-placeholder'),
          InputText(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(
          element1.getAttribute('placeholder'), equals('updated-placeholder'));
      expect(
          element2.getAttribute('placeholder'), equals('another-placeholder'));
    });

    test('should clear attribute "placeholder"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('placeholder'), equals(null));
      expect(element2.getAttribute('placeholder'), equals(null));
    });

    test('should clear attribute "placeholder" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), placeholder: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('placeholder'), equals(null));
    });

    test('should not set attribute "placeholder" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), placeholder: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');

      expect(element1.getAttribute('placeholder'), equals(null));
    });

    test('should set attribute "required" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), required: false),
          InputText(key: GlobalKey('el-2'), required: null),
          InputText(key: GlobalKey('el-3'), required: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');
      var element3 = app!.elementByGlobalKey('el-3');

      expect(element1.getAttribute('required'), equals(null));
      expect(element2.getAttribute('required'), equals(null));
      expect(element3.getAttribute('required'), equals('true'));
    });

    test('should clear attribute "required" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), required: true),
          InputText(key: GlobalKey('el-2'), required: true),
          InputText(key: GlobalKey('el-3'), required: true),
          InputText(key: GlobalKey('el-4'), required: true),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), required: true),
          InputText(key: GlobalKey('el-2'), required: false),
          InputText(key: GlobalKey('el-3'), required: null),
          InputText(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');
      var element3 = app!.elementByGlobalKey('el-3');
      var element4 = app!.elementByGlobalKey('el-4');

      expect(element1.getAttribute('required'), equals('true'));
      expect(element2.getAttribute('required'), equals(null));
      expect(element3.getAttribute('required'), equals(null));
      expect(element4.getAttribute('required'), equals(null));
    });

    test('should set attribute "readonly" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), readOnly: false),
          InputText(key: GlobalKey('el-2'), readOnly: null),
          InputText(key: GlobalKey('el-3'), readOnly: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');
      var element3 = app!.elementByGlobalKey('el-3');

      expect(element1.getAttribute('readonly'), equals(null));
      expect(element2.getAttribute('readonly'), equals(null));
      expect(element3.getAttribute('readonly'), equals('true'));
    });

    test('should clear attribute "readonly" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), readOnly: true),
          InputText(key: GlobalKey('el-2'), readOnly: true),
          InputText(key: GlobalKey('el-3'), readOnly: true),
          InputText(key: GlobalKey('el-4'), readOnly: true),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), readOnly: true),
          InputText(key: GlobalKey('el-2'), readOnly: false),
          InputText(key: GlobalKey('el-3'), readOnly: null),
          InputText(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');
      var element3 = app!.elementByGlobalKey('el-3');
      var element4 = app!.elementByGlobalKey('el-4');

      expect(element1.getAttribute('readonly'), equals('true'));
      expect(element2.getAttribute('readonly'), equals(null));
      expect(element3.getAttribute('readonly'), equals(null));
      expect(element4.getAttribute('readonly'), equals(null));
    });

    test('should set attribute "disabled" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), disabled: false),
          InputText(key: GlobalKey('el-2'), disabled: null),
          InputText(key: GlobalKey('el-3'), disabled: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');
      var element3 = app!.elementByGlobalKey('el-3');

      expect(element1.getAttribute('disabled'), equals(null));
      expect(element2.getAttribute('disabled'), equals(null));
      expect(element3.getAttribute('disabled'), equals('true'));
    });

    test('should clear attribute "disabled" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), disabled: true),
          InputText(key: GlobalKey('el-2'), disabled: true),
          InputText(key: GlobalKey('el-3'), disabled: true),
          InputText(key: GlobalKey('el-4'), disabled: true),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), disabled: true),
          InputText(key: GlobalKey('el-2'), disabled: false),
          InputText(key: GlobalKey('el-3'), disabled: null),
          InputText(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');
      var element3 = app!.elementByGlobalKey('el-3');
      var element4 = app!.elementByGlobalKey('el-4');

      expect(element1.getAttribute('disabled'), equals('true'));
      expect(element2.getAttribute('disabled'), equals(null));
      expect(element3.getAttribute('disabled'), equals(null));
      expect(element4.getAttribute('disabled'), equals(null));
    });

    test('should set correct input type if "isPassword" is set', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), isPassword: false),
          InputText(key: GlobalKey('el-2'), isPassword: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');

      expect(element1.getAttribute('type'), equals('text'));
      expect(element2.getAttribute('type'), equals('password'));
    });

    test('should update input type if "isPassword" is set', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), isPassword: false),
          InputText(key: GlobalKey('el-2'), isPassword: true),
          InputText(key: GlobalKey('el-3'), isPassword: true),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1'), isPassword: true),
          InputText(key: GlobalKey('el-2'), isPassword: false),
          InputText(key: GlobalKey('el-3')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.elementByGlobalKey('el-1');
      var element2 = app!.elementByGlobalKey('el-2');
      var element3 = app!.elementByGlobalKey('el-3');

      expect(element1.getAttribute('type'), equals('password'));
      expect(element2.getAttribute('type'), equals('text'));

      if ('$InputText' == 'InputText') {
        // InputText should set input type to text if user doesn't
        // set isPassword
        expect(element3.getAttribute('type'), equals('text'));
      }
    });

    test('should set "change" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputText(
            key: GlobalKey('el-1'),
            onChange: (event) => testStack.push('change-1'),
          ),
          InputText(
            key: GlobalKey('el-2'),
            onChange: (event) => testStack.push('change-2'),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('el-1').dispatchEvent(Event('change'));
      app!.elementByGlobalKey('el-2').dispatchEvent(Event('change'));

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('change-1'));
        expect(testStack.popFromStart(), equals('change-2'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should set "change" event listener only if provided', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onChange: null),
          InputText(key: GlobalKey('el-3'), onChange: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;
      var listeners3 = app!.widget('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.change], equals(null));
      expect(listeners2[DomEventType.change], equals(null));
      expect(listeners3[DomEventType.change], equals(listener));
    });

    test('should clear "change" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onChange: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.change], equals(null));
      expect(listeners2[DomEventType.change], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      listeners1 = app!.widget('el-1').widgetEventListeners;
      listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.change], equals(null));
      expect(listeners2[DomEventType.change], equals(null));
    });

    test('should set "input" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputText(
            key: GlobalKey('el-1'),
            onInput: (event) => testStack.push('input-1'),
          ),
          InputText(
            key: GlobalKey('el-2'),
            onInput: (event) => testStack.push('input-2'),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('el-1').dispatchEvent(Event('input'));
      app!.elementByGlobalKey('el-2').dispatchEvent(Event('input'));

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('input-1'));
        expect(testStack.popFromStart(), equals('input-2'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should set "input" event listener only if provided', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onInput: null),
          InputText(key: GlobalKey('el-3'), onInput: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;
      var listeners3 = app!.widget('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.input], equals(null));
      expect(listeners2[DomEventType.input], equals(null));
      expect(listeners3[DomEventType.input], equals(listener));
    });

    test('should clear "input" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onInput: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.input], equals(null));
      expect(listeners2[DomEventType.input], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      listeners1 = app!.widget('el-1').widgetEventListeners;
      listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.input], equals(null));
      expect(listeners2[DomEventType.input], equals(null));
    });

    test('should set "KeyPress" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputText(
            key: GlobalKey('el-1'),
            onKeyPress: (event) => testStack.push('keypress-1'),
          ),
          InputText(
            key: GlobalKey('el-2'),
            onKeyPress: (event) => testStack.push('keypress-2'),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('el-1').dispatchEvent(Event('keypress'));
      app!.elementByGlobalKey('el-2').dispatchEvent(Event('keypress'));

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('keypress-1'));
        expect(testStack.popFromStart(), equals('keypress-2'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should set "KeyPress" event listener only if provided', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onKeyPress: null),
          InputText(key: GlobalKey('el-3'), onKeyPress: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;
      var listeners3 = app!.widget('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.keyPress], equals(null));
      expect(listeners2[DomEventType.keyPress], equals(null));
      expect(listeners3[DomEventType.keyPress], equals(listener));
    });

    test('should clear "KeyPress" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onKeyPress: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyPress], equals(null));
      expect(listeners2[DomEventType.keyPress], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      listeners1 = app!.widget('el-1').widgetEventListeners;
      listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyPress], equals(null));
      expect(listeners2[DomEventType.keyPress], equals(null));
    });

    test('should set "KeyUp" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputText(
            key: GlobalKey('el-1'),
            onKeyUp: (event) => testStack.push('keyup-1'),
          ),
          InputText(
            key: GlobalKey('el-2'),
            onKeyUp: (event) => testStack.push('keyup-2'),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('el-1').dispatchEvent(Event('keyup'));
      app!.elementByGlobalKey('el-2').dispatchEvent(Event('keyup'));

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('keyup-1'));
        expect(testStack.popFromStart(), equals('keyup-2'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should set "KeyUp" event listener only if provided', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onKeyUp: null),
          InputText(key: GlobalKey('el-3'), onKeyUp: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;
      var listeners3 = app!.widget('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.keyUp], equals(null));
      expect(listeners2[DomEventType.keyUp], equals(null));
      expect(listeners3[DomEventType.keyUp], equals(listener));
    });

    test('should clear "KeyUp" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onKeyUp: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyUp], equals(null));
      expect(listeners2[DomEventType.keyUp], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      listeners1 = app!.widget('el-1').widgetEventListeners;
      listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyUp], equals(null));
      expect(listeners2[DomEventType.keyUp], equals(null));
    });

    test('should set "KeyDown" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputText(
            key: GlobalKey('el-1'),
            onKeyDown: (event) => testStack.push('keydown-1'),
          ),
          InputText(
            key: GlobalKey('el-2'),
            onKeyDown: (event) => testStack.push('keydown-2'),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('el-1').dispatchEvent(Event('keydown'));
      app!.elementByGlobalKey('el-2').dispatchEvent(Event('keydown'));

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('keydown-1'));
        expect(testStack.popFromStart(), equals('keydown-2'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should set "KeyDown" event listener only if provided', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onKeyDown: null),
          InputText(key: GlobalKey('el-3'), onKeyDown: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;
      var listeners3 = app!.widget('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.keyDown], equals(null));
      expect(listeners2[DomEventType.keyDown], equals(null));
      expect(listeners3[DomEventType.keyDown], equals(listener));
    });

    test('should clear "KeyDown" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2'), onKeyDown: listener),
        ],
        parentContext: app!.appContext,
      );

      var listeners1 = app!.widget('el-1').widgetEventListeners;
      var listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyDown], equals(null));
      expect(listeners2[DomEventType.keyDown], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputText(key: GlobalKey('el-1')),
          InputText(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      listeners1 = app!.widget('el-1').widgetEventListeners;
      listeners2 = app!.widget('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyDown], equals(null));
      expect(listeners2[DomEventType.keyDown], equals(null));
    });
  });
}
