// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '_html_tests_index_test.dart';

void html_image_test() {
  group('HTML Image tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: Key('some-key'), id: 'some-id'),
          Image(key: LocalKey('some-local-key'), id: 'some-local-id'),
          Image(key: GlobalKey('some-global-key'), id: 'some-global-id'),
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
          Image(key: Key('some-key'), id: 'some-id'),
          Image(key: LocalKey('some-local-key'), id: 'some-local-id'),
          Image(key: GlobalKey('some-global-key'), id: 'some-global-id'),
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
          Image(
            key: Key('some-key'),
            id: 'some-updated-id',
          ),
          Image(
            key: LocalKey('some-local-key'),
            id: 'some-local-updated-id',
          ),
          Image(
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
          Image(
            id: 'widget-1',
            child: Image(
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
          Image(id: 'widget-1', children: [
            Image(
              id: 'widget-2',
            ),
            Image(
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
          Image(
            id: 'widget-1',
            classAttribute: 'some class',
          ),
          Image(
            id: 'widget-2',
            classAttribute: 'some "messy" class',
          ),
          Image(
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
          Image(
            key: Key('widget-1'),
            contenteditable: false,
          ),
          Image(
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
          Image(
            key: Key('widget-1'),
            draggable: false,
          ),
          Image(
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
          Image(key: GlobalKey('el-1'), hidden: false),
          Image(key: GlobalKey('el-2'), hidden: null),
          Image(key: GlobalKey('el-3'), hidden: true),
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
          Image(key: GlobalKey('el-1'), hidden: true),
          Image(key: GlobalKey('el-2'), hidden: true),
          Image(key: GlobalKey('el-3'), hidden: true),
          Image(key: GlobalKey('el-4'), hidden: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), hidden: true),
          Image(key: GlobalKey('el-2'), hidden: false),
          Image(key: GlobalKey('el-3'), hidden: null),
          Image(key: GlobalKey('el-4')),
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
          Image(
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
      'chrome': Skip('Failing for img on chrome'),
    });

    test('should set onClick', () {
      app!.framework.buildChildren(
        widgets: [
          Image(
            key: Key('widget-1'),
            onClickAttribute: 'some onClick',
          ),
          Image(
            key: Key('widget-2'),
            onClickAttribute: 'some "messy" onClick',
          ),
          Image(
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
          Image(
            key: GlobalKey('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          Image(
            key: GlobalKey('el-2'),
            onClick: (event) => testStack.push('click-2'),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.element('el-1').dispatchEvent(Event('click'));
      app!.element('el-2').dispatchEvent(Event('click'));

      await Future.delayed(Duration(seconds: 1), () {
        expect(testStack.popFromStart(), equals('click-1'));
        expect(testStack.popFromStart(), equals('click-2'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should set "click" event listener only if provided', () async {
      void listener(event) => {};

      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2'), onClick: null),
          Image(key: GlobalKey('el-3'), onClick: listener),
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
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2'), onClick: listener),
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
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2')),
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
          Image(key: Key('widget-1'), style: 'some style'),
          Image(key: Key('widget-2'), style: 'some "messy" style'),
          Image(key: Key('widget-3'), style: "some 'messy' style"),
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
          Image(
            key: Key('widget-1'),
            tabIndex: 1,
          ),
          Image(
            key: Key('widget-2'),
            tabIndex: 2,
          ),
          Image(
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
          Image(key: Key('widget-1'), title: 'some title'),
          Image(key: Key('widget-2'), title: 'some "messy" title'),
          Image(key: Key('widget-3'), title: "some 'messy' title"),
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
          Image(key: GlobalKey('some-global-key')),
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
          ].contains('img')
              ? [
                  'input',
                ].contains('img')
                  // becuase system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<img'
                  : '<img>'
              : '<img></img>',
        ),
      );
    });

    test('should set data attributes', () {
      app!.framework.buildChildren(
        widgets: [
          Image(
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
          Image(
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
          Image(
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
          Image(
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
          Image(
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
          Image(
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
          Image(key: Key('some-key')),
          Image(key: LocalKey('some-local-key')),
          Image(key: GlobalKey('some-global-key')),
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

    test('should set attribute "src"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), src: 'some-src'),
          Image(key: GlobalKey('el-2'), src: 'another-src'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('src'), equals('some-src'));
      expect(element2.getAttribute('src'), equals('another-src'));
    });

    test('should update attribute "src"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), src: 'some-src'),
          Image(key: GlobalKey('el-2'), src: 'another-src'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), src: 'updated-src'),
          Image(key: GlobalKey('el-2'), src: 'another-src'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('src'), equals('updated-src'));
      expect(element2.getAttribute('src'), equals('another-src'));
    });

    test('should clear attribute "src"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2'), src: 'another-src'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('src'), equals(null));
      expect(element2.getAttribute('src'), equals(null));
    });

    test('should clear attribute "src" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), src: 'some-src'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), src: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('src'), equals(null));
    });

    test('should not set attribute "src" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), src: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('src'), equals(null));
    });

    test('should set attribute "alt"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), alt: 'some-alt'),
          Image(key: GlobalKey('el-2'), alt: 'another-alt'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('alt'), equals('some-alt'));
      expect(element2.getAttribute('alt'), equals('another-alt'));
    });

    test('should update attribute "alt"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), alt: 'some-alt'),
          Image(key: GlobalKey('el-2'), alt: 'another-alt'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), alt: 'updated-alt'),
          Image(key: GlobalKey('el-2'), alt: 'another-alt'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('alt'), equals('updated-alt'));
      expect(element2.getAttribute('alt'), equals('another-alt'));
    });

    test('should clear attribute "alt"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2'), alt: 'another-alt'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('alt'), equals(null));
      expect(element2.getAttribute('alt'), equals(null));
    });

    test('should clear attribute "alt" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), alt: 'some-alt'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), alt: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('alt'), equals(null));
    });

    test('should not set attribute "alt" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), alt: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('alt'), equals(null));
    });

    test('should set attribute "width"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), width: 'some-width'),
          Image(key: GlobalKey('el-2'), width: 'another-width'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('width'), equals('some-width'));
      expect(element2.getAttribute('width'), equals('another-width'));
    });

    test('should update attribute "width"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), width: 'some-width'),
          Image(key: GlobalKey('el-2'), width: 'another-width'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), width: 'updated-width'),
          Image(key: GlobalKey('el-2'), width: 'another-width'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('width'), equals('updated-width'));
      expect(element2.getAttribute('width'), equals('another-width'));
    });

    test('should clear attribute "width"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2'), width: 'another-width'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('width'), equals(null));
      expect(element2.getAttribute('width'), equals(null));
    });

    test('should clear attribute "width" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), width: 'some-width'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), width: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('width'), equals(null));
    });

    test('should not set attribute "width" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), width: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('width'), equals(null));
    });

    test('should set attribute "height"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), height: 'some-height'),
          Image(key: GlobalKey('el-2'), height: 'another-height'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('height'), equals('some-height'));
      expect(element2.getAttribute('height'), equals('another-height'));
    });

    test('should update attribute "height"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), height: 'some-height'),
          Image(key: GlobalKey('el-2'), height: 'another-height'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), height: 'updated-height'),
          Image(key: GlobalKey('el-2'), height: 'another-height'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('height'), equals('updated-height'));
      expect(element2.getAttribute('height'), equals('another-height'));
    });

    test('should clear attribute "height"', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2'), height: 'another-height'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1')),
          Image(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('height'), equals(null));
      expect(element2.getAttribute('height'), equals(null));
    });

    test('should clear attribute "height" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), height: 'some-height'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), height: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('height'), equals(null));
    });

    test('should not set attribute "height" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Image(key: GlobalKey('el-1'), height: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('height'), equals(null));
    });
  });
}
