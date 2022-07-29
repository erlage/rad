// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_html_test.dart';

void html_form_test() {
  group('HTML Form tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should set id', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('some-key-1'), id: 'some-id-1'),
          Form(key: Key('some-key-2'), id: 'some-id-2'),
          Form(key: Key('some-key-3'), id: 'some-id-3'),
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
          Form(key: Key('some-key-1'), id: 'some-id-1'),
          Form(key: Key('some-key-2'), id: 'some-id-2'),
          Form(key: Key('some-key-3'), id: 'some-id-3'),
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
          Form(
            key: Key('some-key-1'),
            id: 'some-updated-id',
          ),
          Form(
            key: Key('some-key-2'),
            id: 'some-local-updated-id',
          ),
          Form(
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
          Form(
            key: Key('widget-1'),
            id: 'some id',
          ),
          Form(
            key: Key('widget-2'),
            id: 'some "messy" id',
          ),
          Form(
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
          Form(
            id: 'widget-1',
            children: [
              Form(
                id: 'widget-2',
              ),
              Form(
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
          Form(
            id: 'widget-1',
            child: Form(
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
          Form(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          Form(
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
          Form(
            key: Key('el-1'),
            className: 'some-classes',
          ),
          Form(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(
            key: Key('el-1'),
            className: 'updated-classes',
          ),
          Form(
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
          Form(key: Key('el-1')),
          Form(
            key: Key('el-2'),
            className: 'another-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2')),
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
          Form(
            key: Key('el-1'),
            className: 'some-classes',
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), className: null),
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
          Form(key: Key('el-1'), className: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('class'), equals(null));
    });

    test('should set messy "classes"', () async {
      await app!.buildChildren(
        widgets: [
          Form(
            key: Key('widget-1'),
            className: 'some classes',
          ),
          Form(
            key: Key('widget-2'),
            className: 'some "messy" classes',
          ),
          Form(
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
          Form(key: Key('el-1'), hidden: false),
          Form(key: Key('el-2'), hidden: null),
          Form(key: Key('el-3'), hidden: true),
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
          Form(key: Key('el-1'), hidden: true),
          Form(key: Key('el-2'), hidden: true),
          Form(key: Key('el-3'), hidden: true),
          Form(key: Key('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), hidden: true),
          Form(key: Key('el-2'), hidden: false),
          Form(key: Key('el-3'), hidden: null),
          Form(key: Key('el-4')),
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
          Form(
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
          Form(
            key: Key('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          Form(
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
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), onClick: null),
          Form(key: Key('el-3'), onClick: listener),
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
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), onClick: listener),
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
          Form(key: Key('el-1')),
          Form(key: Key('el-2')),
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
          Form(key: Key('widget-1'), style: 'some style'),
          Form(key: Key('widget-2'), style: 'some "messy" style'),
          Form(key: Key('widget-3'), style: "some 'messy' style"),
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
          Form(key: Key('widget-1'), title: 'some title'),
          Form(key: Key('widget-2'), title: 'some "messy" title'),
          Form(key: Key('widget-3'), title: "some 'messy' title"),
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
          Form(key: Key('some-key-3')),
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
          ].contains('form')
              ? [
                  'input',
                ].contains('form')
                  // because system set attributes for some tags
                  // e.g type="something" for input tag
                  ? '<form'
                  : '<form>'
              : '<form></form>',
        ),
      );
    });

    test(
        'should allow widget attributes to be set through additional attributes',
        () async {
      await app!.buildChildren(
        widgets: [
          Form(
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
          Form(
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
          Form(
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
          Form(
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
          Form(
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
          Form(
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
          Form(
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
          Form(
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
      var widget = Form();
      var widgetShort = form();

      expect(
        widget.runtimeType,
        equals(widgetShort.runtimeType),
      );
    });

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('some-key-1')),
          Form(key: Key('some-key-2')),
          Form(key: Key('some-key-3')),
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
          Form(key: Key('el-1'), name: 'some-name'),
          Form(key: Key('el-2'), name: 'another-name'),
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
          Form(key: Key('el-1'), name: 'some-name'),
          Form(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), name: 'updated-name'),
          Form(key: Key('el-2'), name: 'another-name'),
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
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), name: 'another-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2')),
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
          Form(key: Key('el-1'), name: 'some-name'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), name: null),
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
          Form(key: Key('el-1'), name: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('name'), equals(null));
    });

    test('should set messy "name"', () async {
      await app!.buildChildren(
        widgets: [
          Form(
            key: Key('widget-1'),
            name: 'some name',
          ),
          Form(
            key: Key('widget-2'),
            name: 'some "messy" name',
          ),
          Form(
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

    test('should set attribute "action"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), action: 'some-action'),
          Form(key: Key('el-2'), action: 'another-action'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('action'), equals('some-action'));
      expect(domNode2.getAttribute('action'), equals('another-action'));
    });

    test('should update attribute "action"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), action: 'some-action'),
          Form(key: Key('el-2'), action: 'another-action'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), action: 'updated-action'),
          Form(key: Key('el-2'), action: 'another-action'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('action'), equals('updated-action'));
      expect(domNode2.getAttribute('action'), equals('another-action'));
    });

    test('should clear attribute "action"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), action: 'another-action'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('action'), equals(null));
      expect(domNode2.getAttribute('action'), equals(null));
    });

    test('should clear attribute "action" if updated value is null', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), action: 'some-action'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), action: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('action'), equals(null));
    });

    test('should not set attribute "action" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), action: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('action'), equals(null));
    });

    test('should set messy "action"', () async {
      await app!.buildChildren(
        widgets: [
          Form(
            key: Key('widget-1'),
            action: 'some action',
          ),
          Form(
            key: Key('widget-2'),
            action: 'some "messy" action',
          ),
          Form(
            key: Key('widget-3'),
            action: "some 'messy' action",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('action'),
        equals('some action'),
      );

      expect(
        domNode2.getAttribute('action'),
        equals('some "messy" action'),
      );

      expect(
        domNode3.getAttribute('action'),
        equals("some 'messy' action"),
      );
    });

    test('should set attribute "accept-charset"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), acceptCharset: 'some-accept-charset'),
          Form(key: Key('el-2'), acceptCharset: 'another-accept-charset'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('accept-charset'),
          equals('some-accept-charset'));
      expect(domNode2.getAttribute('accept-charset'),
          equals('another-accept-charset'));
    });

    test('should update attribute "accept-charset"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), acceptCharset: 'some-accept-charset'),
          Form(key: Key('el-2'), acceptCharset: 'another-accept-charset'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), acceptCharset: 'updated-accept-charset'),
          Form(key: Key('el-2'), acceptCharset: 'another-accept-charset'),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('accept-charset'),
          equals('updated-accept-charset'));
      expect(domNode2.getAttribute('accept-charset'),
          equals('another-accept-charset'));
    });

    test('should clear attribute "accept-charset"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), acceptCharset: 'another-accept-charset'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(domNode1.getAttribute('accept-charset'), equals(null));
      expect(domNode2.getAttribute('accept-charset'), equals(null));
    });

    test('should clear attribute "accept-charset" if updated value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), acceptCharset: 'some-accept-charset'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), acceptCharset: null),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('accept-charset'), equals(null));
    });

    test('should not set attribute "accept-charset" if provided value is null',
        () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), acceptCharset: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('accept-charset'), equals(null));
    });

    test('should set messy "accept-charset"', () async {
      await app!.buildChildren(
        widgets: [
          Form(
            key: Key('widget-1'),
            acceptCharset: 'some accept',
          ),
          Form(
            key: Key('widget-2'),
            acceptCharset: 'some "messy" accept',
          ),
          Form(
            key: Key('widget-3'),
            acceptCharset: "some 'messy' accept",
          ),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(
        domNode1.getAttribute('accept-charset'),
        equals('some accept'),
      );

      expect(
        domNode2.getAttribute('accept-charset'),
        equals('some "messy" accept'),
      );

      expect(
        domNode3.getAttribute('accept-charset'),
        equals("some 'messy' accept"),
      );
    });

    test('should set attribute "autocomplete"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), autoComplete: 'some-autocomplete'),
          Form(key: Key('el-2'), autoComplete: 'another-autocomplete'),
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
          Form(key: Key('el-1'), autoComplete: 'some-autocomplete'),
          Form(key: Key('el-2'), autoComplete: 'another-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), autoComplete: 'updated-autocomplete'),
          Form(key: Key('el-2'), autoComplete: 'another-autocomplete'),
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
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), autoComplete: 'another-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2')),
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
          Form(key: Key('el-1'), autoComplete: 'some-autocomplete'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), autoComplete: null),
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
          Form(key: Key('el-1'), autoComplete: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('autocomplete'), equals(null));
    });

    test('should set attribute "rel"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), rel: 'some-rel'),
          Form(key: Key('el-2'), rel: 'another-rel'),
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
          Form(key: Key('el-1'), rel: 'some-rel'),
          Form(key: Key('el-2'), rel: 'another-rel'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), rel: 'updated-rel'),
          Form(key: Key('el-2'), rel: 'another-rel'),
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
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), rel: 'another-rel'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2')),
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
          Form(key: Key('el-1'), rel: 'some-rel'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), rel: null),
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
          Form(key: Key('el-1'), rel: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('rel'), equals(null));
    });

    test('should set attribute "target"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), target: 'some-target'),
          Form(key: Key('el-2'), target: 'another-target'),
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
          Form(key: Key('el-1'), target: 'some-target'),
          Form(key: Key('el-2'), target: 'another-target'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), target: 'updated-target'),
          Form(key: Key('el-2'), target: 'another-target'),
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
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), target: 'another-target'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2')),
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
          Form(key: Key('el-1'), target: 'some-target'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), target: null),
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
          Form(key: Key('el-1'), target: null),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');

      expect(domNode1.getAttribute('target'), equals(null));
    });

    test('should set form attribute "method"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), method: FormMethodType.get),
          Form(key: Key('el-2'), method: FormMethodType.post),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');

      expect(
        domNode1.getAttribute('method'),
        equals(FormMethodType.get.nativeValue),
      );
      expect(
        domNode2.getAttribute('method'),
        equals(FormMethodType.post.nativeValue),
      );
    });

    test('should update form attribute "method"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), method: FormMethodType.get),
          Form(key: Key('el-2'), method: FormMethodType.post),
          Form(key: Key('el-3'), method: FormMethodType.get),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), method: null),
          Form(key: Key('el-3'), method: FormMethodType.post),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(
        domNode1.getAttribute('method'),
        equals(null),
      );
      expect(
        domNode2.getAttribute('method'),
        equals(null),
      );
      expect(
        domNode3.getAttribute('method'),
        equals(FormMethodType.post.nativeValue),
      );
    });

    test('should set form attribute "enctype"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), enctype: FormEncType.textPlain),
          Form(key: Key('el-2'), enctype: FormEncType.multipartFormData),
          Form(
            key: Key('el-3'),
            enctype: FormEncType.applicationXwwwFormUrlEncoded,
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(
        domNode1.getAttribute('enctype'),
        equals('text/plain'),
      );
      expect(
        domNode2.getAttribute('enctype'),
        equals('multipart/form-data'),
      );
      expect(
        domNode3.getAttribute('enctype'),
        equals('application/x-www-form-urlencoded'),
      );
    });

    test('should update form attribute "enctype"', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), enctype: FormEncType.textPlain),
          Form(key: Key('el-2'), enctype: FormEncType.multipartFormData),
          Form(
            key: Key('el-3'),
            enctype: FormEncType.applicationXwwwFormUrlEncoded,
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), enctype: null),
          Form(key: Key('el-3'), enctype: FormEncType.multipartFormData),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('enctype'), equals(null));
      expect(domNode2.getAttribute('enctype'), equals(null));

      expect(
        domNode3.getAttribute('enctype'),
        equals(FormEncType.multipartFormData.nativeValue),
      );
    });

    test('should set attribute "novalidate" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), noValidate: false),
          Form(key: Key('el-2'), noValidate: null),
          Form(key: Key('el-3'), noValidate: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');

      expect(domNode1.getAttribute('novalidate'), equals(null));
      expect(domNode2.getAttribute('novalidate'), equals(null));
      expect(domNode3.getAttribute('novalidate'), equals('true'));
    });

    test('should clear attribute "novalidate" if updated value is not true',
        () async {
      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1'), noValidate: true),
          Form(key: Key('el-2'), noValidate: true),
          Form(key: Key('el-3'), noValidate: true),
          Form(key: Key('el-4'), noValidate: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1'), noValidate: true),
          Form(key: Key('el-2'), noValidate: false),
          Form(key: Key('el-3'), noValidate: null),
          Form(key: Key('el-4')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.domNodeByKeyValue('el-1');
      var domNode2 = app!.domNodeByKeyValue('el-2');
      var domNode3 = app!.domNodeByKeyValue('el-3');
      var domNode4 = app!.domNodeByKeyValue('el-4');

      expect(domNode1.getAttribute('novalidate'), equals('true'));
      expect(domNode2.getAttribute('novalidate'), equals(null));
      expect(domNode3.getAttribute('novalidate'), equals(null));
      expect(domNode4.getAttribute('novalidate'), equals(null));
    });

    test('should set "submit" event listener', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          Form(
            key: Key('el-1'),
            onSubmit: (event) => testStack.push('submit-1'),
          ),
          Form(
            key: Key('el-2'),
            onSubmit: (event) => testStack.push('submit-2'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('el-1').dispatchEvent(Event('submit'));
      app!.domNodeByKeyValue('el-2').dispatchEvent(Event('submit'));

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('submit-1'));
        expect(testStack.popFromStart(), equals('submit-2'));
        expect(testStack.canPop(), equals(false));
      });
    });

    test('should set "submit" event listener only if provided', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), onSubmit: null),
          Form(key: Key('el-3'), onSubmit: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;
      var listeners3 = app!.widgetByKey('el-3').widgetEventListeners;

      expect(listeners1[DomEventType.submit], equals(null));
      expect(listeners2[DomEventType.submit], equals(null));
      expect(listeners3[DomEventType.submit], equals(listener));
    });

    test('should clear "submit" event listener', () async {
      void listener(event) => {};

      await app!.buildChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2'), onSubmit: listener),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      var listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.submit], equals(null));
      expect(listeners2[DomEventType.submit], equals(listener));

      // update

      await app!.updateChildren(
        widgets: [
          Form(key: Key('el-1')),
          Form(key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.submit], equals(null));
      expect(listeners2[DomEventType.submit], equals(null));
    });
  });
}
