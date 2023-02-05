// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

void html_input_week_test() {
  group('HTML InputWeek tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('some-key-1'), id: 'some-id-1'),
          InputWeek(key: Key('some-key-2'), id: 'some-id-2'),
          InputWeek(key: Key('some-key-3'), id: 'some-id-3'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('some-key-1');
      var domNode2 = app!.domNodeByKeyValue('some-key-2');
      var domNode3 = app!.domNodeByKeyValue('some-key-3');

      expect(domNode1.id, equals('some-id-1'));
      expect(domNode2.id, equals('some-id-2'));
      expect(domNode3.id, equals('some-id-3'));
    });

    test('should reset and update id', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('some-key-1'), id: 'some-id-1'),
          InputWeek(key: Key('some-key-2'), id: 'some-id-2'),
          InputWeek(key: Key('some-key-3'), id: 'some-id-3'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('some-key-1');
      var domNode2 = app!.domNodeByKeyValue('some-key-2');
      var domNode3 = app!.domNodeByKeyValue('some-key-3');

      expect(domNode1.id, equals('some-id-1'));
      expect(domNode2.id, equals('some-id-2'));
      expect(domNode3.id, equals('some-id-3'));

      await app!.updateChildren(
        widgets: [
          InputWeek(
            key: Key('some-key-1'),
            id: 'some-updated-id',
          ),
          InputWeek(
            key: Key('some-key-2'),
            id: 'some-local-updated-id',
          ),
          InputWeek(
            key: Key('some-key-3'),
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
          InputWeek(
            key: Key('widget-1'),
            id: 'some id',
          ),
          InputWeek(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          InputWeek(
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

    test('should set children widgets', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            id: 'widget-1',
            children: [
              InputWeek(
                id: 'widget-2',
              ),
              InputWeek(
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

    test('should set child widget', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            id: 'widget-1',
            child: InputWeek(
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

    test('should set attribute "classes"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          InputWeek(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('class'), equals('some-classes'));
      expect(domNode2.getAttribute('class'), equals('another-classes'));
    });

    test('should update attribute "classes"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          InputWeek(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(
            key: Key('el-1'),
            className: 'updated-classes',
          ),
          InputWeek(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('class'), equals('updated-classes'));
      expect(domNode2.getAttribute('class'), equals('another-classes'));
    });

    test('should clear attribute "classes"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('class'), equals(null));
      expect(domNode2.getAttribute('class'), equals(null));
    });

    test('should clear attribute "classes" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('el-1'),
            className: 'some-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), className: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should not set attribute "classes" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), className: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('widget-1'),
            className: 'some classes',
          ),
          InputWeek(
            key: Key('widget-2'),
            className: 'some "messy" classes',
          ),
          InputWeek(
            key: Key('widget-3'),
            className: "some 'messy' classes",
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

    test('should set attribute "hidden" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), hidden: false),
          InputWeek(key: Key('el-2'), hidden: null),
          InputWeek(key: Key('el-3'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('hidden'), equals(null));
      expect(domNode2.getAttribute('hidden'), equals(null));
      expect(domNode3.getAttribute('hidden'), equals('true'));
    });

    test('should clear attribute "hidden" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), hidden: true),
          InputWeek(key: Key('el-2'), hidden: true),
          InputWeek(key: Key('el-3'), hidden: true),
          InputWeek(key: Key('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), hidden: true),
          InputWeek(key: Key('el-2'), hidden: false),
          InputWeek(key: Key('el-3'), hidden: null),
          InputWeek(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('hidden'), equals('true'));
      expect(domNode2.getAttribute('hidden'), equals(null));
      expect(domNode3.getAttribute('hidden'), equals(null));
      expect(domNode4.getAttribute('hidden'), equals(null));
    });

    test('should set inner text', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('widget-1'),
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

    test('should set "click" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          InputWeek(
            key: Key('el-2'),
            onClick: (event) => testStack.push('click-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('el-1').dispatchEvent(Event('click'));
      app!.domNodeByKeyValue('el-2').dispatchEvent(Event('click'));

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
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), onClick: null),
          InputWeek(key: Key('el-3'), onClick: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(null));
      expect(listeners3[DomEventType.click], equals(listener));
    });

    test('should clear "click" event listener', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), onClick: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(null));
    });

    test('should set style', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('widget-1'), style: 'some style'),
          InputWeek(key: Key('widget-2'), style: 'some "messy" style'),
          InputWeek(key: Key('widget-3'), style: "some 'messy' style"),
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

    test('should set title', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('widget-1'), title: 'some title'),
          InputWeek(key: Key('widget-2'), title: 'some "messy" title'),
          InputWeek(key: Key('widget-3'), title: "some 'messy' title"),
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

    test('should call ref with correct element', () async {
      Element? el1;
      Element? el2;
      Element? el3;

      await app!.buildChildren(
        widgets: [
          InputWeek(id: 'some-id-1', ref: (el) => el1 = el),
          InputWeek(id: 'some-id-2', ref: (el) => el2 = el),
          InputWeek(id: 'some-id-3', ref: (el) => el3 = el),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(el1, equals(document.getElementById('some-id-1')));
      expect(el2, equals(document.getElementById('some-id-2')));
      expect(el3, equals(document.getElementById('some-id-3')));
    });

    test('should call ref-callback before afterMounts', () async {
      Element? el1;
      var stack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(roEventAfterMount: () {
            stack.push('after mount');
            expect(el1, equals(document.getElementById('some-id-1')));
          }),
          InputWeek(id: 'some-id-1', ref: (el) => el1 = el),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(stack.popFromStart(), equals('after mount'));
      expect(stack.canPop(), equals(false));
    });

    test('should call ref-callback with null on dispose', () async {
      Element? el1;
      var stack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            roEventDispose: () {
              stack.push('dispose');
              expect(el1, equals(null));
            },
            // child widgets are disposed first
            children: [
              InputWeek(id: 'some-id-1', ref: (el) => el1 = el),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [InputWeek()],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(stack.popFromStart(), equals('dispose'));
      expect(stack.canPop(), equals(false));
    });

    test('should not call ref-callback on update', () async {
      var stack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputWeek(ref: (el) {
            stack.push('callback');
          }),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(ref: (el) {
            stack.push('callback');
          }),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(stack.popFromStart(), equals('callback'));
      expect(stack.canPop(), equals(false));
    });

    test('should set correct types and markup', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('some-key-3')),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      expect(
        RT_TestBed.rootDomNode.innerHtml,
        startsWith(
          //
          // some tags might don't have a closing tag
          //
          [
            'area',
            'img',
            'col',
            'br',
            'hr',
            'input',
            'wbr',
            'track',
            'embed',
            'source',
          ].contains('input')
              ? [
                  'input',
                ].contains('input')
                  // because system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<input'
                  : '<input>'
              : '<input></input>',
        ),
      );
    });

    test(
        'should allow widget attributes to be set through additional attributes',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('some-key-3'),
            additionalAttributes: {
              'id': 'some-id',
            },
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0].childNodes[0];

      domNode1 as HtmlElement;

      expect(domNode1.id, equals('some-id'));
    });

    test(
        'should ignore additional attribute if already set in widget constructor',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
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

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0].childNodes[0];

      domNode1 as HtmlElement;

      expect(domNode1.id, equals('some-id'));
      expect(domNode1.getAttribute('custom'), equals('applied'));
    });

    test(
        'should ignore additional attribute if already set in widget constructor, during updates',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
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
          InputWeek(
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

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0].childNodes[0];

      domNode1 as HtmlElement;

      expect(domNode1.id, equals('updated-id'));
    });

    test('should set data attributes', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('some-key-3'),
            additionalAttributes: {
              'data-something': 'something okay',
              'data-another': 'another okay',
            },
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;

      expect(domNode1.dataset['something'], equals('something okay'));
      expect(domNode1.dataset['another'], equals('another okay'));
    });

    test('should set aria/any attributes', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('some-key-3'),
            additionalAttributes: {
              'aria-something': 'something okay',
              'any-another': 'another okay',
            },
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;

      expect(domNode1.getAttribute('aria-something'), equals('something okay'));
      expect(domNode1.getAttribute('any-another'), equals('another okay'));
    });

    test('should remove obsolete and add new data attributes on update',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
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
          InputWeek(
            key: Key('some-key-3'),
            additionalAttributes: {
              'data-something-new': 'something new',
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

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('some-key-1')),
          InputWeek(key: Key('some-key-2')),
          InputWeek(key: Key('some-key-3')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var wO1 = app!.renderElementByKeyValue('some-key-1')!;
      var wO2 = app!.renderElementByKeyValue('some-key-2')!;
      var wO3 = app!.renderElementByKeyValue('some-key-3')!;

      expect(wO1.key?.frameworkValue, endsWith('some-key-1'));
      expect(wO2.key?.frameworkValue, endsWith('some-key-2'));
      expect(wO3.key?.frameworkValue, equals('some-key-3'));
    });

    test('should set attribute "autocomplete"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), autoComplete: 'some-autocomplete'),
          InputWeek(key: Key('el-2'), autoComplete: 'another-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(
          domNode1.getAttribute('autocomplete'), equals('some-autocomplete'));
      expect(domNode2.getAttribute('autocomplete'),
          equals('another-autocomplete'));
    });

    test('should update attribute "autocomplete"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), autoComplete: 'some-autocomplete'),
          InputWeek(key: Key('el-2'), autoComplete: 'another-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), autoComplete: 'updated-autocomplete'),
          InputWeek(key: Key('el-2'), autoComplete: 'another-autocomplete'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('autocomplete'),
          equals('updated-autocomplete'));
      expect(domNode2.getAttribute('autocomplete'),
          equals('another-autocomplete'));
    });

    test('should clear attribute "autocomplete"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), autoComplete: 'another-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('autocomplete'), equals(null));
      expect(domNode2.getAttribute('autocomplete'), equals(null));
    });

    test(
        'should clear attribute "autocomplete" if updated autocomplete is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), autoComplete: 'some-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), autoComplete: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('autocomplete'), equals(null));
    });

    test(
        'should not set attribute "autocomplete" if provided autocomplete is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), autoComplete: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('autocomplete'), equals(null));
    });

    test('should set attribute "list"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), list: 'some-list'),
          InputWeek(key: Key('el-2'), list: 'another-list'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('list'), equals('some-list'));
      expect(domNode2.getAttribute('list'), equals('another-list'));
    });

    test('should update attribute "list"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), list: 'some-list'),
          InputWeek(key: Key('el-2'), list: 'another-list'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), list: 'updated-list'),
          InputWeek(key: Key('el-2'), list: 'another-list'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('list'), equals('updated-list'));
      expect(domNode2.getAttribute('list'), equals('another-list'));
    });

    test('should clear attribute "list"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), list: 'another-list'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('list'), equals(null));
      expect(domNode2.getAttribute('list'), equals(null));
    });

    test('should clear attribute "list" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), list: 'some-list'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), list: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('list'), equals(null));
    });

    test('should not set attribute "list" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), list: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('list'), equals(null));
    });

    test('should set messy "list"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('widget-1'),
            list: 'some list',
          ),
          InputWeek(
            key: Key('widget-2'),
            list: 'some "messy" list',
          ),
          InputWeek(
            key: Key('widget-3'),
            list: "some 'messy' list",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('list'),
        equals('some list'),
      );

      expect(
        domNode2.getAttribute('list'),
        equals('some "messy" list'),
      );

      expect(
        domNode3.getAttribute('list'),
        equals("some 'messy' list"),
      );
    });

    test('should set attribute "max"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), max: 'some-max'),
          InputWeek(key: Key('el-2'), max: 'another-max'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('max'), equals('some-max'));
      expect(domNode2.getAttribute('max'), equals('another-max'));
    });

    test('should update attribute "max"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), max: 'some-max'),
          InputWeek(key: Key('el-2'), max: 'another-max'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), max: 'updated-max'),
          InputWeek(key: Key('el-2'), max: 'another-max'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('max'), equals('updated-max'));
      expect(domNode2.getAttribute('max'), equals('another-max'));
    });

    test('should clear attribute "max"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), max: 'another-max'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('max'), equals(null));
      expect(domNode2.getAttribute('max'), equals(null));
    });

    test('should clear attribute "max" if updated max is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), max: 'some-max'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), max: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('max'), equals(null));
    });

    test('should not set attribute "max" if provided max is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), max: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('max'), equals(null));
    });

    test('should set attribute "min"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), min: 'some-min'),
          InputWeek(key: Key('el-2'), min: 'another-min'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('min'), equals('some-min'));
      expect(domNode2.getAttribute('min'), equals('another-min'));
    });

    test('should update attribute "min"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), min: 'some-min'),
          InputWeek(key: Key('el-2'), min: 'another-min'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), min: 'updated-min'),
          InputWeek(key: Key('el-2'), min: 'another-min'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('min'), equals('updated-min'));
      expect(domNode2.getAttribute('min'), equals('another-min'));
    });

    test('should clear attribute "min"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), min: 'another-min'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('min'), equals(null));
      expect(domNode2.getAttribute('min'), equals(null));
    });

    test('should clear attribute "min" if updated min is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), min: 'some-min'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), min: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('min'), equals(null));
    });

    test('should not set attribute "min" if provided min is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), min: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('min'), equals(null));
    });

    test('should set attribute "readonly" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), readOnly: false),
          InputWeek(key: Key('el-2'), readOnly: null),
          InputWeek(key: Key('el-3'), readOnly: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('readonly'), equals(null));
      expect(domNode2.getAttribute('readonly'), equals(null));
      expect(domNode3.getAttribute('readonly'), equals('true'));
    });

    test('should clear attribute "readonly" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), readOnly: true),
          InputWeek(key: Key('el-2'), readOnly: true),
          InputWeek(key: Key('el-3'), readOnly: true),
          InputWeek(key: Key('el-4'), readOnly: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), readOnly: true),
          InputWeek(key: Key('el-2'), readOnly: false),
          InputWeek(key: Key('el-3'), readOnly: null),
          InputWeek(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('readonly'), equals('true'));
      expect(domNode2.getAttribute('readonly'), equals(null));
      expect(domNode3.getAttribute('readonly'), equals(null));
      expect(domNode4.getAttribute('readonly'), equals(null));
    });

    test('should set attribute "required" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), required: false),
          InputWeek(key: Key('el-2'), required: null),
          InputWeek(key: Key('el-3'), required: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('required'), equals(null));
      expect(domNode2.getAttribute('required'), equals(null));
      expect(domNode3.getAttribute('required'), equals('true'));
    });

    test('should clear attribute "required" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), required: true),
          InputWeek(key: Key('el-2'), required: true),
          InputWeek(key: Key('el-3'), required: true),
          InputWeek(key: Key('el-4'), required: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), required: true),
          InputWeek(key: Key('el-2'), required: false),
          InputWeek(key: Key('el-3'), required: null),
          InputWeek(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('required'), equals('true'));
      expect(domNode2.getAttribute('required'), equals(null));
      expect(domNode3.getAttribute('required'), equals(null));
      expect(domNode4.getAttribute('required'), equals(null));
    });

    test('should set attribute "step"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), step: 'some-step'),
          InputWeek(key: Key('el-2'), step: 'another-step'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('step'), equals('some-step'));
      expect(domNode2.getAttribute('step'), equals('another-step'));
    });

    test('should update attribute "step"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), step: 'some-step'),
          InputWeek(key: Key('el-2'), step: 'another-step'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), step: 'updated-step'),
          InputWeek(key: Key('el-2'), step: 'another-step'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('step'), equals('updated-step'));
      expect(domNode2.getAttribute('step'), equals('another-step'));
    });

    test('should clear attribute "step"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), step: 'another-step'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('step'), equals(null));
      expect(domNode2.getAttribute('step'), equals(null));
    });

    test('should clear attribute "step" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), step: 'some-step'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), step: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('step'), equals(null));
    });

    test('should not set attribute "step" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), step: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('step'), equals(null));
    });

    test('should set messy "step"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('widget-1'),
            step: 'some step',
          ),
          InputWeek(
            key: Key('widget-2'),
            step: 'some "messy" step',
          ),
          InputWeek(
            key: Key('widget-3'),
            step: "some 'messy' step",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('step'),
        equals('some step'),
      );

      expect(
        domNode2.getAttribute('step'),
        equals('some "messy" step'),
      );

      expect(
        domNode3.getAttribute('step'),
        equals("some 'messy' step"),
      );
    });

    test('should set attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), name: 'some-name'),
          InputWeek(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('name'), equals('some-name'));
      expect(domNode2.getAttribute('name'), equals('another-name'));
    });

    test('should update attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), name: 'some-name'),
          InputWeek(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), name: 'updated-name'),
          InputWeek(key: Key('el-2'), name: 'another-name'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('name'), equals('updated-name'));
      expect(domNode2.getAttribute('name'), equals('another-name'));
    });

    test('should clear attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('name'), equals(null));
      expect(domNode2.getAttribute('name'), equals(null));
    });

    test('should clear attribute "name" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), name: 'some-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), name: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('name'), equals(null));
    });

    test('should not set attribute "name" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), name: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('name'), equals(null));
    });

    test('should set messy "name"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('widget-1'),
            name: 'some name',
          ),
          InputWeek(
            key: Key('widget-2'),
            name: 'some "messy" name',
          ),
          InputWeek(
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

    test('should set attribute "disabled" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), disabled: false),
          InputWeek(key: Key('el-2'), disabled: null),
          InputWeek(key: Key('el-3'), disabled: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('disabled'), equals(null));
      expect(domNode2.getAttribute('disabled'), equals(null));
      expect(domNode3.getAttribute('disabled'), equals('true'));
    });

    test('should clear attribute "disabled" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), disabled: true),
          InputWeek(key: Key('el-2'), disabled: true),
          InputWeek(key: Key('el-3'), disabled: true),
          InputWeek(key: Key('el-4'), disabled: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), disabled: true),
          InputWeek(key: Key('el-2'), disabled: false),
          InputWeek(key: Key('el-3'), disabled: null),
          InputWeek(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('disabled'), equals('true'));
      expect(domNode2.getAttribute('disabled'), equals(null));
      expect(domNode3.getAttribute('disabled'), equals(null));
      expect(domNode4.getAttribute('disabled'), equals(null));
    });

    test('should set attribute "form"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), form: 'some-form'),
          InputWeek(key: Key('el-2'), form: 'another-form'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('form'), equals('some-form'));
      expect(domNode2.getAttribute('form'), equals('another-form'));
    });

    test('should update attribute "form"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), form: 'some-form'),
          InputWeek(key: Key('el-2'), form: 'another-form'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), form: 'updated-form'),
          InputWeek(key: Key('el-2'), form: 'another-form'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('form'), equals('updated-form'));
      expect(domNode2.getAttribute('form'), equals('another-form'));
    });

    test('should clear attribute "form"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), form: 'another-form'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('form'), equals(null));
      expect(domNode2.getAttribute('form'), equals(null));
    });

    test('should clear attribute "form" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), form: 'some-form'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), form: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('form'), equals(null));
    });

    test('should not set attribute "form" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), form: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('form'), equals(null));
    });

    test('should set messy "form"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('widget-1'),
            form: 'some form',
          ),
          InputWeek(
            key: Key('widget-2'),
            form: 'some "messy" form',
          ),
          InputWeek(
            key: Key('widget-3'),
            form: "some 'messy' form",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('form'),
        equals('some form'),
      );

      expect(
        domNode2.getAttribute('form'),
        equals('some "messy" form'),
      );

      expect(
        domNode3.getAttribute('form'),
        equals("some 'messy' form"),
      );
    });

    test('should set attribute "inputmode"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), inputMode: 'some-inputmode'),
          InputWeek(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('inputmode'), equals('some-inputmode'));
      expect(domNode2.getAttribute('inputmode'), equals('another-inputmode'));
    });

    test('should update attribute "inputmode"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), inputMode: 'some-inputmode'),
          InputWeek(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), inputMode: 'updated-inputmode'),
          InputWeek(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('inputmode'), equals('updated-inputmode'));
      expect(domNode2.getAttribute('inputmode'), equals('another-inputmode'));
    });

    test('should clear attribute "inputmode"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('inputmode'), equals(null));
      expect(domNode2.getAttribute('inputmode'), equals(null));
    });

    test('should clear attribute "inputmode" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), inputMode: 'some-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), inputMode: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('inputmode'), equals(null));
    });

    test('should not set attribute "inputmode" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), inputMode: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('inputmode'), equals(null));
    });

    test('should set messy "inputmode"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('widget-1'),
            inputMode: 'some inputmode',
          ),
          InputWeek(
            key: Key('widget-2'),
            inputMode: 'some "messy" inputmode',
          ),
          InputWeek(
            key: Key('widget-3'),
            inputMode: "some 'messy' inputmode",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('inputmode'),
        equals('some inputmode'),
      );

      expect(
        domNode2.getAttribute('inputmode'),
        equals('some "messy" inputmode'),
      );

      expect(
        domNode3.getAttribute('inputmode'),
        equals("some 'messy' inputmode"),
      );
    });

    test('should set tab index', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(
            key: Key('widget-1'),
            tabIndex: 1,
          ),
          InputWeek(
            key: Key('widget-2'),
            tabIndex: 2,
          ),
          InputWeek(
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

    test('should set property "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), value: '2022-W13'),
          InputWeek(key: Key('el-2'), value: '2022-W10'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect((domNode1 as InputElement).value, equals('2022-W13'));
      expect((domNode2 as InputElement).value, equals('2022-W10'));
    });

    test('should update property "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), value: '2022-W13'),
          InputWeek(key: Key('el-2'), value: '2022-W10'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), value: '2022-W24'),
          InputWeek(key: Key('el-2'), value: '2022-W10'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect((domNode1 as InputElement).value, equals('2022-W24'));
      expect((domNode2 as InputElement).value, equals('2022-W10'));
    });

    test('should clear property "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2'), value: '2022-W10'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1')),
          InputWeek(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect((domNode1 as InputElement).value, equals(''));
      expect((domNode2 as InputElement).value, equals(''));
    });

    test('should clear property "value" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), value: '2022-W13'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputWeek(key: Key('el-1'), value: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect((domNode1 as InputElement).value, equals(''));
    });

    test('should not set property "value" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputWeek(key: Key('el-1'), value: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect((domNode1 as InputElement).value, equals(''));
    });
  });
}
