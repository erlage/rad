// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '_html_tests_index_test.dart';

void html_input_test() {
  group('HTML Input tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: Key('some-key'), id: 'some-id'),
          Input(key: LocalKey('some-local-key'), id: 'some-local-id'),
          Input(key: GlobalKey('some-global-key'), id: 'some-global-id'),
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
          Input(key: Key('some-key'), id: 'some-id'),
          Input(key: LocalKey('some-local-key'), id: 'some-local-id'),
          Input(key: GlobalKey('some-global-key'), id: 'some-global-id'),
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
          Input(
            key: Key('some-key'),
            id: 'some-updated-id',
          ),
          Input(
            key: LocalKey('some-local-key'),
            id: 'some-local-updated-id',
          ),
          Input(
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
          Input(
            id: 'widget-1',
            child: Input(
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
          Input(id: 'widget-1', children: [
            Input(
              id: 'widget-2',
            ),
            Input(
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
          Input(
            id: 'widget-1',
            classAttribute: 'some class',
          ),
          Input(
            id: 'widget-2',
            classAttribute: 'some "messy" class',
          ),
          Input(
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
          Input(
            key: Key('widget-1'),
            contenteditable: false,
          ),
          Input(
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
          Input(
            key: Key('widget-1'),
            draggable: false,
          ),
          Input(
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

    test('should set hidden', () {
      app!.framework.buildChildren(
        widgets: [
          Input(
            key: Key('widget-1'),
            hidden: false,
          ),
          Input(
            key: Key('widget-2'),
            hidden: true,
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;
      var element2 = RT_TestBed.rootElement.childNodes[1] as HtmlElement;

      expect(element1.hidden, equals(false));
      expect(element2.hidden, equals(true));
    });

    test('should set inner text', () {
      app!.framework.buildChildren(
        widgets: [
          Input(
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

    test('should set onClick', () {
      app!.framework.buildChildren(
        widgets: [
          Input(
            key: Key('widget-1'),
            onClickAttribute: 'some onClick',
          ),
          Input(
            key: Key('widget-2'),
            onClickAttribute: 'some "messy" onClick',
          ),
          Input(
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

    test('should set onclick event listener', () {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          Input(
            key: GlobalKey('some-global-key'),
            onClick: (event) => testStack.push('clicked'),
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var element1 = RT_TestBed.rootElement.childNodes[0] as HtmlElement;

      element1
        ..click()
        ..click();

      expect(testStack.popFromStart(), equals('clicked'));
      expect(testStack.popFromStart(), equals('clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should set onclick nested event listeners', () {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          Input(
            key: GlobalKey('parent'),
            onClick: (event) {
              testStack.push('parent clicked');
            },
            children: [
              Input(
                key: GlobalKey('child'),
                onClick: (event) {
                  testStack.push('child clicked');
                },
              ),
            ],
          )
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var parent = app!.element('parent');
      var child = app!.element('child');

      child.click();
      parent.click();

      expect(testStack.popFromStart(), equals('child clicked'));
      expect(testStack.popFromStart(), equals('parent clicked'));
      expect(testStack.popFromStart(), equals('parent clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should set onclick nested event listeners: bubbling test', () {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          Input(
            key: GlobalKey('parent'),
            onClick: (event) {
              testStack.push('parent clicked');
            },
            children: [
              Input(
                key: GlobalKey('child'),
                onClick: (event) {
                  event.stopPropagation();

                  testStack.push('child clicked');
                },
              ),
            ],
          )
        ],
        parentContext: RT_TestBed.rootContext,
      );

      var parent = app!.element('parent');
      var child = app!.element('child');

      child.click();
      parent.click();

      expect(testStack.popFromStart(), equals('child clicked'));
      expect(testStack.popFromStart(), equals('parent clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should set style', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: Key('widget-1'), style: 'some style'),
          Input(key: Key('widget-2'), style: 'some "messy" style'),
          Input(key: Key('widget-3'), style: "some 'messy' style"),
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
          Input(
            key: Key('widget-1'),
            tabIndex: 1,
          ),
          Input(
            key: Key('widget-2'),
            tabIndex: 2,
          ),
          Input(
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
          Input(key: Key('widget-1'), title: 'some title'),
          Input(key: Key('widget-2'), title: 'some "messy" title'),
          Input(key: Key('widget-3'), title: "some 'messy' title"),
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
          Input(key: GlobalKey('some-global-key')),
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

    test('should set data attributes', () {
      app!.framework.buildChildren(
        widgets: [
          Input(
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
          Input(
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
          Input(
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
          Input(
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
          Input(
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
          Input(
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
          Input(key: Key('some-key')),
          Input(key: LocalKey('some-local-key')),
          Input(key: GlobalKey('some-global-key')),
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
          Input(key: GlobalKey('el-1'), name: 'some-name'),
          Input(key: GlobalKey('el-2'), name: 'another-name'),
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
          Input(key: GlobalKey('el-1'), name: 'some-name'),
          Input(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), name: 'updated-name'),
          Input(key: GlobalKey('el-2'), name: 'another-name'),
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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
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
          Input(key: GlobalKey('el-1'), name: 'some-name'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), name: null),
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
          Input(key: GlobalKey('el-1'), name: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('name'), equals(null));
    });

    test('should set attribute "value"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: 'some-value'),
          Input(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('value'), equals('some-value'));
      expect(element2.getAttribute('value'), equals('another-value'));
    });

    test('should update attribute "value"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: 'some-value'),
          Input(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: 'updated-value'),
          Input(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('value'), equals('updated-value'));
      expect(element2.getAttribute('value'), equals('another-value'));
    });

    test('should clear attribute "value"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('value'), equals(null));
      expect(element2.getAttribute('value'), equals(null));
    });

    test('should clear attribute "value" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: 'some-value'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('value'), equals(null));
    });

    test('should not set attribute "value" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('value'), equals(null));
    });

    test('should set attribute "accept"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), accept: 'some-accept'),
          Input(key: GlobalKey('el-2'), accept: 'another-accept'),
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
          Input(key: GlobalKey('el-1'), accept: 'some-accept'),
          Input(key: GlobalKey('el-2'), accept: 'another-accept'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), accept: 'updated-accept'),
          Input(key: GlobalKey('el-2'), accept: 'another-accept'),
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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), accept: 'another-accept'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
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
          Input(key: GlobalKey('el-1'), accept: 'some-accept'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), accept: null),
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
          Input(key: GlobalKey('el-1'), accept: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('accept'), equals(null));
    });

    test('should set attribute "minLength"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), minLength: 10),
          Input(key: GlobalKey('el-2'), minLength: 0),
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
          Input(key: GlobalKey('el-1'), minLength: 10),
          Input(key: GlobalKey('el-2'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), minLength: 20),
          Input(key: GlobalKey('el-2'), minLength: 20),
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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
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
          Input(key: GlobalKey('el-1'), minLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), minLength: null),
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
          Input(key: GlobalKey('el-1'), minLength: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('minlength'), equals(null));
    });

    test('should set attribute "maxLength"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), maxLength: 10),
          Input(key: GlobalKey('el-2'), maxLength: 0),
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
          Input(key: GlobalKey('el-1'), maxLength: 10),
          Input(key: GlobalKey('el-2'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), maxLength: 20),
          Input(key: GlobalKey('el-2'), maxLength: 20),
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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
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
          Input(key: GlobalKey('el-1'), maxLength: 10),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), maxLength: null),
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
          Input(key: GlobalKey('el-1'), maxLength: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('maxlength'), equals(null));
    });

    test('should set attribute "pattern"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: 'some-pattern'),
          Input(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('pattern'), equals('some-pattern'));
      expect(element2.getAttribute('pattern'), equals('another-pattern'));
    });

    test('should update attribute "pattern"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: 'some-pattern'),
          Input(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: 'updated-pattern'),
          Input(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('pattern'), equals('updated-pattern'));
      expect(element2.getAttribute('pattern'), equals('another-pattern'));
    });

    test('should clear attribute "pattern"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');

      expect(element1.getAttribute('pattern'), equals(null));
      expect(element2.getAttribute('pattern'), equals(null));
    });

    test('should clear attribute "pattern" if updated value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: 'some-pattern'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: null),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('pattern'), equals(null));
    });

    test('should not set attribute "pattern" if provided value is null', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('pattern'), equals(null));
    });

    test('should set attribute "placeholder"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
          Input(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
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
          Input(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
          Input(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), placeholder: 'updated-placeholder'),
          Input(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
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
          Input(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), placeholder: null),
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
          Input(key: GlobalKey('el-1'), placeholder: null),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');

      expect(element1.getAttribute('placeholder'), equals(null));
    });

    test('should set attribute "multiple" only if its true', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), multiple: false),
          Input(key: GlobalKey('el-2'), multiple: null),
          Input(key: GlobalKey('el-3'), multiple: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');

      expect(element1.getAttribute('multiple'), equals(null));
      expect(element2.getAttribute('multiple'), equals(null));
      expect(element3.getAttribute('multiple'), equals('true'));
    });

    test('should clear attribute "multiple" if updated value is not true', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), multiple: true),
          Input(key: GlobalKey('el-2'), multiple: true),
          Input(key: GlobalKey('el-3'), multiple: true),
          Input(key: GlobalKey('el-4'), multiple: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), multiple: true),
          Input(key: GlobalKey('el-2'), multiple: false),
          Input(key: GlobalKey('el-3'), multiple: null),
          Input(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');
      var element4 = app!.element('el-4');

      expect(element1.getAttribute('multiple'), equals('true'));
      expect(element2.getAttribute('multiple'), equals(null));
      expect(element3.getAttribute('multiple'), equals(null));
      expect(element4.getAttribute('multiple'), equals(null));
    });

    test('should set attribute "required" only if its true', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), required: false),
          Input(key: GlobalKey('el-2'), required: null),
          Input(key: GlobalKey('el-3'), required: true),
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
          Input(key: GlobalKey('el-1'), required: true),
          Input(key: GlobalKey('el-2'), required: true),
          Input(key: GlobalKey('el-3'), required: true),
          Input(key: GlobalKey('el-4'), required: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), required: true),
          Input(key: GlobalKey('el-2'), required: false),
          Input(key: GlobalKey('el-3'), required: null),
          Input(key: GlobalKey('el-4')),
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
          Input(key: GlobalKey('el-1'), readOnly: false),
          Input(key: GlobalKey('el-2'), readOnly: null),
          Input(key: GlobalKey('el-3'), readOnly: true),
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
          Input(key: GlobalKey('el-1'), readOnly: true),
          Input(key: GlobalKey('el-2'), readOnly: true),
          Input(key: GlobalKey('el-3'), readOnly: true),
          Input(key: GlobalKey('el-4'), readOnly: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), readOnly: true),
          Input(key: GlobalKey('el-2'), readOnly: false),
          Input(key: GlobalKey('el-3'), readOnly: null),
          Input(key: GlobalKey('el-4')),
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
          Input(key: GlobalKey('el-1'), disabled: false),
          Input(key: GlobalKey('el-2'), disabled: null),
          Input(key: GlobalKey('el-3'), disabled: true),
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
          Input(key: GlobalKey('el-1'), disabled: true),
          Input(key: GlobalKey('el-2'), disabled: true),
          Input(key: GlobalKey('el-3'), disabled: true),
          Input(key: GlobalKey('el-4'), disabled: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), disabled: true),
          Input(key: GlobalKey('el-2'), disabled: false),
          Input(key: GlobalKey('el-3'), disabled: null),
          Input(key: GlobalKey('el-4')),
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

    test('should set attribute "checked" only if its true', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), checked: false),
          Input(key: GlobalKey('el-2'), checked: null),
          Input(key: GlobalKey('el-3'), checked: true),
        ],
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');

      expect(element1.getAttribute('checked'), equals(null));
      expect(element2.getAttribute('checked'), equals(null));
      expect(element3.getAttribute('checked'), equals('true'));
    });

    test('should clear attribute "checked" if updated value is not true', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), checked: true),
          Input(key: GlobalKey('el-2'), checked: true),
          Input(key: GlobalKey('el-3'), checked: true),
          Input(key: GlobalKey('el-4'), checked: true),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), checked: true),
          Input(key: GlobalKey('el-2'), checked: false),
          Input(key: GlobalKey('el-3'), checked: null),
          Input(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      var element1 = app!.element('el-1');
      var element2 = app!.element('el-2');
      var element3 = app!.element('el-3');
      var element4 = app!.element('el-4');

      expect(element1.getAttribute('checked'), equals('true'));
      expect(element2.getAttribute('checked'), equals(null));
      expect(element3.getAttribute('checked'), equals(null));
      expect(element4.getAttribute('checked'), equals(null));
    });

    test('should set input attribute "type"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), type: null),
          Input(key: GlobalKey('el-3'), type: InputType.text),
          Input(key: GlobalKey('el-4'), type: InputType.password),
          Input(key: GlobalKey('el-5'), type: InputType.radio),
          Input(key: GlobalKey('el-6'), type: InputType.checkbox),
          Input(key: GlobalKey('el-7'), type: InputType.submit),
          Input(key: GlobalKey('el-8'), type: InputType.file),
        ],
        parentContext: app!.appContext,
      );

      expect(app!.element('el-1').getAttribute('type'), equals(null));
      expect(app!.element('el-2').getAttribute('type'), equals(null));
      expect(app!.element('el-3').getAttribute('type'), equals('text'));
      expect(app!.element('el-4').getAttribute('type'), equals('password'));
      expect(app!.element('el-5').getAttribute('type'), equals('radio'));
      expect(app!.element('el-6').getAttribute('type'), equals('checkbox'));
      expect(app!.element('el-7').getAttribute('type'), equals('submit'));
      expect(app!.element('el-8').getAttribute('type'), equals('file'));
    });

    test('should update form attribute "type"', () {
      app!.framework.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), type: null),
          Input(key: GlobalKey('el-3'), type: InputType.text),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), type: InputType.text),
          Input(key: GlobalKey('el-2'), type: null),
          Input(key: GlobalKey('el-3')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      expect(app!.element('el-1').getAttribute('type'), equals('text'));
      expect(app!.element('el-2').getAttribute('type'), equals(null));
      expect(app!.element('el-3').getAttribute('type'), equals(null));
    });
  });
}