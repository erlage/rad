// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

void html_i_frame_test() {
  group('HTML IFrame tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('some-key-1'), id: 'some-id-1'),
          IFrame(key: Key('some-key-2'), id: 'some-id-2'),
          IFrame(key: Key('some-key-3'), id: 'some-id-3'),
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
          IFrame(key: Key('some-key-1'), id: 'some-id-1'),
          IFrame(key: Key('some-key-2'), id: 'some-id-2'),
          IFrame(key: Key('some-key-3'), id: 'some-id-3'),
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
          IFrame(
            key: Key('some-key-1'),
            id: 'some-updated-id',
          ),
          IFrame(
            key: Key('some-key-2'),
            id: 'some-local-updated-id',
          ),
          IFrame(
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
          IFrame(
            key: Key('widget-1'),
            id: 'some id',
          ),
          IFrame(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          IFrame(
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
          IFrame(
            id: 'widget-1',
            children: [
              IFrame(
                id: 'widget-2',
              ),
              IFrame(
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
          IFrame(
            id: 'widget-1',
            child: IFrame(
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
          IFrame(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          IFrame(
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
          IFrame(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          IFrame(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(
            key: Key('el-1'),
            className: 'updated-classes',
          ),
          IFrame(
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
          IFrame(key: Key('el-1')),
          IFrame(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2')),
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
          IFrame(
            key: Key('el-1'),
            className: 'some-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), className: null),
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
          IFrame(key: Key('el-1'), className: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(
            key: Key('widget-1'),
            className: 'some classes',
          ),
          IFrame(
            key: Key('widget-2'),
            className: 'some "messy" classes',
          ),
          IFrame(
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
          IFrame(key: Key('el-1'), hidden: false),
          IFrame(key: Key('el-2'), hidden: null),
          IFrame(key: Key('el-3'), hidden: true),
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
          IFrame(key: Key('el-1'), hidden: true),
          IFrame(key: Key('el-2'), hidden: true),
          IFrame(key: Key('el-3'), hidden: true),
          IFrame(key: Key('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), hidden: true),
          IFrame(key: Key('el-2'), hidden: false),
          IFrame(key: Key('el-3'), hidden: null),
          IFrame(key: Key('el-4')),
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
          IFrame(
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
          IFrame(
            key: Key('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          IFrame(
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
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2'), onClick: null),
          IFrame(key: Key('el-3'), onClick: listener),
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
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2'), onClick: listener),
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
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2')),
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
          IFrame(key: Key('widget-1'), style: 'some style'),
          IFrame(key: Key('widget-2'), style: 'some "messy" style'),
          IFrame(key: Key('widget-3'), style: "some 'messy' style"),
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
          IFrame(key: Key('widget-1'), title: 'some title'),
          IFrame(key: Key('widget-2'), title: 'some "messy" title'),
          IFrame(key: Key('widget-3'), title: "some 'messy' title"),
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
          IFrame(key: Key('some-key-3')),
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
          ].contains('iframe')
              ? [
                  'input',
                ].contains('iframe')
                  // becuase system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<iframe'
                  : '<iframe>'
              : '<iframe></iframe>',
        ),
      );
    });

    test(
        'should allow widget attributes to be set through additional attributes',
        () async {
      await app!.buildChildren(
        widgets: [
          IFrame(
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
          IFrame(
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
          IFrame(
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
          IFrame(
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
          IFrame(
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
          IFrame(
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
          IFrame(
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
          IFrame(
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
      var widget = IFrame();
      var widgetShort = iframe();

      expect(
        widget.runtimeType,
        equals(widgetShort.runtimeType),
      );
    });

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('some-key-1')),
          IFrame(key: Key('some-key-2')),
          IFrame(key: Key('some-key-3')),
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

    test('should set attribute "name"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), name: 'some-name'),
          IFrame(key: Key('el-2'), name: 'another-name'),
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
          IFrame(key: Key('el-1'), name: 'some-name'),
          IFrame(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), name: 'updated-name'),
          IFrame(key: Key('el-2'), name: 'another-name'),
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
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2')),
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
          IFrame(key: Key('el-1'), name: 'some-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), name: null),
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
          IFrame(key: Key('el-1'), name: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('name'), equals(null));
    });

    test('should set messy "name"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(
            key: Key('widget-1'),
            name: 'some name',
          ),
          IFrame(
            key: Key('widget-2'),
            name: 'some "messy" name',
          ),
          IFrame(
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

    test('should set attribute "allow"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), allow: 'some-allow'),
          IFrame(key: Key('el-2'), allow: 'another-allow'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('allow'), equals('some-allow'));
      expect(domNode2.getAttribute('allow'), equals('another-allow'));
    });

    test('should update attribute "allow"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), allow: 'some-allow'),
          IFrame(key: Key('el-2'), allow: 'another-allow'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), allow: 'updated-allow'),
          IFrame(key: Key('el-2'), allow: 'another-allow'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('allow'), equals('updated-allow'));
      expect(domNode2.getAttribute('allow'), equals('another-allow'));
    });

    test('should clear attribute "allow"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2'), allow: 'another-allow'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('allow'), equals(null));
      expect(domNode2.getAttribute('allow'), equals(null));
    });

    test('should clear attribute "allow" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), allow: 'some-allow'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), allow: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('allow'), equals(null));
    });

    test('should not set attribute "allow" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), allow: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('allow'), equals(null));
    });

    test('should set attribute "src"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), src: 'some-src'),
          IFrame(key: Key('el-2'), src: 'another-src'),
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
          IFrame(key: Key('el-1'), src: 'some-src'),
          IFrame(key: Key('el-2'), src: 'another-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), src: 'updated-src'),
          IFrame(key: Key('el-2'), src: 'another-src'),
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
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2'), src: 'another-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2')),
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
          IFrame(key: Key('el-1'), src: 'some-src'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), src: null),
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
          IFrame(key: Key('el-1'), src: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('src'), equals(null));
    });

    test('should set attribute "srcdoc"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), srcDoc: 'some-srcdoc'),
          IFrame(key: Key('el-2'), srcDoc: 'another-srcdoc'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('srcdoc'), equals('some-srcdoc'));
      expect(domNode2.getAttribute('srcdoc'), equals('another-srcdoc'));
    });

    test('should update attribute "srcdoc"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), srcDoc: 'some-srcdoc'),
          IFrame(key: Key('el-2'), srcDoc: 'another-srcdoc'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), srcDoc: 'updated-srcdoc'),
          IFrame(key: Key('el-2'), srcDoc: 'another-srcdoc'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('srcdoc'), equals('updated-srcdoc'));
      expect(domNode2.getAttribute('srcdoc'), equals('another-srcdoc'));
    });

    test('should clear attribute "srcdoc"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2'), srcDoc: 'another-srcdoc'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('srcdoc'), equals(null));
      expect(domNode2.getAttribute('srcdoc'), equals(null));
    });

    test('should clear attribute "srcdoc" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), srcDoc: 'some-srcdoc'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), srcDoc: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('srcdoc'), equals(null));
    });

    test('should not set attribute "srcdoc" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), srcDoc: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('srcdoc'), equals(null));
    });

    test('should set messy "srcdoc"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(
            key: Key('widget-1'),
            srcDoc: 'some srcdoc',
          ),
          IFrame(
            key: Key('widget-2'),
            srcDoc: 'some "messy" srcdoc',
          ),
          IFrame(
            key: Key('widget-3'),
            srcDoc: "some 'messy' srcdoc",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('srcdoc'),
        equals('some srcdoc'),
      );

      expect(
        domNode2.getAttribute('srcdoc'),
        equals('some "messy" srcdoc'),
      );

      expect(
        domNode3.getAttribute('srcdoc'),
        equals("some 'messy' srcdoc"),
      );
    });

    test('should set attribute "width"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), width: 'some-width'),
          IFrame(key: Key('el-2'), width: 'another-width'),
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
          IFrame(key: Key('el-1'), width: 'some-width'),
          IFrame(key: Key('el-2'), width: 'another-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), width: 'updated-width'),
          IFrame(key: Key('el-2'), width: 'another-width'),
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
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2'), width: 'another-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2')),
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
          IFrame(key: Key('el-1'), width: 'some-width'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), width: null),
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
          IFrame(key: Key('el-1'), width: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('width'), equals(null));
    });

    test('should set attribute "height"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), height: 'some-height'),
          IFrame(key: Key('el-2'), height: 'another-height'),
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
          IFrame(key: Key('el-1'), height: 'some-height'),
          IFrame(key: Key('el-2'), height: 'another-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), height: 'updated-height'),
          IFrame(key: Key('el-2'), height: 'another-height'),
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
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2'), height: 'another-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2')),
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
          IFrame(key: Key('el-1'), height: 'some-height'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), height: null),
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
          IFrame(key: Key('el-1'), height: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('height'), equals(null));
    });

    test('should set attribute "allowFullscreen" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), allowFullscreen: false),
          IFrame(key: Key('el-2'), allowFullscreen: null),
          IFrame(key: Key('el-3'), allowFullscreen: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('allowfullscreen'), equals(null));
      expect(domNode2.getAttribute('allowfullscreen'), equals(null));
      expect(domNode3.getAttribute('allowfullscreen'), equals('true'));
    });

    test(
        'should clear attribute "allowFullscreen" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), allowFullscreen: true),
          IFrame(key: Key('el-2'), allowFullscreen: true),
          IFrame(key: Key('el-3'), allowFullscreen: true),
          IFrame(key: Key('el-4'), allowFullscreen: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), allowFullscreen: true),
          IFrame(key: Key('el-2'), allowFullscreen: false),
          IFrame(key: Key('el-3'), allowFullscreen: null),
          IFrame(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('allowfullscreen'), equals('true'));
      expect(domNode2.getAttribute('allowfullscreen'), equals(null));
      expect(domNode3.getAttribute('allowfullscreen'), equals(null));
      expect(domNode4.getAttribute('allowfullscreen'), equals(null));
    });

    test('should set attribute "allowPaymentRequest" only if its true',
        () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), allowPaymentRequest: false),
          IFrame(key: Key('el-2'), allowPaymentRequest: null),
          IFrame(key: Key('el-3'), allowPaymentRequest: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('allowpaymentrequest'), equals(null));
      expect(domNode2.getAttribute('allowpaymentrequest'), equals(null));
      expect(domNode3.getAttribute('allowpaymentrequest'), equals('true'));
    });

    test(
        'should clear attribute "allowPaymentRequest" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), allowPaymentRequest: true),
          IFrame(key: Key('el-2'), allowPaymentRequest: true),
          IFrame(key: Key('el-3'), allowPaymentRequest: true),
          IFrame(key: Key('el-4'), allowPaymentRequest: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1'), allowPaymentRequest: true),
          IFrame(key: Key('el-2'), allowPaymentRequest: false),
          IFrame(key: Key('el-3'), allowPaymentRequest: null),
          IFrame(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('allowpaymentrequest'), equals('true'));
      expect(domNode2.getAttribute('allowpaymentrequest'), equals(null));
      expect(domNode3.getAttribute('allowpaymentrequest'), equals(null));
      expect(domNode4.getAttribute('allowpaymentrequest'), equals(null));
    });

    test('should set attribute "fetchpriority"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(key: Key('el-1'), fetchPriority: FetchPriorityType.high),
          IFrame(key: Key('el-2'), fetchPriority: FetchPriorityType.low),
          IFrame(key: Key('el-3'), fetchPriority: FetchPriorityType.auto),
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
          IFrame(key: Key('el-1'), fetchPriority: FetchPriorityType.high),
          IFrame(key: Key('el-2'), fetchPriority: FetchPriorityType.low),
          IFrame(key: Key('el-3'), fetchPriority: FetchPriorityType.auto),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2'), fetchPriority: null),
          IFrame(key: Key('el-3'), fetchPriority: FetchPriorityType.high),
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

    test('should set attribute "referrerpolicy"', () async {
      await app!.buildChildren(
        widgets: [
          IFrame(
              key: Key('el-1'), referrerPolicy: ReferrerPolicyType.noReferrer),
          IFrame(
              key: Key('el-2'),
              referrerPolicy: ReferrerPolicyType.noReferrerWhenDowngrade),
          IFrame(key: Key('el-3'), referrerPolicy: ReferrerPolicyType.origin),
          IFrame(
              key: Key('el-4'),
              referrerPolicy: ReferrerPolicyType.originWhenCrossOrigin),
          IFrame(
              key: Key('el-5'), referrerPolicy: ReferrerPolicyType.sameOrigin),
          IFrame(
              key: Key('el-6'),
              referrerPolicy: ReferrerPolicyType.strictOrigin),
          IFrame(
              key: Key('el-7'),
              referrerPolicy: ReferrerPolicyType.strictOriginWhenCrossOrigin),
          IFrame(
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
          IFrame(
              key: Key('el-1'), referrerPolicy: ReferrerPolicyType.noReferrer),
          IFrame(
              key: Key('el-2'),
              referrerPolicy: ReferrerPolicyType.noReferrerWhenDowngrade),
          IFrame(key: Key('el-3'), referrerPolicy: ReferrerPolicyType.origin),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          IFrame(key: Key('el-1')),
          IFrame(key: Key('el-2'), referrerPolicy: null),
          IFrame(
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
  });
}
