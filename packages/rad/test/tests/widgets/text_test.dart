// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  group('Text widget tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should render text', () async {
      await app!.buildChildren(
        widgets: [
          Text('some text', key: Key('widget')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents('some text'));
    });

    test('should update text', () async {
      await app!.buildChildren(
        widgets: [
          Text('some text', key: Key('widget')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents('some text'));

      await app!.updateChildren(
        widgets: [
          Text('updated text', key: Key('widget')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents('updated text'));
    });

    test('should add/remove text', () async {
      await app!.buildChildren(
        widgets: [
          Text('', key: Key('widget')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents(''));

      await app!.updateChildren(
        widgets: [
          Text('added text', key: Key('widget')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents('added text'));

      await app!.updateChildren(
        widgets: [
          Text('', key: Key('widget')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.appDomNode, RT_hasContents(''));
    });

    // from templates

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          Text('', key: Key('some-key-1')),
          Text('', key: Key('some-key-2')),
          Text('', key: Key('some-key-3')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var wO1 = app!.renderElementByKeyValue('some-key-1')!;
      var wO2 = app!.renderElementByKeyValue('some-key-2')!;
      var wO3 = app!.renderElementByKeyValue('some-key-3')!;

      expect(wO1.key?.frameworkValue, endsWith('some-key-1'));
      expect(wO2.key?.frameworkValue, endsWith('some-key-2'));
      expect(wO3.key?.frameworkValue, endsWith('some-key-3'));
    });

    test('should set title', () async {
      await app!.buildChildren(
        widgets: [
          Text('', key: Key('widget-1'), title: 'some title'),
          Text('', key: Key('widget-2'), title: 'some "messy" title'),
          Text('', key: Key('widget-3'), title: "some 'messy' title"),
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

    test('should set style', () async {
      await app!.buildChildren(
        widgets: [
          Text('', key: Key('widget-1'), style: 'some style'),
          Text('', key: Key('widget-2'), style: 'some "messy" style'),
          Text('', key: Key('widget-3'), style: "some 'messy' style"),
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

    test('should set classes', () async {
      await app!.buildChildren(
        widgets: [
          Text('', classAttribute: 'some class'),
          Text('', classAttribute: 'some "messy" class'),
          Text('', classAttribute: "some 'messy' class"),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

      expect(domNode1.getAttribute('class'), equals('some class'));
      expect(domNode2.getAttribute('class'), equals('some "messy" class'));
      expect(domNode3.getAttribute('class'), equals("some 'messy' class"));
    });

    test('should set attribute "hidden" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Text('', key: Key('el-1'), hidden: false),
          Text('', key: Key('el-2'), hidden: null),
          Text('', key: Key('el-3'), hidden: true),
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
          Text('', key: Key('el-1'), hidden: true),
          Text('', key: Key('el-2'), hidden: true),
          Text('', key: Key('el-3'), hidden: true),
          Text('', key: Key('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Text('', key: Key('el-1'), hidden: true),
          Text('', key: Key('el-2'), hidden: false),
          Text('', key: Key('el-3'), hidden: null),
          Text('', key: Key('el-4')),
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

    test('should set onClick', () async {
      await app!.buildChildren(
        widgets: [
          Text(
            '',
            key: Key('widget-1'),
            onClickAttribute: 'some onClick',
          ),
          Text(
            '',
            key: Key('widget-2'),
            onClickAttribute: 'some "messy" onClick',
          ),
          Text(
            '',
            key: Key('widget-3'),
            onClickAttribute: "some 'messy' onClick",
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var domNode1 = app!.appDomNode.childNodes[0] as HtmlElement;
      var domNode2 = app!.appDomNode.childNodes[1] as HtmlElement;
      var domNode3 = app!.appDomNode.childNodes[2] as HtmlElement;

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
          Text(
            '',
            key: Key('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          Text(
            '',
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
          Text('', key: Key('el-1')),
          Text('', key: Key('el-2'), onClick: null),
          Text('', key: Key('el-3'), onClick: listener),
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
          Text('', key: Key('el-1')),
          Text('', key: Key('el-2'), onClick: listener),
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
          Text('', key: Key('el-1')),
          Text('', key: Key('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(null));
    });
  });
}
