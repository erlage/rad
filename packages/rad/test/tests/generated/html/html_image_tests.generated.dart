// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

void html_image_test() {
  group('HTML Image tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('some-key-1'), id: 'some-id-1'),
          Image(key: Key('some-key-2'), id: 'some-id-2'),
          Image(key: Key('some-key-3'), id: 'some-id-3'),
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
          Image(key: Key('some-key-1'), id: 'some-id-1'),
          Image(key: Key('some-key-2'), id: 'some-id-2'),
          Image(key: Key('some-key-3'), id: 'some-id-3'),
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
          Image(
            key: Key('some-key-1'),
            id: 'some-updated-id',
          ),
          Image(
            key: Key('some-key-2'),
            id: 'some-local-updated-id',
          ),
          Image(
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
          Image(
            key: Key('widget-1'),
            id: 'some id',
          ),
          Image(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          Image(
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
          Image(
            id: 'widget-1',
            children: [
              Image(
                id: 'widget-2',
              ),
              Image(
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
          Image(
            id: 'widget-1',
            child: Image(
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
          Image(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          Image(
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
          Image(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          Image(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(
            key: Key('el-1'),
            className: 'updated-classes',
          ),
          Image(
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
          Image(key: Key('el-1')),
          Image(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2')),
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
          Image(
            key: Key('el-1'),
            className: 'some-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), className: null),
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
          Image(key: Key('el-1'), className: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          Image(
            key: Key('widget-1'),
            className: 'some classes',
          ),
          Image(
            key: Key('widget-2'),
            className: 'some "messy" classes',
          ),
          Image(
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
          Image(key: Key('el-1'), hidden: false),
          Image(key: Key('el-2'), hidden: null),
          Image(key: Key('el-3'), hidden: true),
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
          Image(key: Key('el-1'), hidden: true),
          Image(key: Key('el-2'), hidden: true),
          Image(key: Key('el-3'), hidden: true),
          Image(key: Key('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), hidden: true),
          Image(key: Key('el-2'), hidden: false),
          Image(key: Key('el-3'), hidden: null),
          Image(key: Key('el-4')),
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
          Image(
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
      'chrome': Skip('Failing for img on chrome'),
    });

    test('should set "click" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          Image(
            key: Key('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          Image(
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
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), onClick: null),
          Image(key: Key('el-3'), onClick: listener),
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
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), onClick: listener),
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
          Image(key: Key('el-1')),
          Image(key: Key('el-2')),
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
          Image(key: Key('widget-1'), style: 'some style'),
          Image(key: Key('widget-2'), style: 'some "messy" style'),
          Image(key: Key('widget-3'), style: "some 'messy' style"),
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
          Image(key: Key('widget-1'), title: 'some title'),
          Image(key: Key('widget-2'), title: 'some "messy" title'),
          Image(key: Key('widget-3'), title: "some 'messy' title"),
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
          Image(id: 'some-id-1', ref: (el) => el1 = el),
          Image(id: 'some-id-2', ref: (el) => el2 = el),
          Image(id: 'some-id-3', ref: (el) => el3 = el),
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
          Image(id: 'some-id-1', ref: (el) => el1 = el),
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
              Image(id: 'some-id-1', ref: (el) => el1 = el),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [Image()],
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
          Image(ref: (el) {
            stack.push('callback');
          }),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(ref: (el) {
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
          Image(key: Key('some-key-3')),
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
          ].contains('img')
              ? [
                  'input',
                ].contains('img')
                  // because system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<img'
                  : '<img>'
              : '<img></img>',
        ),
      );
    });

    test(
        'should allow widget attributes to be set through additional attributes',
        () async {
      await app!.buildChildren(
        widgets: [
          Image(
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
          Image(
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
          Image(
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
          Image(
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
          Image(
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
          Image(
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
          Image(
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
          Image(
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
      var widget = Image();
      var widgetShort = img();

      expect(
        widget.runtimeType,
        equals(widgetShort.runtimeType),
      );
    });

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('some-key-1')),
          Image(key: Key('some-key-2')),
          Image(key: Key('some-key-3')),
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

    test('should set attribute "src"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), src: 'some-src'),
          Image(key: Key('el-2'), src: 'another-src'),
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
          Image(key: Key('el-1'), src: 'some-src'),
          Image(key: Key('el-2'), src: 'another-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), src: 'updated-src'),
          Image(key: Key('el-2'), src: 'another-src'),
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
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), src: 'another-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2')),
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
          Image(key: Key('el-1'), src: 'some-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), src: null),
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
          Image(key: Key('el-1'), src: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('src'), equals(null));
    });

    test('should set attribute "alt"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), alt: 'some-alt'),
          Image(key: Key('el-2'), alt: 'another-alt'),
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
          Image(key: Key('el-1'), alt: 'some-alt'),
          Image(key: Key('el-2'), alt: 'another-alt'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), alt: 'updated-alt'),
          Image(key: Key('el-2'), alt: 'another-alt'),
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
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), alt: 'another-alt'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2')),
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
          Image(key: Key('el-1'), alt: 'some-alt'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), alt: null),
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
          Image(key: Key('el-1'), alt: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('alt'), equals(null));
    });

    test('should set messy "alt"', () async {
      await app!.buildChildren(
        widgets: [
          Image(
            key: Key('widget-1'),
            alt: 'some alt',
          ),
          Image(
            key: Key('widget-2'),
            alt: 'some "messy" alt',
          ),
          Image(
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

    test('should set form attribute "crossorigin"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), crossOrigin: CrossOriginType.anonymous),
          Image(key: Key('el-2'), crossOrigin: CrossOriginType.useCredentials),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(
        domNode1.getAttribute('crossorigin'),
        equals(CrossOriginType.anonymous.nativeValue),
      );
      expect(
        domNode2.getAttribute('crossorigin'),
        equals(CrossOriginType.useCredentials.nativeValue),
      );
    });

    test('should update form attribute "crossorigin"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), crossOrigin: CrossOriginType.anonymous),
          Image(key: Key('el-2'), crossOrigin: CrossOriginType.useCredentials),
          Image(key: Key('el-3'), crossOrigin: CrossOriginType.anonymous),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), crossOrigin: null),
          Image(key: Key('el-3'), crossOrigin: CrossOriginType.useCredentials),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(
        domNode1.getAttribute('crossorigin'),
        equals(null),
      );
      expect(
        domNode2.getAttribute('crossorigin'),
        equals(null),
      );
      expect(
        domNode3.getAttribute('crossorigin'),
        equals(CrossOriginType.useCredentials.nativeValue),
      );
    });

    test('should set ordered list attribute "decoding"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), decoding: DecodingType.sync),
          Image(key: Key('el-2'), decoding: DecodingType.async),
          Image(key: Key('el-3'), decoding: DecodingType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(
        domNode1.getAttribute('decoding'),
        equals(DecodingType.sync.nativeValue),
      );
      expect(
        domNode2.getAttribute('decoding'),
        equals(DecodingType.async.nativeValue),
      );
      expect(
        domNode3.getAttribute('decoding'),
        equals(DecodingType.auto.nativeValue),
      );
    });

    test('should update ordered list attribute "decoding"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), decoding: DecodingType.sync),
          Image(key: Key('el-2'), decoding: DecodingType.async),
          Image(key: Key('el-3'), decoding: DecodingType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), decoding: null),
          Image(key: Key('el-3'), decoding: DecodingType.sync),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(
        domNode1.getAttribute('decoding'),
        equals(null),
      );
      expect(
        domNode2.getAttribute('decoding'),
        equals(null),
      );
      expect(
        domNode3.getAttribute('decoding'),
        equals(DecodingType.sync.nativeValue),
      );
    });

    test('should set attribute "fetchpriority"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), fetchPriority: FetchPriorityType.high),
          Image(key: Key('el-2'), fetchPriority: FetchPriorityType.low),
          Image(key: Key('el-3'), fetchPriority: FetchPriorityType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('fetchpriority'), equals('high'));
      expect(domNode2.getAttribute('fetchpriority'), equals('low'));
      expect(domNode3.getAttribute('fetchpriority'), equals('auto'));
    });

    test('should update attribute "fetchpriority"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), fetchPriority: FetchPriorityType.high),
          Image(key: Key('el-2'), fetchPriority: FetchPriorityType.low),
          Image(key: Key('el-3'), fetchPriority: FetchPriorityType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), fetchPriority: null),
          Image(key: Key('el-3'), fetchPriority: FetchPriorityType.high),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('fetchpriority'), equals(null));
      expect(domNode2.getAttribute('fetchpriority'), equals(null));
      expect(domNode3.getAttribute('fetchpriority'), equals('high'));
    });

    test('should set form attribute "loading"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), loading: LoadingType.eager),
          Image(key: Key('el-2'), loading: LoadingType.lazy),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(
        domNode1.getAttribute('loading'),
        equals(LoadingType.eager.nativeValue),
      );
      expect(
        domNode2.getAttribute('loading'),
        equals(LoadingType.lazy.nativeValue),
      );
    });

    test('should update form attribute "loading"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), loading: LoadingType.eager),
          Image(key: Key('el-2'), loading: LoadingType.lazy),
          Image(key: Key('el-3'), loading: LoadingType.eager),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), loading: null),
          Image(key: Key('el-3'), loading: LoadingType.lazy),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(
        domNode1.getAttribute('loading'),
        equals(null),
      );
      expect(
        domNode2.getAttribute('loading'),
        equals(null),
      );
      expect(
        domNode3.getAttribute('loading'),
        equals(LoadingType.lazy.nativeValue),
      );
    });

    test('should set attribute "referrerpolicy"', () async {
      await app!.buildChildren(
        widgets: [
          Image(
              key: Key('el-1'), referrerPolicy: ReferrerPolicyType.noReferrer),
          Image(
              key: Key('el-2'),
              referrerPolicy: ReferrerPolicyType.noReferrerWhenDowngrade),
          Image(key: Key('el-3'), referrerPolicy: ReferrerPolicyType.origin),
          Image(
              key: Key('el-4'),
              referrerPolicy: ReferrerPolicyType.originWhenCrossOrigin),
          Image(
              key: Key('el-5'), referrerPolicy: ReferrerPolicyType.sameOrigin),
          Image(
              key: Key('el-6'),
              referrerPolicy: ReferrerPolicyType.strictOrigin),
          Image(
              key: Key('el-7'),
              referrerPolicy: ReferrerPolicyType.strictOriginWhenCrossOrigin),
          Image(key: Key('el-8'), referrerPolicy: ReferrerPolicyType.unSafeUrl),
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
          Image(
              key: Key('el-1'), referrerPolicy: ReferrerPolicyType.noReferrer),
          Image(
              key: Key('el-2'),
              referrerPolicy: ReferrerPolicyType.noReferrerWhenDowngrade),
          Image(key: Key('el-3'), referrerPolicy: ReferrerPolicyType.origin),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), referrerPolicy: null),
          Image(
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

    test('should set attribute "srcset"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), srcSet: 'some-srcset'),
          Image(key: Key('el-2'), srcSet: 'another-srcset'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('srcset'), equals('some-srcset'));
      expect(domNode2.getAttribute('srcset'), equals('another-srcset'));
    });

    test('should update attribute "srcset"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), srcSet: 'some-srcset'),
          Image(key: Key('el-2'), srcSet: 'another-srcset'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), srcSet: 'updated-srcset'),
          Image(key: Key('el-2'), srcSet: 'another-srcset'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('srcset'), equals('updated-srcset'));
      expect(domNode2.getAttribute('srcset'), equals('another-srcset'));
    });

    test('should clear attribute "srcset"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), srcSet: 'another-srcset'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('srcset'), equals(null));
      expect(domNode2.getAttribute('srcset'), equals(null));
    });

    test('should clear attribute "srcset" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), srcSet: 'some-srcset'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), srcSet: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('srcset'), equals(null));
    });

    test('should not set attribute "srcset" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), srcSet: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('srcset'), equals(null));
    });

    test('should set messy "srcset"', () async {
      await app!.buildChildren(
        widgets: [
          Image(
            key: Key('widget-1'),
            srcSet: 'some srcset',
          ),
          Image(
            key: Key('widget-2'),
            srcSet: 'some "messy" srcset',
          ),
          Image(
            key: Key('widget-3'),
            srcSet: "some 'messy' srcset",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('srcset'),
        equals('some srcset'),
      );

      expect(
        domNode2.getAttribute('srcset'),
        equals('some "messy" srcset'),
      );

      expect(
        domNode3.getAttribute('srcset'),
        equals("some 'messy' srcset"),
      );
    });

    test('should set attribute "width"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), width: 'some-width'),
          Image(key: Key('el-2'), width: 'another-width'),
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
          Image(key: Key('el-1'), width: 'some-width'),
          Image(key: Key('el-2'), width: 'another-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), width: 'updated-width'),
          Image(key: Key('el-2'), width: 'another-width'),
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
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), width: 'another-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2')),
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
          Image(key: Key('el-1'), width: 'some-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), width: null),
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
          Image(key: Key('el-1'), width: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('width'), equals(null));
    });

    test('should set attribute "height"', () async {
      await app!.buildChildren(
        widgets: [
          Image(key: Key('el-1'), height: 'some-height'),
          Image(key: Key('el-2'), height: 'another-height'),
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
          Image(key: Key('el-1'), height: 'some-height'),
          Image(key: Key('el-2'), height: 'another-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), height: 'updated-height'),
          Image(key: Key('el-2'), height: 'another-height'),
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
          Image(key: Key('el-1')),
          Image(key: Key('el-2'), height: 'another-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1')),
          Image(key: Key('el-2')),
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
          Image(key: Key('el-1'), height: 'some-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Image(key: Key('el-1'), height: null),
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
          Image(key: Key('el-1'), height: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('height'), equals(null));
    });
  });
}
