// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

void html_input_test() {
  group('HTML Input tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('some-key-1'), id: 'some-id-1'),
          Input(key: GlobalKey('some-key-2'), id: 'some-id-2'),
          Input(key: GlobalKey('some-key-3'), id: 'some-id-3'),
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
          Input(key: GlobalKey('some-key-1'), id: 'some-id-1'),
          Input(key: GlobalKey('some-key-2'), id: 'some-id-2'),
          Input(key: GlobalKey('some-key-3'), id: 'some-id-3'),
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
          Input(
            key: GlobalKey('some-key-1'),
            id: 'some-updated-id',
          ),
          Input(
            key: GlobalKey('some-key-2'),
            id: 'some-local-updated-id',
          ),
          Input(
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
          Input(
            key: Key('widget-1'),
            id: 'some id',
          ),
          Input(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          Input(
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
          Input(
            id: 'widget-1',
            child: Input(
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
          Input(
            id: 'widget-1',
            children: [
              Input(
                id: 'widget-2',
              ),
              Input(
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
          Input(
            key: GlobalKey('el-1'),
            classAttribute: 'some-classes',
          ),
          Input(
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
          Input(
            key: GlobalKey('el-1'),
            classAttribute: 'some-classes',
          ),
          Input(
            key: GlobalKey('el-2'),
            classAttribute: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(
            key: GlobalKey('el-1'),
            classAttribute: 'updated-classes',
          ),
          Input(
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
          Input(key: GlobalKey('el-1')),
          Input(
            key: GlobalKey('el-2'),
            classAttribute: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
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
          Input(
            key: GlobalKey('el-1'),
            classAttribute: 'some-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), classAttribute: null),
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
          Input(key: GlobalKey('el-1'), classAttribute: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          Input(
            key: Key('widget-1'),
            classAttribute: 'some classes',
          ),
          Input(
            key: Key('widget-2'),
            classAttribute: 'some "messy" classes',
          ),
          Input(
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
          Input(
            key: Key('widget-1'),
            contentEditable: false,
          ),
          Input(
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
          Input(
            key: Key('widget-1'),
            draggable: false,
          ),
          Input(
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
          Input(key: GlobalKey('el-1'), hidden: false),
          Input(key: GlobalKey('el-2'), hidden: null),
          Input(key: GlobalKey('el-3'), hidden: true),
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
          Input(key: GlobalKey('el-1'), hidden: true),
          Input(key: GlobalKey('el-2'), hidden: true),
          Input(key: GlobalKey('el-3'), hidden: true),
          Input(key: GlobalKey('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), hidden: true),
          Input(key: GlobalKey('el-2'), hidden: false),
          Input(key: GlobalKey('el-3'), hidden: null),
          Input(key: GlobalKey('el-4')),
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
          Input(
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
    }, onPlatform: {
      'chrome': Skip('Failing for input on chrome'),
    });

    test('should set attribute "onClickAttribute"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
          Input(key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
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
          Input(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
          Input(key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), onClickAttribute: 'updated-on-click'),
          Input(key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onClickAttribute: 'another-on-click'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
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
          Input(key: GlobalKey('el-1'), onClickAttribute: 'some-on-click'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), onClickAttribute: null),
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
          Input(key: GlobalKey('el-1'), onClickAttribute: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('onClick'), equals(null));
    });

    test('should set messy "onClickAttribute"', () async {
      await app!.buildChildren(
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
          Input(
            key: GlobalKey('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          Input(
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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onClick: null),
          Input(key: GlobalKey('el-3'), onClick: listener),
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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onClick: listener),
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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
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
          Input(key: Key('widget-1'), style: 'some style'),
          Input(key: Key('widget-2'), style: 'some "messy" style'),
          Input(key: Key('widget-3'), style: "some 'messy' style"),
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
          Input(key: Key('widget-1'), title: 'some title'),
          Input(key: Key('widget-2'), title: 'some "messy" title'),
          Input(key: Key('widget-3'), title: "some 'messy' title"),
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
          Input(key: GlobalKey('some-key-3')),
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
          Input(
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
          Input(
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
          Input(
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
            Input(
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
            Input(
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
            Input(
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
      var widget = Input();
      var widgetShort = input();

      expect(
        widget.runtimeType,
        equals(widgetShort.runtimeType),
      );
    });

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('some-key-1')),
          Input(key: GlobalKey('some-key-2')),
          Input(key: GlobalKey('some-key-3')),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var wO1 = app!.renderElementByGlobalKey('some-key-1')!;
      var wO2 = app!.renderElementByGlobalKey('some-key-2')!;
      var wO3 = app!.renderElementByGlobalKey('some-key-3')!;

      expect(wO1.key?.frameworkValue, endsWith('some-key-1'));
      expect(wO2.key?.frameworkValue, endsWith('some-key-2'));
      expect(wO3.key?.frameworkValue, equals('some-key-3'));
    });

    test('should set attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), name: 'some-name'),
          Input(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('name'), equals('some-name'));
      expect(domNode2.getAttribute('name'), equals('another-name'));
    });

    test('should update attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), name: 'some-name'),
          Input(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), name: 'updated-name'),
          Input(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('name'), equals('updated-name'));
      expect(domNode2.getAttribute('name'), equals('another-name'));
    });

    test('should clear attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('name'), equals(null));
      expect(domNode2.getAttribute('name'), equals(null));
    });

    test('should clear attribute "name" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), name: 'some-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), name: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('name'), equals(null));
    });

    test('should not set attribute "name" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), name: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('name'), equals(null));
    });

    test('should set messy "name"', () async {
      await app!.buildChildren(
        widgets: [
          Input(
            key: Key('widget-1'),
            name: 'some name',
          ),
          Input(
            key: Key('widget-2'),
            name: 'some "messy" name',
          ),
          Input(
            key: Key('widget-3'),
            name: "some 'messy' name",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

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

    test('should set attribute "value"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: 'some-value'),
          Input(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('value'), equals('some-value'));
      expect(domNode2.getAttribute('value'), equals('another-value'));
    });

    test('should update attribute "value"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: 'some-value'),
          Input(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: 'updated-value'),
          Input(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('value'), equals('updated-value'));
      expect(domNode2.getAttribute('value'), equals('another-value'));
    });

    test('should clear attribute "value"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), value: 'another-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('value'), equals(null));
      expect(domNode2.getAttribute('value'), equals(null));
    });

    test('should clear attribute "value" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: 'some-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('value'), equals(null));
    });

    test('should not set attribute "value" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), value: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('value'), equals(null));
    });

    test('should set attribute "accept"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), accept: 'some-accept'),
          Input(key: GlobalKey('el-2'), accept: 'another-accept'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('accept'), equals('some-accept'));
      expect(domNode2.getAttribute('accept'), equals('another-accept'));
    });

    test('should update attribute "accept"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), accept: 'some-accept'),
          Input(key: GlobalKey('el-2'), accept: 'another-accept'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), accept: 'updated-accept'),
          Input(key: GlobalKey('el-2'), accept: 'another-accept'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('accept'), equals('updated-accept'));
      expect(domNode2.getAttribute('accept'), equals('another-accept'));
    });

    test('should clear attribute "accept"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), accept: 'another-accept'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('accept'), equals(null));
      expect(domNode2.getAttribute('accept'), equals(null));
    });

    test('should clear attribute "accept" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), accept: 'some-accept'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), accept: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('accept'), equals(null));
    });

    test('should not set attribute "accept" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), accept: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('accept'), equals(null));
    });

    test('should set messy "accept"', () async {
      await app!.buildChildren(
        widgets: [
          Input(
            key: Key('widget-1'),
            accept: 'some accept',
          ),
          Input(
            key: Key('widget-2'),
            accept: 'some "messy" accept',
          ),
          Input(
            key: Key('widget-3'),
            accept: "some 'messy' accept",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('accept'),
        equals('some accept'),
      );

      expect(
        domNode2.getAttribute('accept'),
        equals('some "messy" accept'),
      );

      expect(
        domNode3.getAttribute('accept'),
        equals("some 'messy' accept"),
      );
    });

    test('should set attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), minLength: 10),
          Input(key: GlobalKey('el-2'), minLength: 0),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('minlength'), equals('10'));
      expect(domNode2.getAttribute('minlength'), equals('0'));
    });

    test('should update attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), minLength: 10),
          Input(key: GlobalKey('el-2'), minLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), minLength: 20),
          Input(key: GlobalKey('el-2'), minLength: 20),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('minlength'), equals('20'));
      expect(domNode2.getAttribute('minlength'), equals('20'));
    });

    test('should clear attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), minLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
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
          Input(key: GlobalKey('el-1'), minLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), minLength: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('minlength'), equals(null));
    });

    test('should not set attribute "minLength" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), minLength: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('minlength'), equals(null));
    });

    test('should set attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), maxLength: 10),
          Input(key: GlobalKey('el-2'), maxLength: 0),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('maxlength'), equals('10'));
      expect(domNode2.getAttribute('maxlength'), equals('0'));
    });

    test('should update attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), maxLength: 10),
          Input(key: GlobalKey('el-2'), maxLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), maxLength: 20),
          Input(key: GlobalKey('el-2'), maxLength: 20),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('maxlength'), equals('20'));
      expect(domNode2.getAttribute('maxlength'), equals('20'));
    });

    test('should clear attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), maxLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
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
          Input(key: GlobalKey('el-1'), maxLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), maxLength: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('maxlength'), equals(null));
    });

    test('should not set attribute "maxLength" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), maxLength: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('maxlength'), equals(null));
    });

    test('should set attribute "pattern"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: 'some-pattern'),
          Input(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('pattern'), equals('some-pattern'));
      expect(domNode2.getAttribute('pattern'), equals('another-pattern'));
    });

    test('should update attribute "pattern"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: 'some-pattern'),
          Input(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: 'updated-pattern'),
          Input(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('pattern'), equals('updated-pattern'));
      expect(domNode2.getAttribute('pattern'), equals('another-pattern'));
    });

    test('should clear attribute "pattern"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), pattern: 'another-pattern'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');

      expect(domNode1.getAttribute('pattern'), equals(null));
      expect(domNode2.getAttribute('pattern'), equals(null));
    });

    test('should clear attribute "pattern" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: 'some-pattern'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('pattern'), equals(null));
    });

    test('should not set attribute "pattern" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), pattern: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('pattern'), equals(null));
    });

    test('should set attribute "placeholder"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
          Input(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentRenderElement: app!.appRenderElement,
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
          Input(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
          Input(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), placeholder: 'updated-placeholder'),
          Input(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), placeholder: 'another-placeholder'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
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
          Input(key: GlobalKey('el-1'), placeholder: 'some-placeholder'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), placeholder: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('placeholder'), equals(null));
    });

    test('should not set attribute "placeholder" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), placeholder: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');

      expect(domNode1.getAttribute('placeholder'), equals(null));
    });

    test('should set attribute "multiple" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), multiple: false),
          Input(key: GlobalKey('el-2'), multiple: null),
          Input(key: GlobalKey('el-3'), multiple: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');

      expect(domNode1.getAttribute('multiple'), equals(null));
      expect(domNode2.getAttribute('multiple'), equals(null));
      expect(domNode3.getAttribute('multiple'), equals('true'));
    });

    test('should clear attribute "multiple" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), multiple: true),
          Input(key: GlobalKey('el-2'), multiple: true),
          Input(key: GlobalKey('el-3'), multiple: true),
          Input(key: GlobalKey('el-4'), multiple: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), multiple: true),
          Input(key: GlobalKey('el-2'), multiple: false),
          Input(key: GlobalKey('el-3'), multiple: null),
          Input(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');
      var domNode4 = app!.domNodeByGlobalKey('el-4');

      expect(domNode1.getAttribute('multiple'), equals('true'));
      expect(domNode2.getAttribute('multiple'), equals(null));
      expect(domNode3.getAttribute('multiple'), equals(null));
      expect(domNode4.getAttribute('multiple'), equals(null));
    });

    test('should set attribute "required" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), required: false),
          Input(key: GlobalKey('el-2'), required: null),
          Input(key: GlobalKey('el-3'), required: true),
        ],
        parentRenderElement: app!.appRenderElement,
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
          Input(key: GlobalKey('el-1'), required: true),
          Input(key: GlobalKey('el-2'), required: true),
          Input(key: GlobalKey('el-3'), required: true),
          Input(key: GlobalKey('el-4'), required: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), required: true),
          Input(key: GlobalKey('el-2'), required: false),
          Input(key: GlobalKey('el-3'), required: null),
          Input(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
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
          Input(key: GlobalKey('el-1'), readOnly: false),
          Input(key: GlobalKey('el-2'), readOnly: null),
          Input(key: GlobalKey('el-3'), readOnly: true),
        ],
        parentRenderElement: app!.appRenderElement,
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
          Input(key: GlobalKey('el-1'), readOnly: true),
          Input(key: GlobalKey('el-2'), readOnly: true),
          Input(key: GlobalKey('el-3'), readOnly: true),
          Input(key: GlobalKey('el-4'), readOnly: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), readOnly: true),
          Input(key: GlobalKey('el-2'), readOnly: false),
          Input(key: GlobalKey('el-3'), readOnly: null),
          Input(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
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
          Input(key: GlobalKey('el-1'), disabled: false),
          Input(key: GlobalKey('el-2'), disabled: null),
          Input(key: GlobalKey('el-3'), disabled: true),
        ],
        parentRenderElement: app!.appRenderElement,
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
          Input(key: GlobalKey('el-1'), disabled: true),
          Input(key: GlobalKey('el-2'), disabled: true),
          Input(key: GlobalKey('el-3'), disabled: true),
          Input(key: GlobalKey('el-4'), disabled: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), disabled: true),
          Input(key: GlobalKey('el-2'), disabled: false),
          Input(key: GlobalKey('el-3'), disabled: null),
          Input(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
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

    test('should set attribute "checked" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), checked: false),
          Input(key: GlobalKey('el-2'), checked: null),
          Input(key: GlobalKey('el-3'), checked: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');

      expect(domNode1.getAttribute('checked'), equals(null));
      expect(domNode2.getAttribute('checked'), equals(null));
      expect(domNode3.getAttribute('checked'), equals('true'));
    });

    test('should clear attribute "checked" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), checked: true),
          Input(key: GlobalKey('el-2'), checked: true),
          Input(key: GlobalKey('el-3'), checked: true),
          Input(key: GlobalKey('el-4'), checked: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), checked: true),
          Input(key: GlobalKey('el-2'), checked: false),
          Input(key: GlobalKey('el-3'), checked: null),
          Input(key: GlobalKey('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');
      var domNode4 = app!.domNodeByGlobalKey('el-4');

      expect(domNode1.getAttribute('checked'), equals('true'));
      expect(domNode2.getAttribute('checked'), equals(null));
      expect(domNode3.getAttribute('checked'), equals(null));
      expect(domNode4.getAttribute('checked'), equals(null));
    });

    test('should set input attribute "type"', () async {
      await app!.buildChildren(
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
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');
      var domNode4 = app!.domNodeByGlobalKey('el-4');
      var domNode5 = app!.domNodeByGlobalKey('el-5');
      var domNode6 = app!.domNodeByGlobalKey('el-6');
      var domNode7 = app!.domNodeByGlobalKey('el-7');
      var domNode8 = app!.domNodeByGlobalKey('el-8');

      expect(domNode1.getAttribute('type'), equals(null));
      expect(domNode2.getAttribute('type'), equals(null));
      expect(domNode3.getAttribute('type'), equals('text'));
      expect(domNode4.getAttribute('type'), equals('password'));
      expect(domNode5.getAttribute('type'), equals('radio'));
      expect(domNode6.getAttribute('type'), equals('checkbox'));
      expect(domNode7.getAttribute('type'), equals('submit'));
      expect(domNode8.getAttribute('type'), equals('file'));
    });

    test('should update form attribute "type"', () async {
      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), type: null),
          Input(key: GlobalKey('el-3'), type: InputType.text),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1'), type: InputType.text),
          Input(key: GlobalKey('el-2'), type: null),
          Input(key: GlobalKey('el-3')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByGlobalKey('el-1');
      var domNode2 = app!.domNodeByGlobalKey('el-2');
      var domNode3 = app!.domNodeByGlobalKey('el-3');

      expect(domNode1.getAttribute('type'), equals('text'));
      expect(domNode2.getAttribute('type'), equals(null));
      expect(domNode3.getAttribute('type'), equals(null));
    });

    test('should set "change" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          Input(
            key: GlobalKey('el-1'),
            onChange: (event) => testStack.push('change-1'),
          ),
          Input(
            key: GlobalKey('el-2'),
            onChange: (event) => testStack.push('change-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByGlobalKey('el-1').dispatchEvent(Event('change'));
      app!.domNodeByGlobalKey('el-2').dispatchEvent(Event('change'));

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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onChange: null),
          Input(key: GlobalKey('el-3'), onChange: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByGlobalKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.change], equals(null));
      expect(listeners2[DomEventType.change], equals(null));
      expect(listeners3[DomEventType.change], equals(listener));
    });

    test('should clear "change" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onChange: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.change], equals(null));
      expect(listeners2[DomEventType.change], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.change], equals(null));
      expect(listeners2[DomEventType.change], equals(null));
    });

    test('should set "input" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          Input(
            key: GlobalKey('el-1'),
            onInput: (event) => testStack.push('input-1'),
          ),
          Input(
            key: GlobalKey('el-2'),
            onInput: (event) => testStack.push('input-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByGlobalKey('el-1').dispatchEvent(Event('input'));
      app!.domNodeByGlobalKey('el-2').dispatchEvent(Event('input'));

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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onInput: null),
          Input(key: GlobalKey('el-3'), onInput: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByGlobalKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.input], equals(null));
      expect(listeners2[DomEventType.input], equals(null));
      expect(listeners3[DomEventType.input], equals(listener));
    });

    test('should clear "input" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onInput: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.input], equals(null));
      expect(listeners2[DomEventType.input], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.input], equals(null));
      expect(listeners2[DomEventType.input], equals(null));
    });

    test('should set "KeyPress" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          Input(
            key: GlobalKey('el-1'),
            onKeyPress: (event) => testStack.push('keypress-1'),
          ),
          Input(
            key: GlobalKey('el-2'),
            onKeyPress: (event) => testStack.push('keypress-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByGlobalKey('el-1').dispatchEvent(Event('keypress'));
      app!.domNodeByGlobalKey('el-2').dispatchEvent(Event('keypress'));

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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onKeyPress: null),
          Input(key: GlobalKey('el-3'), onKeyPress: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByGlobalKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.keyPress], equals(null));
      expect(listeners2[DomEventType.keyPress], equals(null));
      expect(listeners3[DomEventType.keyPress], equals(listener));
    });

    test('should clear "KeyPress" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onKeyPress: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyPress], equals(null));
      expect(listeners2[DomEventType.keyPress], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyPress], equals(null));
      expect(listeners2[DomEventType.keyPress], equals(null));
    });

    test('should set "KeyUp" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          Input(
            key: GlobalKey('el-1'),
            onKeyUp: (event) => testStack.push('keyup-1'),
          ),
          Input(
            key: GlobalKey('el-2'),
            onKeyUp: (event) => testStack.push('keyup-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByGlobalKey('el-1').dispatchEvent(Event('keyup'));
      app!.domNodeByGlobalKey('el-2').dispatchEvent(Event('keyup'));

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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onKeyUp: null),
          Input(key: GlobalKey('el-3'), onKeyUp: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByGlobalKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.keyUp], equals(null));
      expect(listeners2[DomEventType.keyUp], equals(null));
      expect(listeners3[DomEventType.keyUp], equals(listener));
    });

    test('should clear "KeyUp" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onKeyUp: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyUp], equals(null));
      expect(listeners2[DomEventType.keyUp], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyUp], equals(null));
      expect(listeners2[DomEventType.keyUp], equals(null));
    });

    test('should set "KeyDown" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          Input(
            key: GlobalKey('el-1'),
            onKeyDown: (event) => testStack.push('keydown-1'),
          ),
          Input(
            key: GlobalKey('el-2'),
            onKeyDown: (event) => testStack.push('keydown-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByGlobalKey('el-1').dispatchEvent(Event('keydown'));
      app!.domNodeByGlobalKey('el-2').dispatchEvent(Event('keydown'));

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
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onKeyDown: null),
          Input(key: GlobalKey('el-3'), onKeyDown: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByGlobalKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.keyDown], equals(null));
      expect(listeners2[DomEventType.keyDown], equals(null));
      expect(listeners3[DomEventType.keyDown], equals(listener));
    });

    test('should clear "KeyDown" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2'), onKeyDown: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyDown], equals(null));
      expect(listeners2[DomEventType.keyDown], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          Input(key: GlobalKey('el-1')),
          Input(key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyDown], equals(null));
      expect(listeners2[DomEventType.keyDown], equals(null));
    });
  });
}
