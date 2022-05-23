// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '_html_tests_index_test.dart';

void html_text_area_test() {
  group('HTML TextArea tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: Key('some-key'), id: 'some-id'),
          TextArea(key: LocalKey('some-local-key'), id: 'some-local-id'),
          TextArea(key: GlobalKey('some-global-key'), id: 'some-global-id'),
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
          TextArea(key: Key('some-key'), id: 'some-id'),
          TextArea(key: LocalKey('some-local-key'), id: 'some-local-id'),
          TextArea(key: GlobalKey('some-global-key'), id: 'some-global-id'),
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

      expect(element1.id, endsWith('some-updated-id'));
      expect(element2.id, endsWith('some-local-updated-id'));
      expect(element3.id, equals('some-global-updated-id'));
    });

    test('should set child widget', () {
      app!.framework.buildChildren(
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

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = element1.childNodes[0] as HtmlElement;

      expect(element1.id, equals('widget-1'));
      expect(element2.id, equals('widget-2'));
    });

    test('should set children widgets', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(id: 'widget-1', children: [
            TextArea(
              id: 'widget-2',
            ),
            TextArea(
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
          TextArea(
            id: 'widget-1',
            classAttribute: 'some class',
          ),
          TextArea(
            id: 'widget-2',
            classAttribute: 'some "messy" class',
          ),
          TextArea(
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

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

      expect(element1.getAttribute('contenteditable'), equals('false'));
      expect(element2.getAttribute('contenteditable'), equals('true'));
    });

    test('should set draggable', () {
      app!.framework.buildChildren(
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

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

      expect(element1.getAttribute('draggable'), equals('false'));
      expect(element2.getAttribute('draggable'), equals('true'));
    });

    test('should set attribute "hidden" only if its true', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), hidden: false),
          TextArea(key: GlobalKey('el-2'), hidden: null),
          TextArea(key: GlobalKey('el-3'), hidden: true),
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
          TextArea(key: GlobalKey('el-1'), hidden: true),
          TextArea(key: GlobalKey('el-2'), hidden: true),
          TextArea(key: GlobalKey('el-3'), hidden: true),
          TextArea(key: GlobalKey('el-4'), hidden: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), hidden: true),
          TextArea(key: GlobalKey('el-2'), hidden: false),
          TextArea(key: GlobalKey('el-3'), hidden: null),
          TextArea(key: GlobalKey('el-4')),
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
          TextArea(
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

    test('should clear "click" event listner', () {
      void listener(event) => {};

      app!.framework.buildChildren(
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

      app!.framework.updateChildren(
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

    test('should set style', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: Key('widget-1'), style: 'some style'),
          TextArea(key: Key('widget-2'), style: 'some "messy" style'),
          TextArea(key: Key('widget-3'), style: "some 'messy' style"),
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
          TextArea(key: Key('widget-1'), title: 'some title'),
          TextArea(key: Key('widget-2'), title: 'some "messy" title'),
          TextArea(key: Key('widget-3'), title: "some 'messy' title"),
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

    test('should set data attributes', () {
      app!.framework.buildChildren(
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

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;

      expect(element1.dataset['something'], equals('something okay'));
      expect(element1.dataset['another'], equals('another okay'));
    });

    test('should remove obsolute and add new data attributes on update', () {
      app!.framework.buildChildren(
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

      app!.framework.updateChildren(
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

      var element1 = RT_TestBed.rootElement.childNodes[0].childNodes[0];

      element1 as HtmlElement;

      expect(element1.dataset['something'], equals(null));
      expect(element1.dataset['something-new'], equals('something new'));
    });

    test('should not override system reserved data attributes on build', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(
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
          TextArea(
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
          TextArea(
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
          TextArea(key: Key('some-key')),
          TextArea(key: LocalKey('some-local-key')),
          TextArea(key: GlobalKey('some-global-key')),
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
          TextArea(key: GlobalKey('el-1'), name: 'some-name'),
          TextArea(key: GlobalKey('el-2'), name: 'another-name'),
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
          TextArea(key: GlobalKey('el-1'), name: 'some-name'),
          TextArea(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), name: 'updated-name'),
          TextArea(key: GlobalKey('el-2'), name: 'another-name'),
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
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
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
          TextArea(key: GlobalKey('el-1'), name: 'some-name'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), name: null),
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
          TextArea(key: GlobalKey('el-1'), name: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('name'), equals(null));
    });

    test('should set attribute "placeholder"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
          TextArea(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('placeholder'), equals('some-placeholder'));
      expect(
          element2.getAttribute('placeholder'), equals('another-placeholder'));
    });

    test('should update attribute "placeholder"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
          TextArea(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: 'updated-placeholder'),
          TextArea(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(
          element1.getAttribute('placeholder'), equals('updated-placeholder'));
      expect(
          element2.getAttribute('placeholder'), equals('another-placeholder'));
    });

    test('should clear attribute "placeholder"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('placeholder'), equals(null));
      expect(element2.getAttribute('placeholder'), equals(null));
    });

    test('should clear attribute "placeholder" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('placeholder'), equals(null));
    });

    test('should not set attribute "placeholder" if provided value is null',
        () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), placeholder: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('placeholder'), equals(null));
    });

    test('should set attribute "rows"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: 10),
          TextArea(key: GlobalKey('el-2'), rows: 0),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('rows'), equals('10'));
      expect(element2.getAttribute('rows'), equals('0'));
    });

    test('should update attribute "rows"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: 10),
          TextArea(key: GlobalKey('el-2'), rows: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: 20),
          TextArea(key: GlobalKey('el-2'), rows: 20),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('rows'), equals('20'));
      expect(element2.getAttribute('rows'), equals('20'));
    });

    test('should clear attribute "rows"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), rows: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('rows'), equals(null));
      expect(element2.getAttribute('rows'), equals(null));
    });

    test('should clear attribute "rows" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('rows'), equals(null));
    });

    test('should not set attribute "rows" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), rows: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('rows'), equals(null));
    });

    test('should set attribute "cols"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: 10),
          TextArea(key: GlobalKey('el-2'), cols: 0),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('cols'), equals('10'));
      expect(element2.getAttribute('cols'), equals('0'));
    });

    test('should update attribute "cols"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: 10),
          TextArea(key: GlobalKey('el-2'), cols: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: 20),
          TextArea(key: GlobalKey('el-2'), cols: 20),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('cols'), equals('20'));
      expect(element2.getAttribute('cols'), equals('20'));
    });

    test('should clear attribute "cols"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), cols: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('cols'), equals(null));
      expect(element2.getAttribute('cols'), equals(null));
    });

    test('should clear attribute "cols" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('cols'), equals(null));
    });

    test('should not set attribute "cols" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), cols: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('cols'), equals(null));
    });

    test('should set attribute "minLength"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: 10),
          TextArea(key: GlobalKey('el-2'), minLength: 0),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('minlength'), equals('10'));
      expect(element2.getAttribute('minlength'), equals('0'));
    });

    test('should update attribute "minLength"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: 10),
          TextArea(key: GlobalKey('el-2'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: 20),
          TextArea(key: GlobalKey('el-2'), minLength: 20),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('minlength'), equals('20'));
      expect(element2.getAttribute('minlength'), equals('20'));
    });

    test('should clear attribute "minLength"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('minlength'), equals(null));
      expect(element2.getAttribute('minlength'), equals(null));
    });

    test('should clear attribute "minLength" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('minlength'), equals(null));
    });

    test('should not set attribute "minLength" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), minLength: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('minlength'), equals(null));
    });

    test('should set attribute "maxLength"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: 10),
          TextArea(key: GlobalKey('el-2'), maxLength: 0),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('maxlength'), equals('10'));
      expect(element2.getAttribute('maxlength'), equals('0'));
    });

    test('should update attribute "maxLength"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: 10),
          TextArea(key: GlobalKey('el-2'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: 20),
          TextArea(key: GlobalKey('el-2'), maxLength: 20),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('maxlength'), equals('20'));
      expect(element2.getAttribute('maxlength'), equals('20'));
    });

    test('should clear attribute "maxLength"', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1')),
          TextArea(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('maxlength'), equals(null));
      expect(element2.getAttribute('maxlength'), equals(null));
    });

    test('should clear attribute "maxLength" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('maxlength'), equals(null));
    });

    test('should not set attribute "maxLength" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), maxLength: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('maxlength'), equals(null));
    });

    test('should set attribute "required" only if its true', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), required: false),
          TextArea(key: GlobalKey('el-2'), required: null),
          TextArea(key: GlobalKey('el-3'), required: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');

      expect(element1.getAttribute('required'), equals(null));
      expect(element2.getAttribute('required'), equals(null));
      expect(element3.getAttribute('required'), equals('true'));
    });

    test('should clear attribute "required" if updated value is not true', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), required: true),
          TextArea(key: GlobalKey('el-2'), required: true),
          TextArea(key: GlobalKey('el-3'), required: true),
          TextArea(key: GlobalKey('el-4'), required: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), required: true),
          TextArea(key: GlobalKey('el-2'), required: false),
          TextArea(key: GlobalKey('el-3'), required: null),
          TextArea(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');
      var element4 = app!.element('el-4');

      expect(element1.getAttribute('required'), equals('true'));
      expect(element2.getAttribute('required'), equals(null));
      expect(element3.getAttribute('required'), equals(null));
      expect(element4.getAttribute('required'), equals(null));
    });

    test('should set attribute "readonly" only if its true', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), readOnly: false),
          TextArea(key: GlobalKey('el-2'), readOnly: null),
          TextArea(key: GlobalKey('el-3'), readOnly: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');

      expect(element1.getAttribute('readonly'), equals(null));
      expect(element2.getAttribute('readonly'), equals(null));
      expect(element3.getAttribute('readonly'), equals('true'));
    });

    test('should clear attribute "readonly" if updated value is not true', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), readOnly: true),
          TextArea(key: GlobalKey('el-2'), readOnly: true),
          TextArea(key: GlobalKey('el-3'), readOnly: true),
          TextArea(key: GlobalKey('el-4'), readOnly: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), readOnly: true),
          TextArea(key: GlobalKey('el-2'), readOnly: false),
          TextArea(key: GlobalKey('el-3'), readOnly: null),
          TextArea(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');
      var element4 = app!.element('el-4');

      expect(element1.getAttribute('readonly'), equals('true'));
      expect(element2.getAttribute('readonly'), equals(null));
      expect(element3.getAttribute('readonly'), equals(null));
      expect(element4.getAttribute('readonly'), equals(null));
    });

    test('should set attribute "disabled" only if its true', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), disabled: false),
          TextArea(key: GlobalKey('el-2'), disabled: null),
          TextArea(key: GlobalKey('el-3'), disabled: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');

      expect(element1.getAttribute('disabled'), equals(null));
      expect(element2.getAttribute('disabled'), equals(null));
      expect(element3.getAttribute('disabled'), equals('true'));
    });

    test('should clear attribute "disabled" if updated value is not true', () {
      app!.framework.buildChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), disabled: true),
          TextArea(key: GlobalKey('el-2'), disabled: true),
          TextArea(key: GlobalKey('el-3'), disabled: true),
          TextArea(key: GlobalKey('el-4'), disabled: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          TextArea(key: GlobalKey('el-1'), disabled: true),
          TextArea(key: GlobalKey('el-2'), disabled: false),
          TextArea(key: GlobalKey('el-3'), disabled: null),
          TextArea(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');
      var element4 = app!.element('el-4');

      expect(element1.getAttribute('disabled'), equals('true'));
      expect(element2.getAttribute('disabled'), equals(null));
      expect(element3.getAttribute('disabled'), equals(null));
      expect(element4.getAttribute('disabled'), equals(null));
    });
  });
}
