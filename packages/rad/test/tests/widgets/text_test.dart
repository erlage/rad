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
          Text('some text', key: GlobalKey('widget')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('some text'));
    });

    test('should update text', () async {
      await app!.buildChildren(
        widgets: [
          Text('some text', key: GlobalKey('widget')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('some text'));

      await app!.updateChildren(
        widgets: [
          Text('updated text', key: GlobalKey('widget')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('updated text'));
    });

    test('should add/remove text', () async {
      await app!.buildChildren(
        widgets: [
          Text('', key: GlobalKey('widget')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents(''));

      await app!.updateChildren(
        widgets: [
          Text('added text', key: GlobalKey('widget')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('added text'));

      await app!.updateChildren(
        widgets: [
          Text('', key: GlobalKey('widget')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents(''));
    });

    // from templates

    test('should set key', () async {
      await app!.buildChildren(
        widgets: [
          Text('', key: GlobalKey('some-key-1')),
          Text('', key: GlobalKey('some-key-2')),
          Text('', key: GlobalKey('some-key-3')),
        ],
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var wO1 = app!.renderElementByGlobalKey('some-key-1')!;
      var wO2 = app!.renderElementByGlobalKey('some-key-2')!;
      var wO3 = app!.renderElementByGlobalKey('some-key-3')!;

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
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

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
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

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
        parentRenderElement: RT_TestBed.rootRenderElement,
      );

      var domNode1 = RT_TestBed.rootDomNode.childNodes[0] as HtmlElement;
      var domNode2 = RT_TestBed.rootDomNode.childNodes[1] as HtmlElement;
      var domNode3 = RT_TestBed.rootDomNode.childNodes[2] as HtmlElement;

      expect(domNode1.getAttribute('class'), equals('some class'));
      expect(domNode2.getAttribute('class'), equals('some "messy" class'));
      expect(domNode3.getAttribute('class'), equals("some 'messy' class"));
    });

    test('should set attribute "hidden" only if its true', () async {
      await app!.buildChildren(
        widgets: [
          Text('', key: GlobalKey('el-1'), hidden: false),
          Text('', key: GlobalKey('el-2'), hidden: null),
          Text('', key: GlobalKey('el-3'), hidden: true),
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
          Text('', key: GlobalKey('el-1'), hidden: true),
          Text('', key: GlobalKey('el-2'), hidden: true),
          Text('', key: GlobalKey('el-3'), hidden: true),
          Text('', key: GlobalKey('el-4'), hidden: true),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Text('', key: GlobalKey('el-1'), hidden: true),
          Text('', key: GlobalKey('el-2'), hidden: false),
          Text('', key: GlobalKey('el-3'), hidden: null),
          Text('', key: GlobalKey('el-4')),
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
          Text(
            '',
            key: GlobalKey('el-1'),
            onClick: (event) => testStack.push('click-1'),
          ),
          Text(
            '',
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
          Text('', key: GlobalKey('el-1')),
          Text('', key: GlobalKey('el-2'), onClick: null),
          Text('', key: GlobalKey('el-3'), onClick: listener),
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
          Text('', key: GlobalKey('el-1')),
          Text('', key: GlobalKey('el-2'), onClick: listener),
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
          Text('', key: GlobalKey('el-1')),
          Text('', key: GlobalKey('el-2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      listeners1 = app!.widgetByGlobalKey('el-1').widgetEventListeners;
      listeners2 = app!.widgetByGlobalKey('el-2').widgetEventListeners;

      expect(listeners1[DomEventType.click], equals(null));
      expect(listeners2[DomEventType.click], equals(null));
    });
  });
}
