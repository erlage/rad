// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

void html_video_test() {
  group('HTML Video tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('some-key-1'), id: 'some-id-1'),
          Video(key: Key('some-key-2'), id: 'some-id-2'),
          Video(key: Key('some-key-3'), id: 'some-id-3'),
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
          Video(key: Key('some-key-1'), id: 'some-id-1'),
          Video(key: Key('some-key-2'), id: 'some-id-2'),
          Video(key: Key('some-key-3'), id: 'some-id-3'),
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
          Video(
            key: Key('some-key-1'),
            id: 'some-updated-id',
          ),
          Video(
            key: Key('some-key-2'),
            id: 'some-local-updated-id',
          ),
          Video(
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
          Video(
            key: Key('widget-1'),
            id: 'some id',
          ),
          Video(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          Video(
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
          Video(
            id: 'widget-1',
            children: [
              Video(
                id: 'widget-2',
              ),
              Video(
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
          Video(
            id: 'widget-1',
            child: Video(
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
          Video(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          Video(
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
          Video(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          Video(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(
            key: Key('el-1'),
            className: 'updated-classes',
          ),
          Video(
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
          Video(key: Key('el-1')),
          Video(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1')),
          Video(key: Key('el-2')),
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
          Video(
            key: Key('el-1'),
            className: 'some-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), className: null),
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
          Video(key: Key('el-1'), className: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          Video(
            key: Key('widget-1'),
            className: 'some classes',
          ),
          Video(
            key: Key('widget-2'),
            className: 'some "messy" classes',
          ),
          Video(
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

    test('should set contentEditable', () async {
      await app!.buildChildren(
        widgets: [
          Video(
            key: Key('widget-1'),
            contentEditable: false,
          ),
          Video(
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
          Video(
            key: Key('widget-1'),
            draggable: false,
          ),
          Video(
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
          Video(key: Key('el-1'), hidden: false),
          Video(key: Key('el-2'), hidden: null),
          Video(key: Key('el-3'), hidden: true),
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
          Video(key: Key('el-1'), hidden: true),
          Video(key: Key('el-2'), hidden: true),
          Video(key: Key('el-3'), hidden: true),
          Video(key: Key('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), hidden: true),
          Video(key: Key('el-2'), hidden: false),
          Video(key: Key('el-3'), hidden: null),
          Video(key: Key('el-4')),
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
          Video(
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
          Video(
            key: Key('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          Video(
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
          Video(key: Key('el-1')),
          Video(key: Key('el-2'), onClick: null),
          Video(key: Key('el-3'), onClick: listener),
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
          Video(key: Key('el-1')),
          Video(key: Key('el-2'), onClick: listener),
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
          Video(key: Key('el-1')),
          Video(key: Key('el-2')),
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
          Video(key: Key('widget-1'), style: 'some style'),
          Video(key: Key('widget-2'), style: 'some "messy" style'),
          Video(key: Key('widget-3'), style: "some 'messy' style"),
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
          Video(
            key: Key('widget-1'),
            tabIndex: 1,
          ),
          Video(
            key: Key('widget-2'),
            tabIndex: 2,
          ),
          Video(
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
          Video(key: Key('widget-1'), title: 'some title'),
          Video(key: Key('widget-2'), title: 'some "messy" title'),
          Video(key: Key('widget-3'), title: "some 'messy' title"),
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
          Video(key: Key('some-key-3')),
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
          ].contains('video')
              ? [
                  'input',
                ].contains('video')
                  // becuase system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<video'
                  : '<video>'
              : '<video></video>',
        ),
      );
    });

    test(
        'should allow widget attributes to be set through additional attributes',
        () async {
      await app!.buildChildren(
        widgets: [
          Video(
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
          Video(
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
          Video(
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
          Video(
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
          Video(
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
          Video(
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
          Video(
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
          Video(
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
      var widget = Video();
      var widgetShort = video();

      expect(
        widget.runtimeType,
        equals(widgetShort.runtimeType),
      );
    });

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('some-key-1')),
          Video(key: Key('some-key-2')),
          Video(key: Key('some-key-3')),
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

    test('should set attribute "autoplay" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), autoPlay: false),
          Video(key: Key('el-2'), autoPlay: null),
          Video(key: Key('el-3'), autoPlay: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('autoplay'), equals(null));
      expect(domNode2.getAttribute('autoplay'), equals(null));
      expect(domNode3.getAttribute('autoplay'), equals('true'));
    });

    test('should clear attribute "autoplay" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), autoPlay: true),
          Video(key: Key('el-2'), autoPlay: true),
          Video(key: Key('el-3'), autoPlay: true),
          Video(key: Key('el-4'), autoPlay: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), autoPlay: true),
          Video(key: Key('el-2'), autoPlay: false),
          Video(key: Key('el-3'), autoPlay: null),
          Video(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('autoplay'), equals('true'));
      expect(domNode2.getAttribute('autoplay'), equals(null));
      expect(domNode3.getAttribute('autoplay'), equals(null));
      expect(domNode4.getAttribute('autoplay'), equals(null));
    });

    test('should set attribute "controls" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), controls: false),
          Video(key: Key('el-2'), controls: null),
          Video(key: Key('el-3'), controls: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('controls'), equals(null));
      expect(domNode2.getAttribute('controls'), equals(null));
      expect(domNode3.getAttribute('controls'), equals('true'));
    });

    test('should clear attribute "controls" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), controls: true),
          Video(key: Key('el-2'), controls: true),
          Video(key: Key('el-3'), controls: true),
          Video(key: Key('el-4'), controls: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), controls: true),
          Video(key: Key('el-2'), controls: false),
          Video(key: Key('el-3'), controls: null),
          Video(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('controls'), equals('true'));
      expect(domNode2.getAttribute('controls'), equals(null));
      expect(domNode3.getAttribute('controls'), equals(null));
      expect(domNode4.getAttribute('controls'), equals(null));
    });

    test('should set form attribute "crossorigin"', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), crossOrigin: CrossOriginType.anonymous),
          Video(key: Key('el-2'), crossOrigin: CrossOriginType.useCredentials),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(
        domNode1.getAttribute('crossorigin'),
        equals(CrossOriginType.anonymous.nativeName),
      );
      expect(
        domNode2.getAttribute('crossorigin'),
        equals(CrossOriginType.useCredentials.nativeName),
      );
    });

    test('should update form attribute "crossorigin"', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), crossOrigin: CrossOriginType.anonymous),
          Video(key: Key('el-2'), crossOrigin: CrossOriginType.useCredentials),
          Video(key: Key('el-3'), crossOrigin: CrossOriginType.anonymous),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1')),
          Video(key: Key('el-2'), crossOrigin: null),
          Video(key: Key('el-3'), crossOrigin: CrossOriginType.useCredentials),
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
        equals(CrossOriginType.useCredentials.nativeName),
      );
    });

    test('should set attribute "height"', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), height: 'some-height'),
          Video(key: Key('el-2'), height: 'another-height'),
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
          Video(key: Key('el-1'), height: 'some-height'),
          Video(key: Key('el-2'), height: 'another-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), height: 'updated-height'),
          Video(key: Key('el-2'), height: 'another-height'),
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
          Video(key: Key('el-1')),
          Video(key: Key('el-2'), height: 'another-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1')),
          Video(key: Key('el-2')),
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
          Video(key: Key('el-1'), height: 'some-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), height: null),
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
          Video(key: Key('el-1'), height: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('height'), equals(null));
    });

    test('should set attribute "loop" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), loop: false),
          Video(key: Key('el-2'), loop: null),
          Video(key: Key('el-3'), loop: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('loop'), equals(null));
      expect(domNode2.getAttribute('loop'), equals(null));
      expect(domNode3.getAttribute('loop'), equals('true'));
    });

    test('should clear attribute "loop" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), loop: true),
          Video(key: Key('el-2'), loop: true),
          Video(key: Key('el-3'), loop: true),
          Video(key: Key('el-4'), loop: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), loop: true),
          Video(key: Key('el-2'), loop: false),
          Video(key: Key('el-3'), loop: null),
          Video(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('loop'), equals('true'));
      expect(domNode2.getAttribute('loop'), equals(null));
      expect(domNode3.getAttribute('loop'), equals(null));
      expect(domNode4.getAttribute('loop'), equals(null));
    });

    test('should set attribute "muted" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), muted: false),
          Video(key: Key('el-2'), muted: null),
          Video(key: Key('el-3'), muted: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('muted'), equals(null));
      expect(domNode2.getAttribute('muted'), equals(null));
      expect(domNode3.getAttribute('muted'), equals('true'));
    });

    test('should clear attribute "muted" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), muted: true),
          Video(key: Key('el-2'), muted: true),
          Video(key: Key('el-3'), muted: true),
          Video(key: Key('el-4'), muted: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), muted: true),
          Video(key: Key('el-2'), muted: false),
          Video(key: Key('el-3'), muted: null),
          Video(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('muted'), equals('true'));
      expect(domNode2.getAttribute('muted'), equals(null));
      expect(domNode3.getAttribute('muted'), equals(null));
      expect(domNode4.getAttribute('muted'), equals(null));
    });

    test('should set attribute "playsinline" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), playsInline: false),
          Video(key: Key('el-2'), playsInline: null),
          Video(key: Key('el-3'), playsInline: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('playsinline'), equals(null));
      expect(domNode2.getAttribute('playsinline'), equals(null));
      expect(domNode3.getAttribute('playsinline'), equals('true'));
    });

    test('should clear attribute "playsinline" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), playsInline: true),
          Video(key: Key('el-2'), playsInline: true),
          Video(key: Key('el-3'), playsInline: true),
          Video(key: Key('el-4'), playsInline: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), playsInline: true),
          Video(key: Key('el-2'), playsInline: false),
          Video(key: Key('el-3'), playsInline: null),
          Video(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('playsinline'), equals('true'));
      expect(domNode2.getAttribute('playsinline'), equals(null));
      expect(domNode3.getAttribute('playsinline'), equals(null));
      expect(domNode4.getAttribute('playsinline'), equals(null));
    });

    test('should set attribute "poster"', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), poster: 'some-poster'),
          Video(key: Key('el-2'), poster: 'another-poster'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('poster'), equals('some-poster'));
      expect(domNode2.getAttribute('poster'), equals('another-poster'));
    });

    test('should update attribute "poster"', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), poster: 'some-poster'),
          Video(key: Key('el-2'), poster: 'another-poster'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), poster: 'updated-poster'),
          Video(key: Key('el-2'), poster: 'another-poster'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('poster'), equals('updated-poster'));
      expect(domNode2.getAttribute('poster'), equals('another-poster'));
    });

    test('should clear attribute "poster"', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1')),
          Video(key: Key('el-2'), poster: 'another-poster'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1')),
          Video(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('poster'), equals(null));
      expect(domNode2.getAttribute('poster'), equals(null));
    });

    test('should clear attribute "poster" if updated poster is null', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), poster: 'some-poster'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), poster: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('poster'), equals(null));
    });

    test('should not set attribute "poster" if provided poster is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), poster: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('poster'), equals(null));
    });

    test('should set ordered list attribute "preload"', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), preload: PreloadType.none),
          Video(key: Key('el-2'), preload: PreloadType.metaData),
          Video(key: Key('el-3'), preload: PreloadType.auto),
          Video(key: Key('el-4'), preload: PreloadType.empty),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(
        domNode1.getAttribute('preload'),
        equals(PreloadType.none.nativeName),
      );
      expect(
        domNode2.getAttribute('preload'),
        equals(PreloadType.metaData.nativeName),
      );
      expect(
        domNode3.getAttribute('preload'),
        equals(PreloadType.auto.nativeName),
      );
      expect(
        domNode4.getAttribute('preload'),
        equals(PreloadType.empty.nativeName),
      );
    });

    test('should update ordered list attribute "preload"', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), preload: PreloadType.none),
          Video(key: Key('el-2'), preload: PreloadType.metaData),
          Video(key: Key('el-3'), preload: PreloadType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1')),
          Video(key: Key('el-2'), preload: null),
          Video(key: Key('el-3'), preload: PreloadType.empty),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(
        domNode1.getAttribute('preload'),
        equals(null),
      );
      expect(
        domNode2.getAttribute('preload'),
        equals(null),
      );
      expect(
        domNode3.getAttribute('preload'),
        equals(PreloadType.empty.nativeName),
      );
    });

    test('should set attribute "src"', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), src: 'some-src'),
          Video(key: Key('el-2'), src: 'another-src'),
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
          Video(key: Key('el-1'), src: 'some-src'),
          Video(key: Key('el-2'), src: 'another-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), src: 'updated-src'),
          Video(key: Key('el-2'), src: 'another-src'),
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
          Video(key: Key('el-1')),
          Video(key: Key('el-2'), src: 'another-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1')),
          Video(key: Key('el-2')),
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
          Video(key: Key('el-1'), src: 'some-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), src: null),
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
          Video(key: Key('el-1'), src: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('src'), equals(null));
    });

    test('should set attribute "width"', () async {
      await app!.buildChildren(
        widgets: [
          Video(key: Key('el-1'), width: 'some-width'),
          Video(key: Key('el-2'), width: 'another-width'),
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
          Video(key: Key('el-1'), width: 'some-width'),
          Video(key: Key('el-2'), width: 'another-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), width: 'updated-width'),
          Video(key: Key('el-2'), width: 'another-width'),
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
          Video(key: Key('el-1')),
          Video(key: Key('el-2'), width: 'another-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1')),
          Video(key: Key('el-2')),
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
          Video(key: Key('el-1'), width: 'some-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Video(key: Key('el-1'), width: null),
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
          Video(key: Key('el-1'), width: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('width'), equals(null));
    });
  });
}
