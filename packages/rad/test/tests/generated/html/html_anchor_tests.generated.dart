// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

void html_anchor_test() {
  group('HTML Anchor tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('some-key-1'), id: 'some-id-1'),
          Anchor(key: Key('some-key-2'), id: 'some-id-2'),
          Anchor(key: Key('some-key-3'), id: 'some-id-3'),
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
          Anchor(key: Key('some-key-1'), id: 'some-id-1'),
          Anchor(key: Key('some-key-2'), id: 'some-id-2'),
          Anchor(key: Key('some-key-3'), id: 'some-id-3'),
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
          Anchor(
            key: Key('some-key-1'),
            id: 'some-updated-id',
          ),
          Anchor(
            key: Key('some-key-2'),
            id: 'some-local-updated-id',
          ),
          Anchor(
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
          Anchor(
            key: Key('widget-1'),
            id: 'some id',
          ),
          Anchor(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          Anchor(
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
          Anchor(
            id: 'widget-1',
            children: [
              Anchor(
                id: 'widget-2',
              ),
              Anchor(
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
          Anchor(
            id: 'widget-1',
            child: Anchor(
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
          Anchor(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          Anchor(
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
          Anchor(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          Anchor(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(
            key: Key('el-1'),
            className: 'updated-classes',
          ),
          Anchor(
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
          Anchor(key: Key('el-1')),
          Anchor(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2')),
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
          Anchor(
            key: Key('el-1'),
            className: 'some-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), className: null),
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
          Anchor(key: Key('el-1'), className: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(
            key: Key('widget-1'),
            className: 'some classes',
          ),
          Anchor(
            key: Key('widget-2'),
            className: 'some "messy" classes',
          ),
          Anchor(
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
          Anchor(key: Key('el-1'), hidden: false),
          Anchor(key: Key('el-2'), hidden: null),
          Anchor(key: Key('el-3'), hidden: true),
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
          Anchor(key: Key('el-1'), hidden: true),
          Anchor(key: Key('el-2'), hidden: true),
          Anchor(key: Key('el-3'), hidden: true),
          Anchor(key: Key('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), hidden: true),
          Anchor(key: Key('el-2'), hidden: false),
          Anchor(key: Key('el-3'), hidden: null),
          Anchor(key: Key('el-4')),
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
          Anchor(
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
    });

    test('should set "click" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          Anchor(
            key: Key('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          Anchor(
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
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2'), onClick: null),
          Anchor(key: Key('el-3'), onClick: listener),
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

    test('should clear "click" event listner', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2'), onClick: listener),
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
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2')),
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
          Anchor(key: Key('widget-1'), style: 'some style'),
          Anchor(key: Key('widget-2'), style: 'some "messy" style'),
          Anchor(key: Key('widget-3'), style: "some 'messy' style"),
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
          Anchor(key: Key('widget-1'), title: 'some title'),
          Anchor(key: Key('widget-2'), title: 'some "messy" title'),
          Anchor(key: Key('widget-3'), title: "some 'messy' title"),
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
          Anchor(key: Key('some-key-3')),
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
          ].contains('a')
              ? [
                  'input',
                ].contains('a')
                  // becuase system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<a'
                  : '<a>'
              : '<a></a>',
        ),
      );
    });

    test(
        'should allow widget attributes to be set through additional attributes',
        () async {
      await app!.buildChildren(
        widgets: [
          Anchor(
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
          Anchor(
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
          Anchor(
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
          Anchor(
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
          Anchor(
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
          Anchor(
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

    test('should remove obsolute and add new data attributes on update',
        () async {
      await app!.buildChildren(
        widgets: [
          Anchor(
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
          Anchor(
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

    test('should have a short-tag alias', () async {
      var widget = Anchor();
      var widgetShort = a();

      expect(
        widget.runtimeType,
        equals(widgetShort.runtimeType),
      );
    });

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('some-key-1')),
          Anchor(key: Key('some-key-2')),
          Anchor(key: Key('some-key-3')),
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

    test('should set attribute "href"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), href: 'some-href'),
          Anchor(key: Key('el-2'), href: 'another-href'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('href'), equals('some-href'));
      expect(domNode2.getAttribute('href'), equals('another-href'));
    });

    test('should update attribute "href"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), href: 'some-href'),
          Anchor(key: Key('el-2'), href: 'another-href'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), href: 'updated-href'),
          Anchor(key: Key('el-2'), href: 'another-href'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('href'), equals('updated-href'));
      expect(domNode2.getAttribute('href'), equals('another-href'));
    });

    test('should clear attribute "href"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2'), href: 'another-href'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('href'), equals(null));
      expect(domNode2.getAttribute('href'), equals(null));
    });

    test('should clear attribute "href" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), href: 'some-href'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), href: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('href'), equals(null));
    });

    test('should not set attribute "href" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), href: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('href'), equals(null));
    });

    test('should set messy "href"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(
            key: Key('widget-1'),
            href: 'some href',
          ),
          Anchor(
            key: Key('widget-2'),
            href: 'some "messy" href',
          ),
          Anchor(
            key: Key('widget-3'),
            href: "some 'messy' href",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('href'),
        equals('some href'),
      );

      expect(
        domNode2.getAttribute('href'),
        equals('some "messy" href'),
      );

      expect(
        domNode3.getAttribute('href'),
        equals("some 'messy' href"),
      );
    });

    test('should set attribute "hreflang"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), hrefLang: 'some-hreflang'),
          Anchor(key: Key('el-2'), hrefLang: 'another-hreflang'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('hreflang'), equals('some-hreflang'));
      expect(domNode2.getAttribute('hreflang'), equals('another-hreflang'));
    });

    test('should update attribute "hreflang"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), hrefLang: 'some-hreflang'),
          Anchor(key: Key('el-2'), hrefLang: 'another-hreflang'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), hrefLang: 'updated-hreflang'),
          Anchor(key: Key('el-2'), hrefLang: 'another-hreflang'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('hreflang'), equals('updated-hreflang'));
      expect(domNode2.getAttribute('hreflang'), equals('another-hreflang'));
    });

    test('should clear attribute "hreflang"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2'), hrefLang: 'another-hreflang'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('hreflang'), equals(null));
      expect(domNode2.getAttribute('hreflang'), equals(null));
    });

    test('should clear attribute "hreflang" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), hrefLang: 'some-hreflang'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), hrefLang: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('hreflang'), equals(null));
    });

    test('should not set attribute "hreflang" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), hrefLang: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('hreflang'), equals(null));
    });

    test('should set messy "hreflang"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(
            key: Key('widget-1'),
            hrefLang: 'some hreflang',
          ),
          Anchor(
            key: Key('widget-2'),
            hrefLang: 'some "messy" hreflang',
          ),
          Anchor(
            key: Key('widget-3'),
            hrefLang: "some 'messy' hreflang",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('hreflang'),
        equals('some hreflang'),
      );

      expect(
        domNode2.getAttribute('hreflang'),
        equals('some "messy" hreflang'),
      );

      expect(
        domNode3.getAttribute('hreflang'),
        equals("some 'messy' hreflang"),
      );
    });

    test('should set attribute "ping"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), ping: 'some-ping'),
          Anchor(key: Key('el-2'), ping: 'another-ping'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('ping'), equals('some-ping'));
      expect(domNode2.getAttribute('ping'), equals('another-ping'));
    });

    test('should update attribute "ping"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), ping: 'some-ping'),
          Anchor(key: Key('el-2'), ping: 'another-ping'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), ping: 'updated-ping'),
          Anchor(key: Key('el-2'), ping: 'another-ping'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('ping'), equals('updated-ping'));
      expect(domNode2.getAttribute('ping'), equals('another-ping'));
    });

    test('should clear attribute "ping"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2'), ping: 'another-ping'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('ping'), equals(null));
      expect(domNode2.getAttribute('ping'), equals(null));
    });

    test('should clear attribute "ping" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), ping: 'some-ping'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), ping: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('ping'), equals(null));
    });

    test('should not set attribute "ping" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), ping: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('ping'), equals(null));
    });

    test('should set messy "ping"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(
            key: Key('widget-1'),
            ping: 'some ping',
          ),
          Anchor(
            key: Key('widget-2'),
            ping: 'some "messy" ping',
          ),
          Anchor(
            key: Key('widget-3'),
            ping: "some 'messy' ping",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('ping'),
        equals('some ping'),
      );

      expect(
        domNode2.getAttribute('ping'),
        equals('some "messy" ping'),
      );

      expect(
        domNode3.getAttribute('ping'),
        equals("some 'messy' ping"),
      );
    });

    test('should set attribute "referrerpolicy"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(
              key: Key('el-1'), referrerPolicy: ReferrerPolicyType.noReferrer),
          Anchor(
              key: Key('el-2'),
              referrerPolicy: ReferrerPolicyType.noReferrerWhenDowngrade),
          Anchor(key: Key('el-3'), referrerPolicy: ReferrerPolicyType.origin),
          Anchor(
              key: Key('el-4'),
              referrerPolicy: ReferrerPolicyType.originWhenCrossOrigin),
          Anchor(
              key: Key('el-5'), referrerPolicy: ReferrerPolicyType.sameOrigin),
          Anchor(
              key: Key('el-6'),
              referrerPolicy: ReferrerPolicyType.strictOrigin),
          Anchor(
              key: Key('el-7'),
              referrerPolicy: ReferrerPolicyType.strictOriginWhenCrossOrigin),
          Anchor(
              key: Key('el-8'), referrerPolicy: ReferrerPolicyType.unSafeUrl),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');
      var domNode5 = app!.domNodeByKeyValue('el-5');
      var domNode6 = app!.domNodeByKeyValue('el-6');
      var domNode7 = app!.domNodeByKeyValue('el-7');
      var domNode8 = app!.domNodeByKeyValue('el-8');

      expect(
        domNode1.getAttribute('referrerpolicy'),
        equals('no-referrer'),
      );
      expect(
        domNode2.getAttribute('referrerpolicy'),
        equals('no-referrer-when-downgrade'),
      );
      expect(
        domNode3.getAttribute('referrerpolicy'),
        equals('origin'),
      );
      expect(
        domNode4.getAttribute('referrerpolicy'),
        equals('origin-when-cross-origin'),
      );
      expect(
        domNode5.getAttribute('referrerpolicy'),
        equals('same-origin'),
      );
      expect(
        domNode6.getAttribute('referrerpolicy'),
        equals('strict-origin'),
      );
      expect(
        domNode7.getAttribute('referrerpolicy'),
        equals('strict-origin-when-cross-origin'),
      );
      expect(
        domNode8.getAttribute('referrerpolicy'),
        equals('unsafe-url'),
      );
    });

    test('should update attribute "referrerpolicy"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(
              key: Key('el-1'), referrerPolicy: ReferrerPolicyType.noReferrer),
          Anchor(
              key: Key('el-2'),
              referrerPolicy: ReferrerPolicyType.noReferrerWhenDowngrade),
          Anchor(key: Key('el-3'), referrerPolicy: ReferrerPolicyType.origin),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2'), referrerPolicy: null),
          Anchor(
              key: Key('el-3'),
              referrerPolicy: ReferrerPolicyType.originWhenCrossOrigin),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(
        domNode1.getAttribute('referrerpolicy'),
        equals(null),
      );
      expect(
        domNode2.getAttribute('referrerpolicy'),
        equals(null),
      );
      expect(
        domNode3.getAttribute('referrerpolicy'),
        equals(ReferrerPolicyType.originWhenCrossOrigin.nativeValue),
      );
    });

    test('should set attribute "rel"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), rel: 'some-rel'),
          Anchor(key: Key('el-2'), rel: 'another-rel'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('rel'), equals('some-rel'));
      expect(domNode2.getAttribute('rel'), equals('another-rel'));
    });

    test('should update attribute "rel"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), rel: 'some-rel'),
          Anchor(key: Key('el-2'), rel: 'another-rel'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), rel: 'updated-rel'),
          Anchor(key: Key('el-2'), rel: 'another-rel'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('rel'), equals('updated-rel'));
      expect(domNode2.getAttribute('rel'), equals('another-rel'));
    });

    test('should clear attribute "rel"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2'), rel: 'another-rel'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('rel'), equals(null));
      expect(domNode2.getAttribute('rel'), equals(null));
    });

    test('should clear attribute "rel" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), rel: 'some-rel'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), rel: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('rel'), equals(null));
    });

    test('should not set attribute "rel" if provided value is null', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), rel: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('rel'), equals(null));
    });

    test('should set attribute "target"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), target: 'some-target'),
          Anchor(key: Key('el-2'), target: 'another-target'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('target'), equals('some-target'));
      expect(domNode2.getAttribute('target'), equals('another-target'));
    });

    test('should update attribute "target"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), target: 'some-target'),
          Anchor(key: Key('el-2'), target: 'another-target'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), target: 'updated-target'),
          Anchor(key: Key('el-2'), target: 'another-target'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('target'), equals('updated-target'));
      expect(domNode2.getAttribute('target'), equals('another-target'));
    });

    test('should clear attribute "target"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2'), target: 'another-target'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('target'), equals(null));
      expect(domNode2.getAttribute('target'), equals(null));
    });

    test('should clear attribute "target" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), target: 'some-target'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), target: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('target'), equals(null));
    });

    test('should not set attribute "target" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), target: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('target'), equals(null));
    });

    test('should set attribute "download"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), download: 'some-download'),
          Anchor(key: Key('el-2'), download: 'another-download'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('download'), equals('some-download'));
      expect(domNode2.getAttribute('download'), equals('another-download'));
    });

    test('should update attribute "download"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), download: 'some-download'),
          Anchor(key: Key('el-2'), download: 'another-download'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), download: 'updated-download'),
          Anchor(key: Key('el-2'), download: 'another-download'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('download'), equals('updated-download'));
      expect(domNode2.getAttribute('download'), equals('another-download'));
    });

    test('should clear attribute "download"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2'), download: 'another-download'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('download'), equals(null));
      expect(domNode2.getAttribute('download'), equals(null));
    });

    test('should clear attribute "download" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), download: 'some-download'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), download: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('download'), equals(null));
    });

    test('should not set attribute "download" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), download: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('download'), equals(null));
    });

    test('should set messy "download"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(
            key: Key('widget-1'),
            download: 'some download',
          ),
          Anchor(
            key: Key('widget-2'),
            download: 'some "messy" download',
          ),
          Anchor(
            key: Key('widget-3'),
            download: "some 'messy' download",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('download'),
        equals('some download'),
      );

      expect(
        domNode2.getAttribute('download'),
        equals('some "messy" download'),
      );

      expect(
        domNode3.getAttribute('download'),
        equals("some 'messy' download"),
      );
    });

    test('should set attribute "type"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), type: 'some-type'),
          Anchor(key: Key('el-2'), type: 'another-type'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('type'), equals('some-type'));
      expect(domNode2.getAttribute('type'), equals('another-type'));
    });

    test('should update attribute "type"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), type: 'some-type'),
          Anchor(key: Key('el-2'), type: 'another-type'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), type: 'updated-type'),
          Anchor(key: Key('el-2'), type: 'another-type'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('type'), equals('updated-type'));
      expect(domNode2.getAttribute('type'), equals('another-type'));
    });

    test('should clear attribute "type"', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2'), type: 'another-type'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1')),
          Anchor(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('type'), equals(null));
      expect(domNode2.getAttribute('type'), equals(null));
    });

    test('should clear attribute "type" if updated type is null', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), type: 'some-type'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Anchor(key: Key('el-1'), type: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('type'), equals(null));
    });

    test('should not set attribute "type" if provided type is null', () async {
      await app!.buildChildren(
        widgets: [
          Anchor(key: Key('el-1'), type: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('type'), equals(null));
    });
  });
}
