// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

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
          InputText(key: Key('some-key-1'), id: 'some-id-1'),
          InputText(key: Key('some-key-2'), id: 'some-id-2'),
          InputText(key: Key('some-key-3'), id: 'some-id-3'),
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
          InputText(key: Key('some-key-1'), id: 'some-id-1'),
          InputText(key: Key('some-key-2'), id: 'some-id-2'),
          InputText(key: Key('some-key-3'), id: 'some-id-3'),
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
          InputText(
            key: Key('some-key-1'),
            id: 'some-updated-id',
          ),
          InputText(
            key: Key('some-key-2'),
            id: 'some-local-updated-id',
          ),
          InputText(
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
          InputText(
            key: Key('widget-1'),
            id: 'some id',
          ),
          InputText(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          InputText(
            key: Key('widget-3'),
            id: "some 'messy' id",
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

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
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = domNode1.childNodes[0] as HtmlElement;
      var domNode3 = domNode1.childNodes[1] as HtmlElement;

      expect(domNode1.id, equals('widget-1'));
      expect(domNode2.id, equals('widget-2'));
      expect(domNode3.id, equals('widget-3'));
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
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = domNode1.childNodes[0] as HtmlElement;

      expect(domNode1.id, equals('widget-1'));
      expect(domNode2.id, equals('widget-2'));
    });

    test('should set attribute "classes"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          InputText(
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
          InputText(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          InputText(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(
            key: Key('el-1'),
            className: 'updated-classes',
          ),
          InputText(
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
          InputText(key: Key('el-1')),
          InputText(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
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
          InputText(
            key: Key('el-1'),
            className: 'some-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), className: null),
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
          InputText(key: Key('el-1'), className: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            className: 'some classes',
          ),
          InputText(
            key: Key('widget-2'),
            className: 'some "messy" classes',
          ),
          InputText(
            key: Key('widget-3'),
            className: "some 'messy' classes",
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

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
          InputText(key: Key('el-1'), hidden: false),
          InputText(key: Key('el-2'), hidden: null),
          InputText(key: Key('el-3'), hidden: true),
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
          InputText(key: Key('el-1'), hidden: true),
          InputText(key: Key('el-2'), hidden: true),
          InputText(key: Key('el-3'), hidden: true),
          InputText(key: Key('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), hidden: true),
          InputText(key: Key('el-2'), hidden: false),
          InputText(key: Key('el-3'), hidden: null),
          InputText(key: Key('el-4')),
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
          InputText(
            key: Key('widget-1'),
            innerText: 'hello world',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;

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
          InputText(
            key: Key('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          InputText(
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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onClick: null),
          InputText(key: Key('el-3'), onClick: listener),
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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onClick: listener),
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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
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
          InputText(key: Key('widget-1'), style: 'some style'),
          InputText(key: Key('widget-2'), style: 'some "messy" style'),
          InputText(key: Key('widget-3'), style: "some 'messy' style"),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

      expect(domNode1.getAttribute('style'), equals('some style'));
      expect(domNode2.getAttribute('style'), equals('some "messy" style'));
      expect(domNode3.getAttribute('style'), equals("some 'messy' style"));
    });

    test('should set title', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('widget-1'), title: 'some title'),
          InputText(key: Key('widget-2'), title: 'some "messy" title'),
          InputText(key: Key('widget-3'), title: "some 'messy' title"),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

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
          InputText(id: 'some-id-1', ref: (el) => el1 = el),
          InputText(id: 'some-id-2', ref: (el) => el2 = el),
          InputText(id: 'some-id-3', ref: (el) => el3 = el),
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
          InputText(id: 'some-id-1', ref: (el) => el1 = el),
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
              InputText(id: 'some-id-1', ref: (el) => el1 = el),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [InputText()],
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
          InputText(ref: (el) {
            stack.push('callback');
          }),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(ref: (el) {
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
          InputText(key: Key('some-key-3')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(
        app!.appDomNode.innerHtml,
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
          InputText(
            key: Key('some-key-3'),
            additionalAttributes: {
              'id': 'some-id',
            },
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0];

      domNode1 as HtmlElement;

      expect(domNode1.id, equals('some-id'));
    });

    test(
        'should ignore additional attribute if already set in widget constructor',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(
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

      var domNode1 = app!.appDomNode.childNodes[0];

      domNode1 as HtmlElement;

      expect(domNode1.id, equals('some-id'));
      expect(domNode1.getAttribute('custom'), equals('applied'));
    });

    test(
        'should ignore additional attribute if already set in widget constructor, during updates',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(
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
          InputText(
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

      var domNode1 = app!.appDomNode.childNodes[0];

      domNode1 as HtmlElement;

      expect(domNode1.id, equals('updated-id'));
    });

    test('should set data attributes', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('some-key-3'),
            additionalAttributes: {
              'data-something': 'something okay',
              'data-another': 'another okay',
            },
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;

      expect(domNode1.dataset['something'], equals('something okay'));
      expect(domNode1.dataset['another'], equals('another okay'));
    });

    test('should set aria/any attributes', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('some-key-3'),
            additionalAttributes: {
              'aria-something': 'something okay',
              'any-another': 'another okay',
            },
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;

      expect(domNode1.getAttribute('aria-something'), equals('something okay'));
      expect(domNode1.getAttribute('any-another'), equals('another okay'));
    });

    test('should remove obsolete and add new data attributes on update',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(
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
          InputText(
            key: Key('some-key-3'),
            additionalAttributes: {
              'data-something-new': 'something new',
            },
          ),
        ],
        updateType: UpdateType.undefined,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0];

      domNode1 as HtmlElement;

      expect(domNode1.dataset['something'], equals(null));
      expect(domNode1.dataset['something-new'], equals('something new'));
    });

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('some-key-1')),
          InputText(key: Key('some-key-2')),
          InputText(key: Key('some-key-3')),
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
          InputText(key: Key('el-1'), autoComplete: 'some-autocomplete'),
          InputText(key: Key('el-2'), autoComplete: 'another-autocomplete'),
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
          InputText(key: Key('el-1'), autoComplete: 'some-autocomplete'),
          InputText(key: Key('el-2'), autoComplete: 'another-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), autoComplete: 'updated-autocomplete'),
          InputText(key: Key('el-2'), autoComplete: 'another-autocomplete'),
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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), autoComplete: 'another-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
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
          InputText(key: Key('el-1'), autoComplete: 'some-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), autoComplete: null),
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
          InputText(key: Key('el-1'), autoComplete: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('autocomplete'), equals(null));
    });

    test('should set attribute "dirname"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), dirName: 'some-dirname'),
          InputText(key: Key('el-2'), dirName: 'another-dirname'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('dirname'), equals('some-dirname'));
      expect(domNode2.getAttribute('dirname'), equals('another-dirname'));
    });

    test('should update attribute "dirname"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), dirName: 'some-dirname'),
          InputText(key: Key('el-2'), dirName: 'another-dirname'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), dirName: 'updated-dirname'),
          InputText(key: Key('el-2'), dirName: 'another-dirname'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('dirname'), equals('updated-dirname'));
      expect(domNode2.getAttribute('dirname'), equals('another-dirname'));
    });

    test('should clear attribute "dirname"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), dirName: 'another-dirname'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('dirname'), equals(null));
      expect(domNode2.getAttribute('dirname'), equals(null));
    });

    test('should clear attribute "dirname" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), dirName: 'some-dirname'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), dirName: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('dirname'), equals(null));
    });

    test('should not set attribute "dirname" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), dirName: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('dirname'), equals(null));
    });

    test('should set messy "dirname"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            dirName: 'some dirname',
          ),
          InputText(
            key: Key('widget-2'),
            dirName: 'some "messy" dirname',
          ),
          InputText(
            key: Key('widget-3'),
            dirName: "some 'messy' dirname",
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('dirname'),
        equals('some dirname'),
      );

      expect(
        domNode2.getAttribute('dirname'),
        equals('some "messy" dirname'),
      );

      expect(
        domNode3.getAttribute('dirname'),
        equals("some 'messy' dirname"),
      );
    });

    test('should set attribute "list"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), list: 'some-list'),
          InputText(key: Key('el-2'), list: 'another-list'),
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
          InputText(key: Key('el-1'), list: 'some-list'),
          InputText(key: Key('el-2'), list: 'another-list'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), list: 'updated-list'),
          InputText(key: Key('el-2'), list: 'another-list'),
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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), list: 'another-list'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
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
          InputText(key: Key('el-1'), list: 'some-list'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), list: null),
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
          InputText(key: Key('el-1'), list: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('list'), equals(null));
    });

    test('should set messy "list"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            list: 'some list',
          ),
          InputText(
            key: Key('widget-2'),
            list: 'some "messy" list',
          ),
          InputText(
            key: Key('widget-3'),
            list: "some 'messy' list",
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

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

    test('should set attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), maxLength: 10),
          InputText(key: Key('el-2'), maxLength: 0),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('maxlength'), equals('10'));
      expect(domNode2.getAttribute('maxlength'), equals('0'));
    });

    test('should update attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), maxLength: 10),
          InputText(key: Key('el-2'), maxLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), maxLength: 20),
          InputText(key: Key('el-2'), maxLength: 20),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('maxlength'), equals('20'));
      expect(domNode2.getAttribute('maxlength'), equals('20'));
    });

    test('should clear attribute "maxLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), maxLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('maxlength'), equals(null));
      expect(domNode2.getAttribute('maxlength'), equals(null));
    });

    test('should clear attribute "maxLength" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), maxLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), maxLength: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('maxlength'), equals(null));
    });

    test('should not set attribute "maxLength" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), maxLength: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('maxlength'), equals(null));
    });

    test('should set attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), minLength: 10),
          InputText(key: Key('el-2'), minLength: 0),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('minlength'), equals('10'));
      expect(domNode2.getAttribute('minlength'), equals('0'));
    });

    test('should update attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), minLength: 10),
          InputText(key: Key('el-2'), minLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), minLength: 20),
          InputText(key: Key('el-2'), minLength: 20),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('minlength'), equals('20'));
      expect(domNode2.getAttribute('minlength'), equals('20'));
    });

    test('should clear attribute "minLength"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), minLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('minlength'), equals(null));
      expect(domNode2.getAttribute('minlength'), equals(null));
    });

    test('should clear attribute "minLength" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), minLength: 10),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), minLength: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('minlength'), equals(null));
    });

    test('should not set attribute "minLength" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), minLength: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('minlength'), equals(null));
    });

    test('should set attribute "pattern"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), pattern: 'some-pattern'),
          InputText(key: Key('el-2'), pattern: 'another-pattern'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('pattern'), equals('some-pattern'));
      expect(domNode2.getAttribute('pattern'), equals('another-pattern'));
    });

    test('should update attribute "pattern"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), pattern: 'some-pattern'),
          InputText(key: Key('el-2'), pattern: 'another-pattern'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), pattern: 'updated-pattern'),
          InputText(key: Key('el-2'), pattern: 'another-pattern'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('pattern'), equals('updated-pattern'));
      expect(domNode2.getAttribute('pattern'), equals('another-pattern'));
    });

    test('should clear attribute "pattern"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), pattern: 'another-pattern'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('pattern'), equals(null));
      expect(domNode2.getAttribute('pattern'), equals(null));
    });

    test('should clear attribute "pattern" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), pattern: 'some-pattern'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), pattern: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('pattern'), equals(null));
    });

    test('should not set attribute "pattern" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), pattern: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('pattern'), equals(null));
    });

    test('should set attribute "placeholder"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), placeholder: 'some-placeholder'),
          InputText(key: Key('el-2'), placeholder: 'another-placeholder'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('placeholder'), equals('some-placeholder'));
      expect(
          domNode2.getAttribute('placeholder'), equals('another-placeholder'));
    });

    test('should update attribute "placeholder"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), placeholder: 'some-placeholder'),
          InputText(key: Key('el-2'), placeholder: 'another-placeholder'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), placeholder: 'updated-placeholder'),
          InputText(key: Key('el-2'), placeholder: 'another-placeholder'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(
          domNode1.getAttribute('placeholder'), equals('updated-placeholder'));
      expect(
          domNode2.getAttribute('placeholder'), equals('another-placeholder'));
    });

    test('should clear attribute "placeholder"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), placeholder: 'another-placeholder'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('placeholder'), equals(null));
      expect(domNode2.getAttribute('placeholder'), equals(null));
    });

    test('should clear attribute "placeholder" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), placeholder: 'some-placeholder'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), placeholder: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('placeholder'), equals(null));
    });

    test('should not set attribute "placeholder" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), placeholder: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('placeholder'), equals(null));
    });

    test('should set attribute "readonly" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), readOnly: false),
          InputText(key: Key('el-2'), readOnly: null),
          InputText(key: Key('el-3'), readOnly: true),
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
          InputText(key: Key('el-1'), readOnly: true),
          InputText(key: Key('el-2'), readOnly: true),
          InputText(key: Key('el-3'), readOnly: true),
          InputText(key: Key('el-4'), readOnly: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), readOnly: true),
          InputText(key: Key('el-2'), readOnly: false),
          InputText(key: Key('el-3'), readOnly: null),
          InputText(key: Key('el-4')),
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
          InputText(key: Key('el-1'), required: false),
          InputText(key: Key('el-2'), required: null),
          InputText(key: Key('el-3'), required: true),
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
          InputText(key: Key('el-1'), required: true),
          InputText(key: Key('el-2'), required: true),
          InputText(key: Key('el-3'), required: true),
          InputText(key: Key('el-4'), required: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), required: true),
          InputText(key: Key('el-2'), required: false),
          InputText(key: Key('el-3'), required: null),
          InputText(key: Key('el-4')),
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

    test('should set attribute "size"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), size: 'some-size'),
          InputText(key: Key('el-2'), size: 'another-size'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('size'), equals('some-size'));
      expect(domNode2.getAttribute('size'), equals('another-size'));
    });

    test('should update attribute "size"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), size: 'some-size'),
          InputText(key: Key('el-2'), size: 'another-size'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), size: 'updated-size'),
          InputText(key: Key('el-2'), size: 'another-size'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('size'), equals('updated-size'));
      expect(domNode2.getAttribute('size'), equals('another-size'));
    });

    test('should clear attribute "size"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), size: 'another-size'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('size'), equals(null));
      expect(domNode2.getAttribute('size'), equals(null));
    });

    test('should clear attribute "size" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), size: 'some-size'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), size: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('size'), equals(null));
    });

    test('should not set attribute "size" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), size: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('size'), equals(null));
    });

    test('should set messy "size"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            size: 'some size',
          ),
          InputText(
            key: Key('widget-2'),
            size: 'some "messy" size',
          ),
          InputText(
            key: Key('widget-3'),
            size: "some 'messy' size",
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('size'),
        equals('some size'),
      );

      expect(
        domNode2.getAttribute('size'),
        equals('some "messy" size'),
      );

      expect(
        domNode3.getAttribute('size'),
        equals("some 'messy' size"),
      );
    });

    test('should set "change" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('el-1'),
            onChange: (event) => testStack.push('change-1'),
          ),
          InputText(
            key: Key('el-2'),
            onChange: (event) => testStack.push('change-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('el-1').dispatchEvent(Event('change'));
      app!.domNodeByKeyValue('el-2').dispatchEvent(Event('change'));

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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onChange: null),
          InputText(key: Key('el-3'), onChange: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.change], equals(null));
      expect(listeners2[DomEventType.change], equals(null));
      expect(listeners3[DomEventType.change], equals(listener));
    });

    test('should clear "change" event listener', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onChange: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.change], equals(null));
      expect(listeners2[DomEventType.change], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.change], equals(null));
      expect(listeners2[DomEventType.change], equals(null));
    });

    test('should set "input" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('el-1'),
            onInput: (event) => testStack.push('input-1'),
          ),
          InputText(
            key: Key('el-2'),
            onInput: (event) => testStack.push('input-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('el-1').dispatchEvent(Event('input'));
      app!.domNodeByKeyValue('el-2').dispatchEvent(Event('input'));

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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onInput: null),
          InputText(key: Key('el-3'), onInput: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.input], equals(null));
      expect(listeners2[DomEventType.input], equals(null));
      expect(listeners3[DomEventType.input], equals(listener));
    });

    test('should clear "input" event listener', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onInput: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.input], equals(null));
      expect(listeners2[DomEventType.input], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.input], equals(null));
      expect(listeners2[DomEventType.input], equals(null));
    });

    test('should set "KeyPress" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('el-1'),
            onKeyPress: (event) => testStack.push('keypress-1'),
          ),
          InputText(
            key: Key('el-2'),
            onKeyPress: (event) => testStack.push('keypress-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('el-1').dispatchEvent(Event('keypress'));
      app!.domNodeByKeyValue('el-2').dispatchEvent(Event('keypress'));

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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onKeyPress: null),
          InputText(key: Key('el-3'), onKeyPress: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.keyPress], equals(null));
      expect(listeners2[DomEventType.keyPress], equals(null));
      expect(listeners3[DomEventType.keyPress], equals(listener));
    });

    test('should clear "KeyPress" event listener', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onKeyPress: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyPress], equals(null));
      expect(listeners2[DomEventType.keyPress], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyPress], equals(null));
      expect(listeners2[DomEventType.keyPress], equals(null));
    });

    test('should set "KeyUp" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('el-1'),
            onKeyUp: (event) => testStack.push('keyup-1'),
          ),
          InputText(
            key: Key('el-2'),
            onKeyUp: (event) => testStack.push('keyup-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('el-1').dispatchEvent(Event('keyup'));
      app!.domNodeByKeyValue('el-2').dispatchEvent(Event('keyup'));

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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onKeyUp: null),
          InputText(key: Key('el-3'), onKeyUp: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.keyUp], equals(null));
      expect(listeners2[DomEventType.keyUp], equals(null));
      expect(listeners3[DomEventType.keyUp], equals(listener));
    });

    test('should clear "KeyUp" event listener', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onKeyUp: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyUp], equals(null));
      expect(listeners2[DomEventType.keyUp], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyUp], equals(null));
      expect(listeners2[DomEventType.keyUp], equals(null));
    });

    test('should set "KeyDown" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('el-1'),
            onKeyDown: (event) => testStack.push('keydown-1'),
          ),
          InputText(
            key: Key('el-2'),
            onKeyDown: (event) => testStack.push('keydown-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('el-1').dispatchEvent(Event('keydown'));
      app!.domNodeByKeyValue('el-2').dispatchEvent(Event('keydown'));

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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onKeyDown: null),
          InputText(key: Key('el-3'), onKeyDown: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.keyDown], equals(null));
      expect(listeners2[DomEventType.keyDown], equals(null));
      expect(listeners3[DomEventType.keyDown], equals(listener));
    });

    test('should clear "KeyDown" event listener', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), onKeyDown: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyDown], equals(null));
      expect(listeners2[DomEventType.keyDown], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.keyDown], equals(null));
      expect(listeners2[DomEventType.keyDown], equals(null));
    });

    test('should set attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), name: 'some-name'),
          InputText(key: Key('el-2'), name: 'another-name'),
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
          InputText(key: Key('el-1'), name: 'some-name'),
          InputText(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), name: 'updated-name'),
          InputText(key: Key('el-2'), name: 'another-name'),
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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
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
          InputText(key: Key('el-1'), name: 'some-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), name: null),
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
          InputText(key: Key('el-1'), name: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('name'), equals(null));
    });

    test('should set messy "name"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            name: 'some name',
          ),
          InputText(
            key: Key('widget-2'),
            name: 'some "messy" name',
          ),
          InputText(
            key: Key('widget-3'),
            name: "some 'messy' name",
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

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
          InputText(key: Key('el-1'), disabled: false),
          InputText(key: Key('el-2'), disabled: null),
          InputText(key: Key('el-3'), disabled: true),
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
          InputText(key: Key('el-1'), disabled: true),
          InputText(key: Key('el-2'), disabled: true),
          InputText(key: Key('el-3'), disabled: true),
          InputText(key: Key('el-4'), disabled: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), disabled: true),
          InputText(key: Key('el-2'), disabled: false),
          InputText(key: Key('el-3'), disabled: null),
          InputText(key: Key('el-4')),
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
          InputText(key: Key('el-1'), form: 'some-form'),
          InputText(key: Key('el-2'), form: 'another-form'),
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
          InputText(key: Key('el-1'), form: 'some-form'),
          InputText(key: Key('el-2'), form: 'another-form'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), form: 'updated-form'),
          InputText(key: Key('el-2'), form: 'another-form'),
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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), form: 'another-form'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
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
          InputText(key: Key('el-1'), form: 'some-form'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), form: null),
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
          InputText(key: Key('el-1'), form: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('form'), equals(null));
    });

    test('should set messy "form"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            form: 'some form',
          ),
          InputText(
            key: Key('widget-2'),
            form: 'some "messy" form',
          ),
          InputText(
            key: Key('widget-3'),
            form: "some 'messy' form",
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

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
          InputText(key: Key('el-1'), inputMode: 'some-inputmode'),
          InputText(key: Key('el-2'), inputMode: 'another-inputmode'),
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
          InputText(key: Key('el-1'), inputMode: 'some-inputmode'),
          InputText(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), inputMode: 'updated-inputmode'),
          InputText(key: Key('el-2'), inputMode: 'another-inputmode'),
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
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
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
          InputText(key: Key('el-1'), inputMode: 'some-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), inputMode: null),
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
          InputText(key: Key('el-1'), inputMode: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('inputmode'), equals(null));
    });

    test('should set messy "inputmode"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(
            key: Key('widget-1'),
            inputMode: 'some inputmode',
          ),
          InputText(
            key: Key('widget-2'),
            inputMode: 'some "messy" inputmode',
          ),
          InputText(
            key: Key('widget-3'),
            inputMode: "some 'messy' inputmode",
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

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
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

      expect(domNode1.getAttribute('tabindex'), equals('1'));
      expect(domNode2.getAttribute('tabindex'), equals('2'));
      expect(domNode3.getAttribute('tabindex'), equals('3'));
    });

    test('should set property "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), value: 'some-value'),
          InputText(key: Key('el-2'), value: 'another-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect((domNode1 as InputElement).value, equals('some-value'));
      expect((domNode2 as InputElement).value, equals('another-value'));
    });

    test('should update property "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1'), value: 'some-value'),
          InputText(key: Key('el-2'), value: 'another-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), value: 'updated-value'),
          InputText(key: Key('el-2'), value: 'another-value'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect((domNode1 as InputElement).value, equals('updated-value'));
      expect((domNode2 as InputElement).value, equals('another-value'));
    });

    test('should clear property "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2'), value: 'another-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1')),
          InputText(key: Key('el-2')),
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
          InputText(key: Key('el-1'), value: 'some-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputText(key: Key('el-1'), value: null),
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
          InputText(key: Key('el-1'), value: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect((domNode1 as InputElement).value, equals(''));
    });
  });
}
