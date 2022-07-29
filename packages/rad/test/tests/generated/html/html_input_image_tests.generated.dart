// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

void html_input_image_test() {
  group('HTML InputImage tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('some-key-1'), id: 'some-id-1'),
          InputImage(key: Key('some-key-2'), id: 'some-id-2'),
          InputImage(key: Key('some-key-3'), id: 'some-id-3'),
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
          InputImage(key: Key('some-key-1'), id: 'some-id-1'),
          InputImage(key: Key('some-key-2'), id: 'some-id-2'),
          InputImage(key: Key('some-key-3'), id: 'some-id-3'),
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
          InputImage(
            key: Key('some-key-1'),
            id: 'some-updated-id',
          ),
          InputImage(
            key: Key('some-key-2'),
            id: 'some-local-updated-id',
          ),
          InputImage(
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
          InputImage(
            key: Key('widget-1'),
            id: 'some id',
          ),
          InputImage(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          InputImage(
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
          InputImage(
            id: 'widget-1',
            children: [
              InputImage(
                id: 'widget-2',
              ),
              InputImage(
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
          InputImage(
            id: 'widget-1',
            child: InputImage(
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
          InputImage(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          InputImage(
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
          InputImage(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          InputImage(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(
            key: Key('el-1'),
            className: 'updated-classes',
          ),
          InputImage(
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
          InputImage(key: Key('el-1')),
          InputImage(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
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
          InputImage(
            key: Key('el-1'),
            className: 'some-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), className: null),
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
          InputImage(key: Key('el-1'), className: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(
            key: Key('widget-1'),
            className: 'some classes',
          ),
          InputImage(
            key: Key('widget-2'),
            className: 'some "messy" classes',
          ),
          InputImage(
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
          InputImage(key: Key('el-1'), hidden: false),
          InputImage(key: Key('el-2'), hidden: null),
          InputImage(key: Key('el-3'), hidden: true),
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
          InputImage(key: Key('el-1'), hidden: true),
          InputImage(key: Key('el-2'), hidden: true),
          InputImage(key: Key('el-3'), hidden: true),
          InputImage(key: Key('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), hidden: true),
          InputImage(key: Key('el-2'), hidden: false),
          InputImage(key: Key('el-3'), hidden: null),
          InputImage(key: Key('el-4')),
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
          InputImage(
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
          InputImage(
            key: Key('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          InputImage(
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
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), onClick: null),
          InputImage(key: Key('el-3'), onClick: listener),
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
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), onClick: listener),
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
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
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
          InputImage(key: Key('widget-1'), style: 'some style'),
          InputImage(key: Key('widget-2'), style: 'some "messy" style'),
          InputImage(key: Key('widget-3'), style: "some 'messy' style"),
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
          InputImage(key: Key('widget-1'), title: 'some title'),
          InputImage(key: Key('widget-2'), title: 'some "messy" title'),
          InputImage(key: Key('widget-3'), title: "some 'messy' title"),
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
          InputImage(key: Key('some-key-3')),
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
          InputImage(
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
          InputImage(
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
          InputImage(
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
          InputImage(
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
          InputImage(
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
          InputImage(
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
          InputImage(
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
          InputImage(
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
          InputImage(key: Key('some-key-1')),
          InputImage(key: Key('some-key-2')),
          InputImage(key: Key('some-key-3')),
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

    test('should set attribute "alt"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), alt: 'some-alt'),
          InputImage(key: Key('el-2'), alt: 'another-alt'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('alt'), equals('some-alt'));
      expect(domNode2.getAttribute('alt'), equals('another-alt'));
    });

    test('should update attribute "alt"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), alt: 'some-alt'),
          InputImage(key: Key('el-2'), alt: 'another-alt'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), alt: 'updated-alt'),
          InputImage(key: Key('el-2'), alt: 'another-alt'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('alt'), equals('updated-alt'));
      expect(domNode2.getAttribute('alt'), equals('another-alt'));
    });

    test('should clear attribute "alt"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), alt: 'another-alt'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('alt'), equals(null));
      expect(domNode2.getAttribute('alt'), equals(null));
    });

    test('should clear attribute "alt" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), alt: 'some-alt'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), alt: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('alt'), equals(null));
    });

    test('should not set attribute "alt" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), alt: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('alt'), equals(null));
    });

    test('should set messy "alt"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(
            key: Key('widget-1'),
            alt: 'some alt',
          ),
          InputImage(
            key: Key('widget-2'),
            alt: 'some "messy" alt',
          ),
          InputImage(
            key: Key('widget-3'),
            alt: "some 'messy' alt",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('alt'),
        equals('some alt'),
      );

      expect(
        domNode2.getAttribute('alt'),
        equals('some "messy" alt'),
      );

      expect(
        domNode3.getAttribute('alt'),
        equals("some 'messy' alt"),
      );
    });

    test('should set attribute "formaction"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formAction: 'some-formaction'),
          InputImage(key: Key('el-2'), formAction: 'another-formaction'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('formaction'), equals('some-formaction'));
      expect(domNode2.getAttribute('formaction'), equals('another-formaction'));
    });

    test('should update attribute "formaction"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formAction: 'some-formaction'),
          InputImage(key: Key('el-2'), formAction: 'another-formaction'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), formAction: 'updated-formaction'),
          InputImage(key: Key('el-2'), formAction: 'another-formaction'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('formaction'), equals('updated-formaction'));
      expect(domNode2.getAttribute('formaction'), equals('another-formaction'));
    });

    test('should clear attribute "formaction"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), formAction: 'another-formaction'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('formaction'), equals(null));
      expect(domNode2.getAttribute('formaction'), equals(null));
    });

    test('should clear attribute "formaction" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formAction: 'some-formaction'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), formAction: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('formaction'), equals(null));
    });

    test('should not set attribute "formaction" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formAction: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('formaction'), equals(null));
    });

    test('should set messy "formaction"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(
            key: Key('widget-1'),
            formAction: 'some formaction',
          ),
          InputImage(
            key: Key('widget-2'),
            formAction: 'some "messy" formaction',
          ),
          InputImage(
            key: Key('widget-3'),
            formAction: "some 'messy' formaction",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('formaction'),
        equals('some formaction'),
      );

      expect(
        domNode2.getAttribute('formaction'),
        equals('some "messy" formaction'),
      );

      expect(
        domNode3.getAttribute('formaction'),
        equals("some 'messy' formaction"),
      );
    });

    test('should set form attribute "formenctype"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formEncType: FormEncType.textPlain),
          InputImage(
              key: Key('el-2'), formEncType: FormEncType.multipartFormData),
          InputImage(
            key: Key('el-3'),
            formEncType: FormEncType.applicationXwwwFormUrlEncoded,
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(
        domNode1.getAttribute('formenctype'),
        equals('text/plain'),
      );
      expect(
        domNode2.getAttribute('formenctype'),
        equals('multipart/form-data'),
      );
      expect(
        domNode3.getAttribute('formenctype'),
        equals('application/x-www-form-urlencoded'),
      );
    });

    test('should update form attribute "formenctype"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formEncType: FormEncType.textPlain),
          InputImage(
              key: Key('el-2'), formEncType: FormEncType.multipartFormData),
          InputImage(
            key: Key('el-3'),
            formEncType: FormEncType.applicationXwwwFormUrlEncoded,
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), formEncType: null),
          InputImage(
              key: Key('el-3'), formEncType: FormEncType.multipartFormData),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('formenctype'), equals(null));
      expect(domNode2.getAttribute('formenctype'), equals(null));

      expect(
        domNode3.getAttribute('formenctype'),
        equals(FormEncType.multipartFormData.nativeValue),
      );
    });

    test('should set form attribute "formmethod"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formMethod: FormMethodType.get),
          InputImage(key: Key('el-2'), formMethod: FormMethodType.post),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(
        domNode1.getAttribute('formmethod'),
        equals(FormMethodType.get.nativeValue),
      );
      expect(
        domNode2.getAttribute('formmethod'),
        equals(FormMethodType.post.nativeValue),
      );
    });

    test('should update form attribute "formmethod"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formMethod: FormMethodType.get),
          InputImage(key: Key('el-2'), formMethod: FormMethodType.post),
          InputImage(key: Key('el-3'), formMethod: FormMethodType.get),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), formMethod: null),
          InputImage(key: Key('el-3'), formMethod: FormMethodType.post),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(
        domNode1.getAttribute('formmethod'),
        equals(null),
      );
      expect(
        domNode2.getAttribute('formmethod'),
        equals(null),
      );
      expect(
        domNode3.getAttribute('formmethod'),
        equals(FormMethodType.post.nativeValue),
      );
    });

    test('should set attribute "formtarget"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formTarget: 'some-formtarget'),
          InputImage(key: Key('el-2'), formTarget: 'another-formtarget'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('formtarget'), equals('some-formtarget'));
      expect(domNode2.getAttribute('formtarget'), equals('another-formtarget'));
    });

    test('should update attribute "formtarget"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formTarget: 'some-formtarget'),
          InputImage(key: Key('el-2'), formTarget: 'another-formtarget'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), formTarget: 'updated-formtarget'),
          InputImage(key: Key('el-2'), formTarget: 'another-formtarget'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('formtarget'), equals('updated-formtarget'));
      expect(domNode2.getAttribute('formtarget'), equals('another-formtarget'));
    });

    test('should clear attribute "formtarget"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), formTarget: 'another-formtarget'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('formtarget'), equals(null));
      expect(domNode2.getAttribute('formtarget'), equals(null));
    });

    test('should clear attribute "formtarget" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formTarget: 'some-formtarget'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), formTarget: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('formtarget'), equals(null));
    });

    test('should not set attribute "formtarget" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formTarget: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('formtarget'), equals(null));
    });

    test('should set attribute "formnovalidate" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formNoValidate: false),
          InputImage(key: Key('el-2'), formNoValidate: null),
          InputImage(key: Key('el-3'), formNoValidate: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('formnovalidate'), equals(null));
      expect(domNode2.getAttribute('formnovalidate'), equals(null));
      expect(domNode3.getAttribute('formnovalidate'), equals('true'));
    });

    test('should clear attribute "formnovalidate" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), formNoValidate: true),
          InputImage(key: Key('el-2'), formNoValidate: true),
          InputImage(key: Key('el-3'), formNoValidate: true),
          InputImage(key: Key('el-4'), formNoValidate: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), formNoValidate: true),
          InputImage(key: Key('el-2'), formNoValidate: false),
          InputImage(key: Key('el-3'), formNoValidate: null),
          InputImage(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('formnovalidate'), equals('true'));
      expect(domNode2.getAttribute('formnovalidate'), equals(null));
      expect(domNode3.getAttribute('formnovalidate'), equals(null));
      expect(domNode4.getAttribute('formnovalidate'), equals(null));
    });

    test('should set attribute "height"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), height: 'some-height'),
          InputImage(key: Key('el-2'), height: 'another-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('height'), equals('some-height'));
      expect(domNode2.getAttribute('height'), equals('another-height'));
    });

    test('should update attribute "height"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), height: 'some-height'),
          InputImage(key: Key('el-2'), height: 'another-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), height: 'updated-height'),
          InputImage(key: Key('el-2'), height: 'another-height'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('height'), equals('updated-height'));
      expect(domNode2.getAttribute('height'), equals('another-height'));
    });

    test('should clear attribute "height"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), height: 'another-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('height'), equals(null));
      expect(domNode2.getAttribute('height'), equals(null));
    });

    test('should clear attribute "height" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), height: 'some-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), height: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('height'), equals(null));
    });

    test('should not set attribute "height" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), height: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('height'), equals(null));
    });

    test('should set attribute "src"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), src: 'some-src'),
          InputImage(key: Key('el-2'), src: 'another-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('src'), equals('some-src'));
      expect(domNode2.getAttribute('src'), equals('another-src'));
    });

    test('should update attribute "src"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), src: 'some-src'),
          InputImage(key: Key('el-2'), src: 'another-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), src: 'updated-src'),
          InputImage(key: Key('el-2'), src: 'another-src'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('src'), equals('updated-src'));
      expect(domNode2.getAttribute('src'), equals('another-src'));
    });

    test('should clear attribute "src"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), src: 'another-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('src'), equals(null));
      expect(domNode2.getAttribute('src'), equals(null));
    });

    test('should clear attribute "src" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), src: 'some-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), src: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('src'), equals(null));
    });

    test('should not set attribute "src" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), src: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('src'), equals(null));
    });

    test('should set attribute "width"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), width: 'some-width'),
          InputImage(key: Key('el-2'), width: 'another-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('width'), equals('some-width'));
      expect(domNode2.getAttribute('width'), equals('another-width'));
    });

    test('should update attribute "width"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), width: 'some-width'),
          InputImage(key: Key('el-2'), width: 'another-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), width: 'updated-width'),
          InputImage(key: Key('el-2'), width: 'another-width'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('width'), equals('updated-width'));
      expect(domNode2.getAttribute('width'), equals('another-width'));
    });

    test('should clear attribute "width"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), width: 'another-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('width'), equals(null));
      expect(domNode2.getAttribute('width'), equals(null));
    });

    test('should clear attribute "width" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), width: 'some-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), width: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('width'), equals(null));
    });

    test('should not set attribute "width" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), width: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('width'), equals(null));
    });

    test('should set attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), name: 'some-name'),
          InputImage(key: Key('el-2'), name: 'another-name'),
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
          InputImage(key: Key('el-1'), name: 'some-name'),
          InputImage(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), name: 'updated-name'),
          InputImage(key: Key('el-2'), name: 'another-name'),
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
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
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
          InputImage(key: Key('el-1'), name: 'some-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), name: null),
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
          InputImage(key: Key('el-1'), name: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('name'), equals(null));
    });

    test('should set messy "name"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(
            key: Key('widget-1'),
            name: 'some name',
          ),
          InputImage(
            key: Key('widget-2'),
            name: 'some "messy" name',
          ),
          InputImage(
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
          InputImage(key: Key('el-1'), disabled: false),
          InputImage(key: Key('el-2'), disabled: null),
          InputImage(key: Key('el-3'), disabled: true),
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
          InputImage(key: Key('el-1'), disabled: true),
          InputImage(key: Key('el-2'), disabled: true),
          InputImage(key: Key('el-3'), disabled: true),
          InputImage(key: Key('el-4'), disabled: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), disabled: true),
          InputImage(key: Key('el-2'), disabled: false),
          InputImage(key: Key('el-3'), disabled: null),
          InputImage(key: Key('el-4')),
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
          InputImage(key: Key('el-1'), form: 'some-form'),
          InputImage(key: Key('el-2'), form: 'another-form'),
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
          InputImage(key: Key('el-1'), form: 'some-form'),
          InputImage(key: Key('el-2'), form: 'another-form'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), form: 'updated-form'),
          InputImage(key: Key('el-2'), form: 'another-form'),
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
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), form: 'another-form'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
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
          InputImage(key: Key('el-1'), form: 'some-form'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), form: null),
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
          InputImage(key: Key('el-1'), form: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('form'), equals(null));
    });

    test('should set messy "form"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(
            key: Key('widget-1'),
            form: 'some form',
          ),
          InputImage(
            key: Key('widget-2'),
            form: 'some "messy" form',
          ),
          InputImage(
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
          InputImage(key: Key('el-1'), inputMode: 'some-inputmode'),
          InputImage(key: Key('el-2'), inputMode: 'another-inputmode'),
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
          InputImage(key: Key('el-1'), inputMode: 'some-inputmode'),
          InputImage(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), inputMode: 'updated-inputmode'),
          InputImage(key: Key('el-2'), inputMode: 'another-inputmode'),
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
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), inputMode: 'another-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
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
          InputImage(key: Key('el-1'), inputMode: 'some-inputmode'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), inputMode: null),
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
          InputImage(key: Key('el-1'), inputMode: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('inputmode'), equals(null));
    });

    test('should set messy "inputmode"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(
            key: Key('widget-1'),
            inputMode: 'some inputmode',
          ),
          InputImage(
            key: Key('widget-2'),
            inputMode: 'some "messy" inputmode',
          ),
          InputImage(
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
          InputImage(
            key: Key('widget-1'),
            tabIndex: 1,
          ),
          InputImage(
            key: Key('widget-2'),
            tabIndex: 2,
          ),
          InputImage(
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

    test('should set attribute "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), value: 'some-value'),
          InputImage(key: Key('el-2'), value: 'another-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('value'), equals('some-value'));
      expect(domNode2.getAttribute('value'), equals('another-value'));
    });

    test('should update attribute "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), value: 'some-value'),
          InputImage(key: Key('el-2'), value: 'another-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), value: 'updated-value'),
          InputImage(key: Key('el-2'), value: 'another-value'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('value'), equals('updated-value'));
      expect(domNode2.getAttribute('value'), equals('another-value'));
    });

    test('should clear attribute "value"', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2'), value: 'another-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1')),
          InputImage(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('value'), equals(null));
      expect(domNode2.getAttribute('value'), equals(null));
    });

    test('should clear attribute "value" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), value: 'some-value'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          InputImage(key: Key('el-1'), value: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('value'), equals(null));
    });

    test('should not set attribute "value" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          InputImage(key: Key('el-1'), value: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('value'), equals(null));
    });
  });
}
